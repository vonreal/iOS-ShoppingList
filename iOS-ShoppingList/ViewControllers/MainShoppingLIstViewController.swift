//
//  MainShoppingLIstViewController.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/25.
//

import UIKit

import RealmSwift
import SwiftyJSON

class MainShoppingLIstViewController: BaseViewController {

    let mainView = MainShoppingListView()
    let localRealm = try! Realm()
    var tasks: Results<UserShoppingList>!
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableView()
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        tasks = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "objectId", ascending: false)
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
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
    
    @objc func addButtonClicked() {
        let vc = AddingItemViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "title", ascending: false)
        mainView.shopplingListTableView.reloadData()
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
            let taskToDelete = tasks[indexPath.row]
            
            self.removeImageFromDocument(filename: "images/\(taskToDelete.objectId).jpg")
            
            try! localRealm.write {
                localRealm.delete(taskToDelete)
                print("Delete Success")
            }
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddingItemViewController()
        vc.mainView.itemImageView.image = loadImageFromDocument(filename: "\(tasks[indexPath.row].objectId).jpg")
        vc.mainView.itemTextField.text = tasks[indexPath.row].title
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
}
