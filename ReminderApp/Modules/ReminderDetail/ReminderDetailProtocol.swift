//
//  ReminderDetailProtocol.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 26.02.2023.
//

import Foundation
import UIKit

protocol ReminderDetailViewToPresenterProtocol: AnyObject {
    var view: ReminderDetailPresenterToViewProtocol? { get set }
    var router: ReminderDetailPresenterToRouterProtocol? { get set }
    var interactor: ReminderDetailPresenterToInteractorProtocol? { get set }
    
    func saveChangesAndDismiss(reminder: Reminder?)
    func dismissReminderDetail()
    func showMoreOptions()
    func showGroupSelection()
    func saveReminder()
    func setTitle(_ text: String)
    func setNotes(_ text: String)
}

protocol ReminderDetailPresenterToViewProtocol: AnyObject {
    var presenter: ReminderDetailViewToPresenterProtocol? { get set }
    func showError()
}

protocol ReminderDetailPresenterToRouterProtocol: AnyObject {
    func reminderDetailShouldDismiss()
    func openMoreOptions()
    func openGroupSelection()
}

protocol ReminderDetailPresenterToInteractorProtocol: AnyObject {
    var presenter: ReminderDetailInteractorToPresenterProtocol? { get set }
    
    func save(reminder: Reminder)
}

protocol ReminderDetailInteractorToPresenterProtocol: AnyObject {
    func reminderSavedSucceed()
    func reminderSavedFailed()
}
