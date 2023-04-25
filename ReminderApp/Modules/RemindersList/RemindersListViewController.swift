//
//  RemindersListViewController.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.04.2023.
//

import Foundation
import UIKit

class RemindersListViewController: UIViewController {
    var presenter: RemindersListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        applyConstraints()
        setCustomBackButtonTitle()
    }
    
    // MARK: - Private
    
    private lazy var tableView: UITableView = _tableView
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCustomBackButtonTitle() {
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "Lists"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
    }
    
    private func deleteReminder(at indexPath: IndexPath) {
        if presenter?.reminders != nil {
            presenter!.deleteReminder(presenter!.reminders![indexPath.row])
            presenter!.reminders!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        //tableView.reloadData()
    }
    // MARK: - Actions
    
    
}

// MARK: - RemindersListView

extension RemindersListViewController: RemindersListPresenterToViewProtocol {
    func showError() {
        
    }
}

// MARK: - UITableViewDelegate

extension RemindersListViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension RemindersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reminders = presenter?.reminders else {
            return 0
        }
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RemindersListTableViewCell.reuseId, for: indexPath) as! RemindersListTableViewCell
        cell.delegate = self
        if let reminder = presenter?.reminders![indexPath.row] {
            cell.configure(with: reminder)
        }
        return cell
    }
}

// MARK: - RemindersTableViewCellDelegate

extension RemindersListViewController: RemindersListTableViewCellDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteReminder(at: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

// MARK: - Subviews creation

private extension RemindersListViewController {
    var _tableView: UITableView {
        let result = UITableView()
        result.register(RemindersListTableViewCell.self, forCellReuseIdentifier: RemindersListTableViewCell.reuseId)
        result.dataSource = self
        result.delegate = self
        return result
    }
}  
