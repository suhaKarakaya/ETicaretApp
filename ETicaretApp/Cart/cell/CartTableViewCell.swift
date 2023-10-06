//
//  NewCartTableViewCell.swift
//  ETicaretApp
//
//  Created by Süha Karakaya on 5.10.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol CartTableViewCellDelegate {
    func deleteCart(data: SepetYemekler)
}

class CartTableViewCell: UITableViewCell {
    
    private lazy var optionBackgroundView: UIView = {
        let view = UIView()
        view.addShadow()
        return view
    }()
    private lazy var hSuperStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            ivProduct,
            vStackViewProduct,
            buttonDeleteProduct
        ])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 15
        return view
    }()
    private let ivProduct: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let labelProduct = UILabel()
    private let labelProductStock = UILabel()
    
    private lazy var vStackViewProduct: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            labelProduct,
            labelProductStock
        ])
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    private let buttonDeleteProduct: UIButton = {
        let button = UIButton()
        button.setImage(.trash, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private let labelProductCount: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            hSuperStackView,
            viewLine,
            labelProductCost
        ])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    private let labelProductCost: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        return label
        
    }()
    private let viewLine: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var delegate: CartTableViewCellDelegate? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = . none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(optionBackgroundView)
        optionBackgroundView.addSubview(vStackView)
        
        buttonDeleteProduct.addTarget(self, action: #selector(removeProduct), for: .touchUpInside)
        
        setupConstraints()
        
    }
    
    public var data: SepetYemekler? {
        didSet {
            if let m = data {
                labelProduct.text = m.yemekAdi
                labelProductStock.text = "Quantity: " + m.adet.stringValue
                labelProductCost.text = "Price: " + (( m.yemekFiyat?.toInt ?? 0) * (m.adet)).stringValue
                
                ivProduct.kf.setImage(with: "\(Constants.kGETALLIMAGESLINK)\(m.yemekResimAdi ?? "")".asUrl)
                labelProductCount.text = m.adet.stringValue
            }
        }
    }
    

    
    private func setupConstraints(){
        
        optionBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        vStackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        hSuperStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        ivProduct.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.left.equalToSuperview().offset(5)
        }
        
        labelProductCost.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(15)
        }

        buttonDeleteProduct.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.bottom.equalToSuperview().offset(-10)
        }
        viewLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        

    }
    
    
    @objc func removeProduct() {
        guard let data = data else { return }
        delegate?.deleteCart(data: data)
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
