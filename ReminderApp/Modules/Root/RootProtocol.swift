//
//  RootProtocol.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 18.01.2023.
//

import Foundation
import UIKit

protocol RootViewToPresenterProtocol: AnyObject {
    var view: RootPresenterToViewProtocol? { get set }
    var router: RootPresenterToRouterProtocol? { get set }
    func start()
}

protocol RootPresenterToViewProtocol: AnyObject {
    var presenter: RootViewToPresenterProtocol? { get set}
    
    func start()
}

protocol RootPresenterToRouterProtocol: AnyObject {
    var mainMenu: ReminderMenuRouter? { get set }
    func createModule() -> UIWindow
    func installMainMenu()
}
