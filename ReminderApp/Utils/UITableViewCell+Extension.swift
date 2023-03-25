//
//  UITableViewCell+Extension.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 06.03.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var reuseId: String {
        return String(describing: self)
    }
}
