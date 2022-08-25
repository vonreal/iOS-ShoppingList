//
//  MainShoppingListView.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/25.
//

import UIKit

import SnapKit

class MainShoppingListView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let helloUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi, 스텔라!"
        label.textColor = .white
        label.font = UIFont(name: FontDesign.bold, size: 20)
        return label
    }()
    
    let helloCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘도 즐거운 하루 보내세요 🫰"
        label.textColor = .white
        label.font = UIFont(name: FontDesign.light, size: 14)
        return label
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "exampleMyProfile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = (50 / 2)
        imageView.backgroundColor = ColorDesign.customPurple
        return imageView
    }()
    
    let shoppingListBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let shoppingListLabel: UILabel = {
        let label = UILabel()
        label.text = "내 쇼핑 리스트 전체 보기"
        label.textColor = ColorDesign.customBlack
        label.font = UIFont(name: FontDesign.bold, size: 20)
        return label
    }()
    
    let sortButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var title = AttributedString.init("정렬")
        title.font = UIFont(name: FontDesign.medium, size: 16)
        config.attributedTitle = title
        config.baseForegroundColor = ColorDesign.customPurple
        let button = UIButton(configuration: config)
        return button
    }()
    
    let shopplingTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "총 0개의 아이템"
        label.textColor = ColorDesign.customLightGray
        label.font = UIFont(name: FontDesign.medium, size: 14)
        return label
    }()
    
    let shopplingListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = ColorDesign.customPurple
        button.tintColor = .white
        button.layer.cornerRadius = (54 / 2)
        return button
    }()
    
    override func addViews() {
        self.backgroundColor = ColorDesign.customBlack
        [helloUserLabel, helloCommentLabel, userProfileImageView, shoppingListBackgroundView, shoppingListLabel, sortButton, shopplingTotalLabel, shopplingListTableView, addButton].forEach { self.addSubview($0) }
    }
    
    override func addConstraints() {
        helloUserLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            $0.leading.equalTo(24)
        }
        
        helloCommentLabel.snp.makeConstraints {
            $0.top.equalTo(helloUserLabel.snp_bottomMargin).offset(16)
            $0.leading.equalTo(24)
        }
        
        userProfileImageView.snp.makeConstraints {
            $0.bottom.equalTo(helloCommentLabel.snp_bottomMargin).offset(10)
            $0.trailing.equalTo(-24)
            $0.width.height.equalTo(50)
        }
        
        shoppingListBackgroundView.snp.makeConstraints {
            $0.bottom.equalTo(self)
            $0.leading.equalTo(self)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height / 1.3)
        }
        
        shoppingListLabel.snp.makeConstraints {
            $0.top.equalTo(shoppingListBackgroundView).offset(30)
            $0.leading.equalTo(24)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(shoppingListBackgroundView).offset(30)
            $0.trailing.equalTo(-24)
            $0.height.equalTo(20)
        }
        
        shopplingTotalLabel.snp.makeConstraints {
            $0.top.equalTo(shoppingListLabel.snp_bottomMargin).offset(14)
            $0.leading.equalTo(24)
        }
        
        shopplingListTableView.snp.makeConstraints {
            $0.top.equalTo(shopplingTotalLabel.snp_bottomMargin).offset(20)
            $0.leading.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.width.height.equalTo(54)
            $0.centerX.equalTo(self)
        }
    }
}
