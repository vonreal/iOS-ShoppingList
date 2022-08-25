//
//  AddingItemView.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/26.
//

import UIKit

import SnapKit
import TextFieldEffects

class AddingItemView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.borderColor = ColorDesign.customLightGray?.cgColor
//        imageView.layer.borderWidth = 2
        imageView.backgroundColor = ColorDesign.customBlack
        return imageView
    }()
    
    let itemTextField: UITextField = {
        let textField = HoshiTextField()
        textField.placeholder = "메모"
        textField.placeholderColor = ColorDesign.customDarkGray ?? .black
        textField.borderActiveColor = ColorDesign.customPurple
        textField.borderInactiveColor = ColorDesign.customLightGray
        return textField
    }()
    
    let addItemButton: UIButton = {
        var config = UIButton.Configuration.filled()
        var title = AttributedString.init("추가하기")
        title.font = UIFont(name: FontDesign.bold, size: 16)
        config.attributedTitle = title
        config.baseBackgroundColor = ColorDesign.customPurple
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func addViews() {
        self.backgroundColor = .white
        [itemImageView, itemTextField, addItemButton].forEach { self.addSubview($0) }
    }
    
    override func addConstraints() {
        itemImageView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.trailing.equalTo(self)
            $0.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        itemTextField.snp.makeConstraints {
            $0.top.equalTo(itemImageView.snp_bottomMargin).offset(40)
            $0.leading.trailing.equalTo(self).inset(24)
            $0.height.equalTo(50)
        }
        
        addItemButton.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-60)
            $0.centerX.equalTo(self)
            $0.leading.trailing.equalTo(self).inset(24)
            $0.height.equalTo(60)
        }
    }
}
