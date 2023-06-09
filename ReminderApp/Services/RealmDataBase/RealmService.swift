//
//  RealmService.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 18.01.2023.
//

import Foundation
import RealmSwift

protocol RealmService: AnyObject {
    func save(_ reminder: Reminder?)
    func delete(_ reminder: Reminder?)
    func fetchReminders() -> [Reminder]?
}

class RealmServiceImpl: RealmService {
    
    var realm: Realm!
    
    init () {}
    
    func save(_ reminder: Reminder?) {
        guard let reminder = reminder,
              let title = reminder.title,
              let notes = reminder.notes else {
            return
        }
        do {
            let realm = try Realm()
            var object: ReminderObject
            if let objectMaybe = realm.objects(ReminderObject.self)
                .filter("id == %@", reminder.uuid)
                .first {
                object = objectMaybe
                try realm.write({
                    object.title = title
                    object.notes = notes
                })
            }
            else {
                object = ReminderObject()
                try realm.write({
                    object.id = reminder.uuid
                    object.title = title
                    object.notes = notes
                })
            }
            try realm.write({
                realm.add(object)
            })
        } catch {
            print(error)
        }
    }
    
    func delete(_ reminder: Reminder?) {
        guard let reminder = reminder else {
            return
        }
        do {
            let realm = try Realm()
            if let objectMaybe = realm.objects(ReminderObject.self)
                .filter("id == %@", reminder.uuid)
                .first {
                    realm.delete(objectMaybe)
                }
        } catch {
            print(error)
        }
    }
    
    func fetchReminders() -> [Reminder]? {
        var reminders = [Reminder]()
        do {
            let realm = try Realm()
            let objects = realm.objects(ReminderObject.self)
            objects.forEach { reminderObject in
                var reminder = Reminder()
                reminder.title = reminderObject.title
                reminder.notes = reminderObject.notes
                reminders.append(reminder)
            }
        } catch {
            print(error)
            return nil
        }
        return reminders
    }
}
