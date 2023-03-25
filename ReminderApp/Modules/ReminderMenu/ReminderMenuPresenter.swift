//
//  ReminderMenuPresenter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import Foundation
import UIKit

class ReminderMenuPresenter: ReminderMenuViewToPresenterProtocol {
    var view: ReminderMenuPresenterToViewProtocol?
    
    var router: ReminderMenuPresenterToRouterProtocol?
    
    var interactor: ReminderMenuPresenterToInteractorProtocol?
    
    func fetchReminders() {
        interactor?.fetchReminders()
    }
    
    func showReminderDetail(reminder: Reminder?) {
        router?.showReminderDetail(reminder)
    }
}

extension ReminderMenuPresenter: ReminderMenuInteractorToPresenterProtocol {
    func remindersFetchedSuccess(_ reminders: [Reminder]) {
        var remindersSorted = Dictionary(grouping: reminders) { reminder in
            reminder.category
        }
        view?.showReminders(remindersSorted)
    }
    
    func remindersFetchedFailed() {
        view?.showError()
    }
    
    
}
