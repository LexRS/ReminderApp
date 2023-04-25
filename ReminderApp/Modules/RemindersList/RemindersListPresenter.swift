//
//  RemindersListPresenter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.04.2023.
//

import Foundation

class RemindersListPresenter: RemindersListViewToPresenterProtocol {
    var view: RemindersListPresenterToViewProtocol?
    
    var router: RemindersListPresenterToRouterProtocol?
    
    var interactor: RemindersListPresenterToInteractorProtocol?
    
    var reminders: [Reminder]?
    
    init(reminders: [Reminder]) {
        self.reminders = reminders
    }
    
    func deleteReminder(_ reminder: Reminder) {
        interactor?.deleteReminder(reminder)
    }
}

extension RemindersListPresenter: RemindersListInteractorToPresenterProtocol {
    
    
}

