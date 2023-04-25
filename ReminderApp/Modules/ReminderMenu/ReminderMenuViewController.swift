//
//  ReminderMenuViewController.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.12.2022.
//

import UIKit
import SnapKit

class ReminderMenuViewController: UIViewController {
    var presenter: ReminderMenuViewToPresenterProtocol?
    
    var reminders: [Reminder] = []
    
    private lazy var searchBar: UISearchBar = _searchBar
    private lazy var layout: UICollectionViewFlowLayout = _collectionViewFlowLayout
    private lazy var collectionView: UICollectionView = _collectionView
    private lazy var addReminderButton: UIButton = _addReminderButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        applyConstraints()
        presenter?.fetchReminders()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(addReminderButton)
    }
    
    private func applyConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        addReminderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
    
    //MARK: - Actions
    
    @objc func addReminderButtonTapped(_ sender: UIButton) {
        presenter?.showReminderDetail(reminder: nil)
    }
}

extension ReminderMenuViewController: ReminderMenuPresenterToViewProtocol {
    func showReminders(_ reminders: [Reminder]) {
        self.reminders = reminders
    }
    
    func showError() {
        
    }
}

extension ReminderMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var remindersToShow = [Reminder]()
        switch indexPath.row {
        case 0:
            remindersToShow = reminders.filter({ $0.category == .All })
        case 1:
            remindersToShow = reminders.filter({ $0.category == .NextWeek })
        case 2:
            remindersToShow = reminders.filter({ $0.category == .Completed })
        default:
            return
        }
        presenter?.showReminderList(reminders: remindersToShow)
    }
}

extension ReminderMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderCategoryCell.reuseId, for: indexPath) as! ReminderCategoryCell
        var remindersToShow = [Reminder]()
        switch indexPath.row {
        case 0:
            remindersToShow = reminders.filter({ $0.category == .All })
        case 1:
            remindersToShow = reminders.filter({ $0.category == .NextWeek })
        case 2:
            remindersToShow = reminders.filter({ $0.category == .Completed })
        default:
            return cell
        }
        cell.configure(with: remindersToShow, for: indexPath.row)
        return cell
    }
    
    
}

// MARK: - Subviews creation
private extension ReminderMenuViewController {
    var _searchBar: UISearchBar {
        let result = UISearchBar()
        return result
    }
    
    var _collectionViewFlowLayout: UICollectionViewFlowLayout {
        let result = UICollectionViewFlowLayout()
        result.scrollDirection = .horizontal
        result.itemSize = CGSize(width: view.frame.width / 2, height: view.frame.height * 0.2)
        result.minimumLineSpacing = 5
        // result.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
        return result
    }
    
    var _collectionView: UICollectionView {
        let result = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        result.register(ReminderCategoryCell.self, forCellWithReuseIdentifier: ReminderCategoryCell.reuseId)
        result.delegate = self
        result.dataSource = self
        result.showsHorizontalScrollIndicator = false
        return result
    }
    
    var _addReminderButton: UIButton {
        let result = UIButton()
        result.setTitle("Reminder", for: .normal)
        result.setTitleColor(.systemBlue, for: .normal)
        result.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        result.addTarget(self, action: #selector(addReminderButtonTapped(_:)), for: .touchUpInside)
        return result
    }
}
