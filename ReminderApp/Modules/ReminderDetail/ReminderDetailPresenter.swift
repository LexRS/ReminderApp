//
//  ReminderDetailPresenter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 26.02.2023.
//

import Foundation

class ReminderDetailPresenter: ReminderDetailViewToPresenterProtocol {
    var view: ReminderDetailPresenterToViewProtocol?
    
    var router: ReminderDetailPresenterToRouterProtocol?
    
    var interactor: ReminderDetailPresenterToInteractorProtocol?
    
    func saveChangesAndDismiss(reminder: Reminder?) {
        
    }
    
    func showMoreOptions() {
        router?.openMoreOptions()
    }
    
    func showGroupSelection() {
        router?.openGroupSelection()
    }
    
    func dismissReminderDetail() {
        router?.reminderDetailShouldDismiss()
    }
    
    func setTitle(_ text: String) {
        reminder.title = text
    }
    
    func setNotes(_ text: String) {
        reminder.notes = text
    }
    
    func saveReminder() {
        guard (reminder.title != "" && reminder.notes != "") else {
            return
        }
        interactor?.save(reminder: reminder)
    }
    
    //MARK: - Private
    private var reminder: Reminder = Reminder(title: "", notes: "")
}

extension ReminderDetailPresenter: ReminderDetailInteractorToPresenterProtocol {
    func reminderSavedSucceed() {
    }
    
    func reminderSavedFailed() {
    }
    
}
