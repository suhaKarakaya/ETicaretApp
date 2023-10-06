//
//  NewProductTableViewCell.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 5.10.2023.
//

import UIKit
import SnapKit

protocol ProductTableViewCellDelegate {
    func showAlert(_ msg: String)
    func addCart(_ count: String, data: Yemekler)
}

class ProductTableViewCell: UITableViewCell {
    
    private lazy var optionBackgroundView: UIView = {
        let view = UIView()
        view.addShadow()
        return view
    }()
    private lazy var imageViewProduct: UIImageView = {
        let view = UIImageView(image: .add)
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 5
        return view
    }()
    private lazy var labelYemekAdi: UILabel = {
        let label = UILabel()
        label.text = "Ayran"
        label.font = label.font.withSize(20)
        return label
    }()
    private lazy var labelYemekFiyat: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = label.font.withSize(15)
        return label
    }()
    private lazy var labelStok: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = label.font.withSize(15)
        return label
    }()
    private lazy var addCartButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .purple
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private lazy var hCountStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            removeButton,
            labelCount,
            addButton
        ])
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillEqually
        return view
    }()
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(.remove, for: .normal)
        return button
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(.add, for: .normal)
        return button
    }()
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            addCartButton,
            hCountStackView
        ])
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillEqually
        return view
    }()
    private lazy var labelCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    private var productCartCount = 0
    var delegate: ProductTableViewCellDelegate? = nil
    
    public var data: Yemekler? {
        didSet {
            if let m = data {
                labelYemekAdi.text = m.yemekAdi ?? ""
                labelYemekFiyat.text = "Price: " + (m.yemekFiyat ?? "")
                labelStok.text = "Stock: " + m.stock.stringValue
                labelCount.text = "0"
                productCartCount = 0
                imageViewProduct.kf.setImage(with: "\(Constants.kGETALLIMAGESLINK)\(m.yemekResimAdi ?? "")".asUrl)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = . none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        
        contentView.addSubview(optionBackgroundView)
        
        optionBackgroundView.addSubview(imageViewProduct)
        optionBackgroundView.addSubview(labelYemekAdi)
        optionBackgroundView.addSubview(labelYemekFiyat)
        optionBackgroundView.addSubview(labelStok)
        optionBackgroundView.addSubview(hStackView)
        
        
        
        addButton.addTarget(self, action: #selector(addQuantity), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeQuantity), for: .touchUpInside)
        addCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        setupConstraints()
        
        
    }
    
    private func setupConstraints(){
        optionBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        imageViewProduct.snp.makeConstraints { make in
            make.top.equalTo(optionBackgroundView.snp.top).inset(10)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        labelYemekAdi.snp.makeConstraints { make in
            make.left.equalTo(optionBackgroundView.snp.left).offset(20)
            make.right.equalTo(optionBackgroundView.snp.right).offset(-10)
            make.top.equalTo(imageViewProduct.snp.bottom).offset(10)
        }
        labelYemekFiyat.snp.makeConstraints { make in
            make.left.equalTo(optionBackgroundView.snp.left).offset(20)
            make.right.equalTo(optionBackgroundView.snp.right).offset(-10)
            make.top.equalTo(labelYemekAdi.snp.bottom).offset(10)
        }
        labelStok.snp.makeConstraints { make in
            make.left.equalTo(optionBackgroundView.snp.left).offset(20)
            make.right.equalTo(optionBackgroundView.snp.right).offset(-10)
            make.top.equalTo(labelYemekFiyat.snp.bottom).offset(10)
        }
        hStackView.snp.makeConstraints { make in
            make.left.equalTo(optionBackgroundView.snp.left).offset(10)
            make.right.equalTo(optionBackgroundView.snp.right).offset(-10)
            make.top.equalTo(labelStok.snp.bottom).offset(10)
            make.bottom.equalTo(optionBackgroundView.snp.bottom).inset(10)
            make.height.equalTo(50)
        }
    }
    
    @objc func addQuantity() {
        if data?.stock ?? 0 > 0 && data?.stock ?? 0 > productCartCount {
            productCartCount += 1
            labelCount.text = productCartCount.stringValue
        } else {
            delegate?.showAlert("We don't have enough products in stock!")
        }
    }
    
    @objc func removeQuantity() {
        if productCartCount > 0 {
            productCartCount -= 1
            labelCount.text = productCartCount.stringValue
        } else {
            
        }
    }
    
    @objc func addToCart() {
        if productCartCount > 0 {
            guard let data = data else { return }
            delegate?.addCart(labelCount.text ?? "0", data: data)
        } else {
            delegate?.showAlert("Please select quantity!")
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
