//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import Foundation
import UIKit

struct Reminder {
    var uuid = UUID().uuidString
    var title: String?
    var notes: String?
    var category: ReminderCategory = .All
//    var userGroup: UserGroup?
    var reminder: Date? = nil
    var isCompleted: Bool? = nil
}

struct UserGroup {
    var title: String
    var color: UIColor = .black
}
