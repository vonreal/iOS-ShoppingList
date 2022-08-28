//
//  MainShoppingLIstViewController.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/25.
//

import UIKit

import RealmSwift
import SwiftyJSON
import CoreMedia

class MainShoppingLIstViewController: BaseViewController {

    let mainView = MainShoppingListView()
    let repository = UserShoppingListRepository.repository
    var tasks: Results<UserShoppingList>! {
        didSet {
            mainView.shopplingListTableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.printFileLocation()
        registerTableView()
        setButtonEvent()
        fetchRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.shopplingListTableView.reloadData()
    }
    
    func registerTableView() {
        mainView.shopplingListTableView.delegate = self
        mainView.shopplingListTableView.dataSource = self
        mainView.shopplingListTableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setButtonEvent() {
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        setSortButtonEvent()
    }
    
    @objc func addButtonClicked() {
        let vc = AddingItemViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort(keyPath: "objectId", ascending: false)
    }
    
    func setSortButtonEvent() {
        let bookMarkSortButton = UIAction(title: "즐겨찾기 순 정렬") { _ in
            self.tasks = self.repository.fetchSort(keyPath: "bookMark", ascending: false)
        }
        let doneSortButton = UIAction(title: "할 일 기준 정렬") { _ in
            self.tasks = self.repository.fetchSort(keyPath: "done", ascending: true)
        }
        let titleSortButton = UIAction(title: "제목 순 정렬") { _ in
            self.tasks = self.repository.fetchSort(keyPath: "title", ascending: true)
        }
        
        
        mainView.sortButton.menu = UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [bookMarkSortButton, doneSortButton, titleSortButton])
    }
    
    func fetchRealm() {
        tasks = repository.fetchRealm()
    }
}

extension MainShoppingLIstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainView.shopplingTotalLabel.text = "총 \(tasks.count)개의 아이템"
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        cell.itemNameLabel.text = tasks[indexPath.row].title
        cell.itemImageView.image = loadImageFromDocument(filename: "images/\(tasks[indexPath.row].objectId).jpg")
        var image: UIImage?
        var color: UIColor?
        if tasks[indexPath.row].bookMark {
            image = UIImage(systemName: "heart.fill")
            color = .systemPink
        } else {
            image = UIImage(systemName: "heart")
            color = ColorDesign.customDarkGray
        }
        cell.miniBookmarkImageView.image = image
        cell.miniBookmarkImageView.tintColor = color
        
        if tasks[indexPath.row].done {
            image = UIImage(systemName: "checkmark.circle.fill")
            color = ColorDesign.customGreen
        } else {
            image = UIImage(systemName: "checkmark.circle")
            color = ColorDesign.customDarkGray
        }
        cell.miniCheckImageView.image = image
        cell.miniCheckImageView.tintColor = color

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let target = tasks[indexPath.row]
            if !repository.fetchDeleteData(target: target) {
                popupAlertMessage(title: "데이터베이스 실패", message: "삭제에 실패했습니다. 다시 시도해주세요.")
                return
            }
            mainView.shopplingListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddingItemViewController()
        vc.mainView.itemImageView.image = loadImageFromDocument(filename: "images/\(tasks[indexPath.row].objectId).jpg")
        vc.mainView.itemTextField.text = tasks[indexPath.row].title
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "완료") { action, view, completionHandler in
            self.repository.fetchUpdateDone(target: self.tasks[indexPath.row])
            self.mainView.shopplingListTableView.reloadData()
        }
        done.backgroundColor = ColorDesign.customGreen
        done.image = UIImage(systemName: "checkmark.circle.fill")
        
        let bookmark = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            self.repository.fetchUpdateBookmark(target: self.tasks[indexPath.row])
            self.mainView.shopplingListTableView.reloadData()
        }
        bookmark.backgroundColor = .systemPink
        bookmark.image = UIImage(systemName: "heart.fill")

        return UISwipeActionsConfiguration(actions: [done, bookmark])
    }
}
