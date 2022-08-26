//
//  BaseView.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() { }
    func addConstraints() { }
}
