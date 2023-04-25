//
//  ReminderDBModel.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 10.03.2023.
//

import Foundation
import RealmSwift

class ReminderObject: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var notes = ""
    //@objc dynamic var date: Date? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

//class UserGroupObject: Object {
//    @objc dynamic var title = ""
//    @objc dynamic var color: UIColor = .black
//    
//    static func create(title: String, color: UIColor) -> UserGroupObject {
//        let userGroup = UserGroupObject()
//        userGroup.title = title
//        userGroup.color = color
//        
//        return userGroup
//    }
//}
