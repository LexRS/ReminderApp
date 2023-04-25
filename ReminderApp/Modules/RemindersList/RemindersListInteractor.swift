//
//  RemindersListInteractor.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.04.2023.
//

import Foundation

class RemindersListInteractor: RemindersListPresenterToInteractorProtocol {
    var presenter: RemindersListInteractorToPresenterProtocol?
    var realmService: RealmService
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func deleteReminder(_ reminder: Reminder) {
        realmService.delete(reminder)
    }
    
}
