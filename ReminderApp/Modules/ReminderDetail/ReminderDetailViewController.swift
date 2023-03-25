//
//  ReminderDetailViewController.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 26.02.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ReminderDetailViewController: UIViewController {
    var presenter: ReminderDetailViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        applyConstraints()
    }
    
    // MARK: - Private
    private var disposeBag = DisposeBag()
    
    private var tableSectionsCount: Int = 3
    private var descriptionSectionRowsCount: Int = 2
    private var detailedInfoSectionRowsCount: Int = 1
    private var userGroupSectionRowsCount: Int = 1
    
    private lazy var tableView: UITableView = _tableView
    private lazy var cancelBarButtonItem: UIBarButtonItem = _cancelBarButtonItem
    private lazy var addBarButtonItem: UIBarButtonItem = _addBarButtonItem
    
    private func setupSubviews() {
        title = "New reminder"
        view.addSubview(tableView)
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    //MARK: - Actions
    @objc func cancelBarButtonTapped() {
        presenter?.dismissReminderDetail()
    }
    
    @objc func addBarButtonTapped() {
        presenter?.saveReminder()
    }
}

extension ReminderDetailViewController: ReminderDetailPresenterToViewProtocol {
    func showError() {
        
    }
}

extension ReminderDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableSectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return descriptionSectionRowsCount
        case 1:
            return detailedInfoSectionRowsCount
        case 2:
            return userGroupSectionRowsCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = TitleTableViewCell()
                cell.rxInputText.map({ !($0?.isEmpty ?? true) }).bind(to: addBarButtonItem.rx.isEnabled)
                    .disposed(by: cell.disposeBag)
                cell.rxInputText.debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
                    .share(replay: 1)
                    .subscribe(onNext: { text in
                    guard let text = text else {
                        return
                    }
                    self.presenter?.setTitle(text)
                })
                .disposed(by: cell.disposeBag)
                return cell
            case 1:
                let cell = NotesTableViewCell()
                cell.delegate = self
                cell.notesInputText.subscribe(onNext: { text in
                    guard let text = text else {
                        return
                    }
                    self.presenter?.setNotes(text)
                })
                .disposed(by: disposeBag)
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            let cell = MoreTableViewCell()
            cell.accessoryType = .disclosureIndicator
            return cell
        case 2:
            let cell = UserGroupTableViewCell()
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ReminderDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1:
            presenter?.showMoreOptions()
        case 2:
            presenter?.showGroupSelection()
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.cellForRow(at: indexPath) as? NotesTableViewCell else {
            return 44.0
        }
        
        let size = CGSize(width: cell.bounds.width, height: 1)
        var result = cell.contentView.systemLayoutSizeFitting(size,
                                                              withHorizontalFittingPriority: .required,
                                                              verticalFittingPriority: .fittingSizeLevel)
        result.height = ceil(result.height)
        return result.height
    }
}

extension ReminderDetailViewController: NotesTableViewCellDelegate {
    func updateNotesTableViewCellHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

private extension ReminderDetailViewController {
    var _tableView: UITableView {
        let result = UITableView(frame: .zero, style: .insetGrouped)
        result.dataSource = self
        result.delegate = self
        return result
    }
    
    var _cancelBarButtonItem: UIBarButtonItem {
        let result = UIBarButtonItem(title: "Cancel",
                                     style: .plain,
                                     target: self,
                                     action: #selector(cancelBarButtonTapped))
        return result
    }
    
    var _addBarButtonItem: UIBarButtonItem {
        let result = UIBarButtonItem(title: "Add",
                                     style: .plain,
                                     target: self,
                                     action: #selector(addBarButtonTapped))
        return result
    }
    
//    var _titleTextField: UITextField {
//        let result = UITextField()
//        result.placeholder = "Заголовок"
//        result.delegate = self
//        return result
//    }
//
//    var _notesTextView: UITextView {
//        let result = UITextView()
//        result.translatesAutoresizingMaskIntoConstraints = false
//        result.isScrollEnabled = false
//        result.sizeToFit()
//        result.delegate = self
//        return result
//    }
    
    
    
//    var _userGroupLabel: UILabel {
//        let result = UILabel()
//        result.text = "Группа"
//        return result
//    }
//
//    var _selectedUserGroup: UILabel {
//        let result = UILabel()
//        return result
//    }
}
