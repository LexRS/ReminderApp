//
//  MoreOptionsProtocol.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 08.03.2023.
//

import Foundation
import Swinject

// MARK: - MoreOptionsProtocols

protocol MoreOptionsViewToPresenterProtocol: AnyObject {
    var view: MoreOptionsPresenterToViewProtocol? { get set }
    var router: MoreOptionsPresenterToRouterProtocol? { get set }
    var interactor: MoreOptionsPresenterToInteractorProtocol? { get set }
}

protocol MoreOptionsPresenterToViewProtocol: AnyObject {
    var presenter: MoreOptionsViewToPresenterProtocol? { get set }
    func showError()
}

protocol MoreOptionsPresenterToRouterProtocol: AnyObject {
    func createModule() -> UIViewController
}

protocol MoreOptionsPresenterToInteractorProtocol: AnyObject {
    var presenter: MoreOptionsInteractorToPresenterProtocol? { get set }
}

protocol MoreOptionsInteractorToPresenterProtocol: AnyObject {
    
}
