//
//  RemindersListRouter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.04.2023.
//

import Foundation
import Swinject

protocol RemindersListRouterDelegate: AnyObject {
    func remindersListModuleShouldDismiss(_ module: RemindersListRouter)
}

class RemindersListRouter: BaseRouter, RemindersListPresenterToRouterProtocol {
    
    weak var delegate: RemindersListRouterDelegate?
    
    let container: Container
    
    // MARK: - Initializers
    
    init(reminders: [Reminder]) {
        
        container = Container(parent: Dependencies.shared.container)
        
        container.register(RemindersListPresenterToViewProtocol.self) { resolver in
            let view = RemindersListViewController()
            view.presenter = resolver.resolve(RemindersListViewToPresenterProtocol.self)
            return view
        }.inObjectScope(.container)
        
        container.register(RemindersListViewToPresenterProtocol.self) { (resolver) in
            let presenter = RemindersListPresenter(reminders: reminders)
            return presenter
        }
        .initCompleted { (r: Resolver, p: RemindersListViewToPresenterProtocol) in
            p.view = r.resolve(RemindersListPresenterToViewProtocol.self)
            p.router = self
            p.interactor = r.resolve(RemindersListPresenterToInteractorProtocol.self)
        }
        
        container.register(RemindersListInteractorToPresenterProtocol.self) { resolver in
            let presenter = resolver.resolve(RemindersListViewToPresenterProtocol.self) as! RemindersListPresenter
            return presenter
        }
        
        container.register(RemindersListPresenterToInteractorProtocol.self) { resolver in
            let realmService = resolver.resolve(RealmService.self)!
            let interactor = RemindersListInteractor(realmService: realmService)
            return interactor
        }.initCompleted { (r, p) in
            p.presenter = r.resolve(RemindersListInteractorToPresenterProtocol.self)
        }
    }
    
    // MARK: - Base class
    
    func createModule() -> UIViewController {
        let view = container.resolve(RemindersListPresenterToViewProtocol.self) as! UIViewController
        return view
    }
    
    // MARK: - Private
    
}
