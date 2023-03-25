//
//  Dependencies.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 18.01.2023.
//

import Foundation
import Swinject

class Dependencies {
    static let shared = Dependencies()
    
    let container = Container()
    
    private init() {
        container.register(RealmService.self) { _ in
            RealmServiceImpl()
        }.inObjectScope(.container)
    }
    
    
}
