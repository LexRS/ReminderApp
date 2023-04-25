//
//  ReminderMenuRouter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import Foundation
import UIKit
import Swinject

class ReminderMenuRouter: BaseRouter, ReminderMenuPresenterToRouterProtocol {
    
    var reminderDetailModule: ReminderDetailRouter?
    var remindersListModule: RemindersListRouter?
    
    let container: Container
    
    init() {
        container = Container(parent: Dependencies.shared.container)
        
        container.register(ReminderMenuPresenterToViewProtocol.self) { resolver in
            let view = ReminderMenuViewController()
            view.presenter = resolver.resolve(ReminderMenuViewToPresenterProtocol.self)
            return view
        }.inObjectScope(.container)
        
        container.register(ReminderMenuViewToPresenterProtocol.self) { resolver in
            let presenter = ReminderMenuPresenter()
            return presenter
        }.initCompleted { (r: Resolver, p: ReminderMenuViewToPresenterProtocol) in
            p.view = r.resolve(ReminderMenuPresenterToViewProtocol.self)
            p.router = self
            p.interactor = r.resolve(ReminderMenuPresenterToInteractorProtocol.self)
        }
        
        container.register(ReminderMenuInteractorToPresenterProtocol.self) { resolver in
            let presenter = resolver.resolve(ReminderMenuViewToPresenterProtocol.self) as! ReminderMenuPresenter
            return presenter
        }
        
        container.register(ReminderMenuPresenterToInteractorProtocol.self) { resolver in
            let realmService = resolver.resolve(RealmService.self)!
            let interactor = ReminderMenuInteractor(realmService: realmService)
            return interactor
        }.initCompleted { (r, p) in
            p.presenter = r.resolve(ReminderMenuInteractorToPresenterProtocol.self)
        }
    }
    
    func createModule() -> UIViewController {
        let view = container.resolve(ReminderMenuPresenterToViewProtocol.self) as! UIViewController
        return view
    }
    
    func showReminderDetail(_ reminder: Reminder?) {
        let reminderDetail = ReminderDetailRouter()
        reminderDetailModule = reminderDetail
        reminderDetailModule?.delegate = self
        //let viewController = reminderDetailModule?.createModule()
        let viewController = reminderDetailModule?.createNavigatableModule()
        guard let viewController = viewController else {
            return
        }
        presentModalScreen(viewController, animated: true)
    }
    
    func showRemindersList(reminders: [Reminder]) {
        let remindersList = RemindersListRouter(reminders: reminders)
        remindersListModule = remindersList
        remindersListModule?.delegate = self
        let viewController = remindersListModule?.createModule()
        guard let viewController = viewController else {
            return
        }
        pushScreen(viewController)
    }
}

extension ReminderMenuRouter: ReminderDetailRouterDelegate {
    func reminderDetailModuleShouldDismiss(_ module: ReminderDetailRouter) {
        dismissChildModule {
            self.reminderDetailModule = nil
        }
    }
}

extension ReminderMenuRouter: RemindersListRouterDelegate {
    func remindersListModuleShouldDismiss(_ module: RemindersListRouter) {
        dismissChildModule {
            self.remindersListModule = nil
        }
    }
}
