//
//  ShoppingListTableViewCell.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/25.
//

import UIKit

import SnapKit

class ShoppingListTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cell")
        
        self.accessoryType = .disclosureIndicator
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = ColorDesign.customLightGray
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let miniCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = ColorDesign.customDarkGray
        return imageView
    }()
    
    let miniBookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = ColorDesign.customDarkGray
        return imageView
    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "딸기 구매하기"
        label.textColor = ColorDesign.customBlack
        label.font = UIFont(name: FontDesign.medium, size: 16)
        return label
    }()
    
    func addViews() {
        [itemImageView, itemNameLabel, miniCheckImageView, miniBookmarkImageView].forEach { self.addSubview($0) }
    }
    
    func addConstraints() {
        itemImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(self).inset(10)
            $0.leading.equalTo(24)
            $0.width.equalTo(100 - 10 * 2)
        }
        
        itemNameLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.leading.equalTo(120)
            $0.trailing.equalTo(-10)
            $0.height.equalTo(20)
        }
        
        miniCheckImageView.snp.makeConstraints {
            $0.bottom.equalTo(-20)
            $0.width.height.equalTo(20)
            $0.leading.equalTo(120)
        }
        
        miniBookmarkImageView.snp.makeConstraints {
            $0.bottom.equalTo(-20)
            $0.width.height.equalTo(20)
            $0.leading.equalTo(120 + 20 + 5)
        }
    }
}
