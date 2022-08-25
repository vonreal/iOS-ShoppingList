//
//  ImageSearchViewController.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/26.
//

import UIKit

import Kingfisher

class ImageSearchViewController: BaseViewController {
    
    let mainView = ImageSearchView()
    
    var photos: [String] = []
    var total = 0
    
    var delegate: SelectImageDelegate?
    var selectImage: UIImage?
    var selectIndexPath: IndexPath?
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
        register()
    }

    func navigationUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(chooseButtonClicked))
    }
    
    @objc func chooseButtonClicked() {
        guard let selectImage = selectImage else {
            return
        }
        delegate?.sendImageData(image: selectImage)
        navigationController?.popViewController(animated: true)
    }
    
    func register() {
        mainView.searchBar.delegate = self
        
        mainView.searchResultCollectionView.delegate = self
        mainView.searchResultCollectionView.dataSource = self
        mainView.searchResultCollectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let text = searchBar.text {
            let result = text.trimmingCharacters(in: CharacterSet.whitespaces)
            APIManager.shared.requestUnsplashAPI(page: 1, text: result) { total, photos in
                self.total = total
                self.photos = photos
                self.mainView.searchResultCollectionView.reloadData()
            }
        }
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        cell.layer.borderWidth = (selectIndexPath == indexPath ? 4 : 0)
        cell.layer.borderColor = (selectIndexPath == indexPath ? ColorDesign.customPurple?.cgColor : nil)
        cell.imageView.kf.setImage(with: URL(string: photos[indexPath.item]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageSearchCollectionViewCell else { return }
        selectImage = cell.imageView.image
        selectIndexPath = indexPath
        collectionView.reloadData()
    }
}
