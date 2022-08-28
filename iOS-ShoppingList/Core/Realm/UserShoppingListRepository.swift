//
//  UserShoppingListRepository.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/28.
//

import Foundation

import RealmSwift

protocol UserShoppingListRepositoryType {
    func printFileLocation()
    func fetchRealm() -> Results<UserShoppingList>
    func fetchSort(keyPath: String, ascending: Bool) -> Results<UserShoppingList>
    func fetchDeleteData(target: UserShoppingList) -> Bool
    func removeImageFromDocument(filename: String)
}

class UserShoppingListRepository: UserShoppingListRepositoryType {
    
    private init() { }
    
    static let repository = UserShoppingListRepository()
    
    let localRealm = try! Realm()
    
    func printFileLocation() {
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    func fetchRealm() -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "objectId", ascending: false)
    }
    
    func fetchSort(keyPath: String, ascending: Bool) -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).sorted(byKeyPath: keyPath, ascending: ascending)
    }
    
    func fetchDeleteData(target: UserShoppingList) -> Bool {
        removeImageFromDocument(filename: "images/\(target.objectId).jpg")
        
        do {
            try localRealm.write {
                localRealm.delete(target)
            }
        } catch {
            return false
        }
        return true
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func fetchUpdateBookmark(target: UserShoppingList) {
        do {
            try localRealm.write {
                target.bookMark.toggle()
            }
        } catch {
            print("Faile to update to realm.")
        }
    }
    
    func fetchUpdateDone(target: UserShoppingList) {
        do {
            try localRealm.write {
                target.done.toggle()
            }
        } catch {
            print("Faile to update to realm.")
        }
    }
}
