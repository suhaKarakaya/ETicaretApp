//
//  NewCartViewController.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 5.10.2023.
//

import UIKit
import SnapKit

protocol CartViewControllerInterface: AnyObject, SpinnerProtocol, AlertProtocol {
    func setTableViewData(foods: [SepetYemekler], value: String)
    func showNoRecord(flag: Bool)
    func emptyTableAndDismiss()
    func getCartData()
}

class CartViewController: UIViewController {
    private let cartListReuseIdentifier = "cartListReuseIdentifier"
    private let tableView: UITableView =  UITableView()
    private let buttonConfirmCart: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm Basket", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .purple
        return button
    }()
    private let labelTotalCost: UILabel = {
        let label = UILabel()
        label.text = "Total: 0"
        return label
    }()
    private let labelNoRecord: UILabel = {
       let label = UILabel()
        label.text = "You haven't added anything to your cart!"
        label.isHidden = true
        return label
    }()
    private lazy var viewModel = CartViewModel()
    public var tableViewList: [SepetYemekler] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self

        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "Cart"
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        generateUI()
    }
    
 
    @objc func buttonConfirmClicked() {
        viewModel.basketControl(tableViewList, "Are you sure you want to confirm your cart?")

    }
    
}
extension CartViewController {
    
    private func generateUI(){
        viewModel.calculateTotalAndDisplayTableView(tableViewList)
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 9)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: cartListReuseIdentifier)
        view.addSubview(tableView)
        view.addSubview(buttonConfirmCart)
        view.addSubview(labelTotalCost)
        view.addSubview(labelNoRecord)
        
        buttonConfirmCart.addTarget(self, action: #selector(buttonConfirmClicked), for: .touchUpInside)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(buttonConfirmCart.snp.top).inset(10)
        }
        
        labelTotalCost.snp.makeConstraints { make in
            make.bottomMargin.equalTo(buttonConfirmCart.snp.top).offset(-15)
            make.leading.equalTo(20)
            make.height.equalTo(30)
            make.trailing.equalTo(-10)
        }
        
        buttonConfirmCart.snp.makeConstraints { make in
            make.bottom.equalTo(-40)
            make.leading.equalTo(10)
            make.height.equalTo(50)
            make.trailing.equalTo(-10)
        }
        labelNoRecord.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cartListReuseIdentifier, for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        cell.data = tableViewList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

extension CartViewController: CartTableViewCellDelegate {
    func deleteCart(data: SepetYemekler) {
        let tempList: [SepetYemekler] = [data]
        self.viewModel.basketControl(tempList, "Are you sure you want to remove it from the cart?")
    }
    
    
}

extension CartViewController: CartViewControllerInterface {
    func getCartData() {
        viewModel.refreshData()
    }
    
    func emptyTableAndDismiss() {
        setTableViewData(foods: [], value: "0")
        showDefaultCompletionAlert(title: "Info", msg: "Your order has been confirmed:)", buttonTitle: "Ok") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setTableViewData(foods: [SepetYemekler], value: String) {
        showNoRecord(flag: foods.isEmpty)
        labelTotalCost.text = "Total: " + value
        tableViewList = foods
        tableView.reloadData()
    }
    
    func showNoRecord(flag: Bool) {
        labelNoRecord.isHidden = !flag
        tableView.isHidden = flag
        labelTotalCost.isHidden = flag
        buttonConfirmCart.isHidden = flag
    }
}
