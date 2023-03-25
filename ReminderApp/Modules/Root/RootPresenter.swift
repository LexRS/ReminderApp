//
//  RootPresenter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 18.01.2023.
//

import Foundation

class RootPresenter: RootViewToPresenterProtocol {
    var view: RootPresenterToViewProtocol?
    var router: RootPresenterToRouterProtocol?
    
    func start() {
        router?.installMainMenu()
    }
}
