//
//  ReminderDetailInteractor.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 26.02.2023.
//

import Foundation

class ReminderDetailInteractor: ReminderDetailPresenterToInteractorProtocol {
    var presenter: ReminderDetailInteractorToPresenterProtocol?
    var realmService: RealmService
    
    init(realmService: RealmService) {
        self.realmService = realmService
    }
    
    func save(reminder: Reminder) {
        realmService.save(reminder)
    }
}
