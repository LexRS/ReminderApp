//
//  ReminderMenuInteractor.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import Foundation
import Realm

class ReminderMenuInteractor: ReminderMenuPresenterToInteractorProtocol {
    var presenter: ReminderMenuInteractorToPresenterProtocol?
    var realmService: RealmService
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func fetchReminders() {
        guard let reminders = realmService.fetchReminders() else {
            return
        }
        presenter?.remindersFetchedSuccess(reminders)
    }
    
}
