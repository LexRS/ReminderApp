//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import Foundation
import UIKit

struct Reminder {
    var title: String?
    var notes: String?
    var category: ReminderCategory = .NextWeek
//    var userGroup: UserGroup?
//    var reminder: Date?
//    var isCompleted: Bool? = false
}

struct UserGroup {
    var title: String
    var color: UIColor = .black
}
