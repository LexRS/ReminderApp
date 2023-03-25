//
//  BaseRouter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 25.02.2023.
//

import Foundation
import UIKit

protocol NavigationRouter: AnyObject {
    func navigationWrapped(_ viewController: UIViewController) -> UINavigationController
}

extension NavigationRouter {
    func navigationWrapped(_ viewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: viewController)
    }
}

protocol BaseRouter: NavigationRouter {
    func createModule() -> UIViewController
    func createNavigatableModule() -> UIViewController
    func presentModalScreen(_ viewController: UIViewController, animated: Bool)
    func pushScreen(_ viewController: UIViewController, animated: Bool)
    func popScreen(animated: Bool)
    func dismissChildModule(_ completion: ( () -> Void )?)
}

extension BaseRouter {
    func presentModalScreen(_ viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .formSheet
        //viewController.modalPresentationCapturesStatusBarAppearance = true
        let vc: UIViewController = viewController
        createModule().present(vc, animated: animated, completion: nil)
    }
    
    func pushScreen(_ viewController: UIViewController, animated: Bool = true) {
        createModule().navigationController?.pushViewController(viewController, animated: animated)
    }

    func popScreen(animated: Bool = true) {
        createModule().navigationController?.popViewController(animated: animated)
    }
    
    func dismissChildModule(_ completion: ( () -> Void )?) {
        let controller = createModule()
        let popToCurrentController = {
            if let lastController = controller.navigationController?.viewControllers.last, lastController != controller {
                controller.navigationController?.popToViewController(controller, animated: true)
            }
            completion?()
        }
        guard let presented = controller.presentedViewController else {
            popToCurrentController()
            return
        }
        if presented.isBeingDismissed {
            // если модальный экран уже в процессе ухода с экрана идём дальше
            popToCurrentController()
        } else {
            // иначе уберём его явно
            presented.dismiss(animated: true) {
                // и после этого идём дальше
                popToCurrentController()
            }
        }
    }
    
    func createNavigatableModule() -> UIViewController {
        return UINavigationController(rootViewController: self.createModule())
    }
}
