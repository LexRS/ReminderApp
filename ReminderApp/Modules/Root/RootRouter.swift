//
//  RootRouter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 24.01.2023.
//

import Foundation
import Swinject

class RootRouter {
    
    var mainMenu: ReminderMenuRouter?
    
    let container: Container
    
    init() {
        container = Container(parent: Dependencies.shared.container)
        
        container.register(RootPresenterToViewProtocol.self) { resolver in
            let v = RootViewWindow()
            v.presenter = resolver.resolve(RootViewToPresenterProtocol.self)
            return v
        }.inObjectScope(.container)
        
        container.register(RootViewToPresenterProtocol.self) { resolver in
            return RootPresenter()
        }.initCompleted { (r: Resolver, p: RootViewToPresenterProtocol) in
            p.view = r.resolve(RootPresenterToViewProtocol.self)!
            p.router = self
        }
    }
    
    func entry() -> UIWindow {
        return container.resolve(RootPresenterToViewProtocol.self) as! UIWindow
    }
    
    private func setRootController(_ controller: UIViewController, for window: UIWindow) {
        window.rootViewController?.children.forEach { $0.removeFromParent() }
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    private func removeAllSubModules() {
        mainMenu = nil
    }
}

extension RootRouter: RootPresenterToRouterProtocol {
    
    func createModule() -> UIWindow {
        let window = container.resolve(RootPresenterToViewProtocol.self) as! UIWindow
        return window
    }
    
    func installMainMenu() {
        let mainMenuModule = ReminderMenuRouter()
        mainMenu = mainMenuModule
        let viewController = mainMenu?.createNavigatableModule()
        setRootController(viewController!, for: entry())
    }
    
    
}
