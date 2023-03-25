//
//  MoreOptionsRouter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 08.03.2023.
//

import Foundation
import Swinject

protocol MoreOptionsRouterDelegate: AnyObject {
    func moreOptionsModuleShouldDismiss(_ module: MoreOptionsRouter)
}

class MoreOptionsRouter: BaseRouter, MoreOptionsPresenterToRouterProtocol {
    
    let container: Container
    
    weak var delegate: MoreOptionsRouterDelegate?
    
    // MARK: - Initializers
    
    init() {
        
        container = Container(parent: Dependencies.shared.container)
        
        container.register(MoreOptionsPresenterToViewProtocol.self) { resolver in
            let view = MoreOptionsViewController()
            view.presenter = resolver.resolve(MoreOptionsViewToPresenterProtocol.self)
            return view
        }.inObjectScope(.container)
        
        container.register(MoreOptionsViewToPresenterProtocol.self) { (resolver) in
            let presenter = MoreOptionsPresenter()
            return presenter
        }
        .initCompleted { (r: Resolver, p: MoreOptionsViewToPresenterProtocol) in
            p.view = r.resolve(MoreOptionsPresenterToViewProtocol.self)
            p.router = self
            p.interactor = r.resolve(MoreOptionsPresenterToInteractorProtocol.self)
        }
        
        container.register(MoreOptionsInteractorToPresenterProtocol.self) { resolver in
            let presenter = resolver.resolve(MoreOptionsViewToPresenterProtocol.self) as! MoreOptionsPresenter
            return presenter
        }
        
        container.register(MoreOptionsPresenterToInteractorProtocol.self) { resolver in
            let interactor = MoreOptionsInteractor()
            return interactor
        }.initCompleted { (r, p) in
            p.presenter = r.resolve(MoreOptionsInteractorToPresenterProtocol.self)
        }
    }
    
    // MARK: - Base class
    
    func createModule() -> UIViewController {
        let view = container.resolve(MoreOptionsPresenterToViewProtocol.self) as! UIViewController
        return view
    }
    
    // MARK: - Private
    
}
