//
//  RootView.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 24.01.2023.
//

import Foundation
import UIKit



class RootViewWindow: UIWindow {
    var presenter: RootViewToPresenterProtocol?
    
    var isKey = false

    override func becomeKey() {
        super.becomeKey()
        self.backgroundColor = .white //R.color.backgroundColor()
        guard !isKey else {
            return
        }
        isKey = true
        start()
    }
}

extension RootViewWindow: RootPresenterToViewProtocol {
    func start() {
        presenter?.start()
    }
}
