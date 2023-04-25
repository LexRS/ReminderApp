//
//  ReminderMenuProtocol.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import Foundation
import UIKit

protocol ReminderMenuViewToPresenterProtocol: AnyObject {
    var view: ReminderMenuPresenterToViewProtocol? { get set }
    var router: ReminderMenuPresenterToRouterProtocol? { get set }
    var interactor: ReminderMenuPresenterToInteractorProtocol? { get set }
    
    func fetchReminders()
    func showReminderDetail(reminder: Reminder?)
    func showReminderList(reminders: [Reminder])
}

protocol ReminderMenuPresenterToViewProtocol: AnyObject {
    var presenter: ReminderMenuViewToPresenterProtocol? { get set }
    func showReminders(_ reminders: [Reminder])
    func showError()
}

protocol ReminderMenuPresenterToRouterProtocol: AnyObject {
    func createModule() -> UIViewController
    func showReminderDetail(_ reminder: Reminder?)
    func showRemindersList(reminders: [Reminder])
}

protocol ReminderMenuPresenterToInteractorProtocol: AnyObject {
    var presenter: ReminderMenuInteractorToPresenterProtocol? { get set }
    func fetchReminders()
}

protocol ReminderMenuInteractorToPresenterProtocol: AnyObject {
    func remindersFetchedSuccess(_ reminders: Array<Reminder>)
    func remindersFetchedFailed()
}


