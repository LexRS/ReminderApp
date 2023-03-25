//
//  ReminderDetailRouter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 26.02.2023.
//

import Foundation
import Swinject

protocol ReminderDetailRouterDelegate: AnyObject {
    func reminderDetailModuleShouldDismiss(_ module: ReminderDetailRouter)
}
    
class ReminderDetailRouter: BaseRouter {
    
    weak var delegate: ReminderDetailRouterDelegate?
    
    private var moreOptionsModule: MoreOptionsRouter?

    let container: Container
    
    init() {
        container = Container(parent: Dependencies.shared.container)
        
        container.register(ReminderDetailPresenterToViewProtocol.self) { resolver in
            let view = ReminderDetailViewController()
            view.presenter = resolver.resolve(ReminderDetailViewToPresenterProtocol.self)
            return view
        }.inObjectScope(.container)
        
        container.register(ReminderDetailViewToPresenterProtocol.self) { resolver in
            let presenter = ReminderDetailPresenter()
            return presenter
        }.initCompleted { (r: Resolver, p: ReminderDetailViewToPresenterProtocol) in
            p.view = r.resolve(ReminderDetailPresenterToViewProtocol.self)
            p.router = self
            p.interactor = r.resolve(ReminderDetailPresenterToInteractorProtocol.self)
        }
        
        container.register(ReminderDetailInteractorToPresenterProtocol.self) { resolver in
            let presenter = resolver.resolve(ReminderDetailViewToPresenterProtocol.self) as! ReminderDetailPresenter
            return presenter
        }
        
        container.register(ReminderDetailPresenterToInteractorProtocol.self) { resolver in
            let realmService = resolver.resolve(RealmService.self)!
            let interactor = ReminderDetailInteractor(realmService: realmService)
            return interactor
        }.initCompleted { (r, p) in
            p.presenter = r.resolve(ReminderDetailInteractorToPresenterProtocol.self)
        }
    }
    
    func createModule() -> UIViewController {
        let view = container.resolve(ReminderDetailPresenterToViewProtocol.self) as! UIViewController
        return view
    }
}

extension ReminderDetailRouter: ReminderDetailPresenterToRouterProtocol {
    func reminderDetailShouldDismiss() {
        delegate?.reminderDetailModuleShouldDismiss(self)
    }
    
    func openMoreOptions() {
        let moreOptionsRouter = MoreOptionsRouter()
        moreOptionsModule = moreOptionsRouter
        moreOptionsModule?.delegate = self
        let vc = moreOptionsModule?.createModule()
        guard let vc = vc else {
            return
        }
        pushScreen(vc)
    }
    
    func openGroupSelection() {
        //let groupSelectionRouter = 
    }
}

extension ReminderDetailRouter: MoreOptionsRouterDelegate {
    func moreOptionsModuleShouldDismiss(_ module: MoreOptionsRouter) {
        dismissChildModule({
            self.moreOptionsModule = nil
        })
    }
}
