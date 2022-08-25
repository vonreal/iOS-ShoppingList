//
//  RealmModel.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/26.
//
import UIKit

import RealmSwift

class UserShoppingList: Object {
    @Persisted var title: String?
    @Persisted var photoURL: String?
    @Persisted var registerDay: Date
    @Persisted var bookMark: Bool
    @Persisted var done: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String?, photoURL: String?, registerDay: Date, bookMark: Bool, done: Bool) {
        self.init()
        self.title = title
        self.photoURL = photoURL
        self.registerDay = registerDay
        self.bookMark = bookMark
        self.done = done
    }
}


