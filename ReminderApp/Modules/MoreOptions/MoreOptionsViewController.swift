//
//  MoreOptionsViewController.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 08.03.2023.
//

import Foundation
import UIKit

class MoreOptionsViewController: UIViewController {
    var presenter: MoreOptionsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        applyConstraints()
    }
    
    // MARK: - Private
    private lazy var tableView: UITableView = _tableView
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func applyConstraints() {
        
    } 
    
    // MARK: - Actions
    
    
}

// MARK: - MoreOptionsView

extension MoreOptionsViewController: MoreOptionsPresenterToViewProtocol {
    func showError() {
        
    }
}

extension MoreOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MoreOptionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let cell = tab
        return UITableViewCell()
    }
}

// MARK: - Subviews creation

private extension MoreOptionsViewController {
    var _tableView: UITableView {
        let result = UITableView(frame: .zero, style: .insetGrouped)
        result.delegate = self
        result.dataSource = self
        return result
    }
}  
