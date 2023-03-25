//
//  MoreOptionsPresenter.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 08.03.2023.
//

import Foundation

class MoreOptionsPresenter: MoreOptionsViewToPresenterProtocol {
    var view: MoreOptionsPresenterToViewProtocol?
    
    var router: MoreOptionsPresenterToRouterProtocol?
    
    var interactor: MoreOptionsPresenterToInteractorProtocol?
}

extension MoreOptionsPresenter: MoreOptionsInteractorToPresenterProtocol {
    
    
}

