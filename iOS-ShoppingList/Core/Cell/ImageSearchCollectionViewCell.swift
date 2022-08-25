//
//  ImageSearchCollectionViewCell.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/26.
//

import UIKit

class ImageSearchCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.backgroundColor = ColorDesign.customLightGray
        img.sizeToFit()
        return img
    }()
}
