//
//  RemindersListProtocol.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.04.2023.
//

import Foundation
import Swinject

// MARK: - RemindersListProtocols

protocol RemindersListViewToPresenterProtocol: AnyObject {
    var view: RemindersListPresenterToViewProtocol? { get set }
    var router: RemindersListPresenterToRouterProtocol? { get set }
    var interactor: RemindersListPresenterToInteractorProtocol? { get set }
    var reminders: [Reminder]? { get set }
    func deleteReminder(_ reminder: Reminder)
}

protocol RemindersListPresenterToViewProtocol: AnyObject {
    var presenter: RemindersListViewToPresenterProtocol? { get set }
    func showError()
}

protocol RemindersListPresenterToRouterProtocol: AnyObject {
    func createModule() -> UIViewController
}

protocol RemindersListPresenterToInteractorProtocol: AnyObject {
    var presenter: RemindersListInteractorToPresenterProtocol? { get set }
    func deleteReminder(_ reminder: Reminder)
}

protocol RemindersListInteractorToPresenterProtocol: AnyObject {
    
}
