//
//  NewProductListViewController.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 5.10.2023.
//

import UIKit
import SnapKit

protocol ProductListViewControllerInterface: AnyObject, SpinnerProtocol, AlertProtocol {
    func setTableViewData(tbList: [Yemekler], cartList: [SepetYemekler])
    func showErrorMessage(_ msg: String)
    func refreshList()
}

class ProductListViewController: UIViewController {
    
    private let productListReuseIdentifier = "productListReuseIdentifier"
    private var tableViewList: [Yemekler] = []
    private var toCartList: [SepetYemekler] = []
    private lazy var viewModel = ProductListViewModel()
    
    
    private let cartBarButtonItem = UIBarButtonItem()
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self

        view.backgroundColor = .white
        
        self.navigationItem.title = "Product"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30), NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(goToCart), imageName: .cart.withRenderingMode(.alwaysOriginal))
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        generateUI()
    }
    
    
    @objc func goToCart() {
        let nextViewController = CartViewController()
        nextViewController.tableViewList = toCartList
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

extension ProductListViewController: ProductListViewControllerInterface {
    func refreshList() {
        showDefaultCompletionAlert(title: "Info", msg: "Product added to cart:)", buttonTitle: "Ok") {
            self.viewModel.getProductList()
        }
    }
    

    func setTableViewData(tbList: [Yemekler], cartList: [SepetYemekler]) {
        tableViewList = tbList
        toCartList = cartList
        tableView.reloadData()
    }
    
    func showErrorMessage(_ msg: String) {
        showDefaultAlert(title: "Warning", msg: msg, buttonTitle: "Ok")
    }
    
    
}

extension ProductListViewController {
    
    private func generateUI(){
        viewModel.getProductList()
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 9)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: productListReuseIdentifier)
        view.addSubview (tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
    }
}

extension ProductListViewController: ProductTableViewCellDelegate {
    func addCart(_ count: String, data: Yemekler) {
        showCompletionAlert(title: "Info", msg: "Are you sure you want to add it to the cart?", buttonTitle1: "Yes", buttonTitle2: "No") { isConfirm in
            if isConfirm {
                self.viewModel.setCartData(data, count)
            }
        }
    }
    
    func showAlert(_ msg: String) {
        showDefaultAlert(title: "Warning", msg: msg, buttonTitle: "Ok")
    }
    
    
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: productListReuseIdentifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.data = tableViewList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}
