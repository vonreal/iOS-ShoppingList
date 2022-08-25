//
//  AddingItemViewController.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/26.
//

import UIKit

import RealmSwift

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

class AddingItemViewController: BaseViewController {

    let mainView = AddingItemView()
    let localRealm = try! Realm()
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationUI()
        register()
        mainView.addItemButton.addTarget(self, action: #selector(addItemButtonClicekd), for: .touchUpInside)
    }
    
    @objc func addItemButtonClicekd() {
        if let title = mainView.itemTextField.text, !title.isEmpty {
            let task = UserShoppingList(title: title, photoURL: nil, registerDay: Date(), bookMark: false, done: false)
            
            if let image = mainView.itemImageView.image {
                saveImageToDocument(filename: "\(task.objectId).jpg", image: image)
            }
            
            try! localRealm.write {
                localRealm.add(task)
                print("Saved Success")
            }
            self.dismiss(animated: true)
        }
    }
    
    func navigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "이미지 찾기", style: .plain, target: self, action: #selector(imageSearchButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func imageSearchButtonClicked() {
        let vc = ImageSearchViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func register() {
        mainView.itemTextField.delegate = self
    }
}

extension AddingItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension AddingItemViewController: SelectImageDelegate {
    func sendImageData(image: UIImage) {
        self.mainView.itemImageView.image = image
    }
}
