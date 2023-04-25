//
//  RemindersListTableViewCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 03.04.2023.
//

import Foundation
import UIKit

protocol RemindersListTableViewCellDelegate: AnyObject {
    //func 
}

class RemindersListTableViewCell: UITableViewCell {
    
    weak var delegate: RemindersListTableViewCellDelegate?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: nil)
    }
    
    // MARK: - Public
    
    func configure(with reminder: Reminder?) {
        guard let reminder = reminder else {
            return
        }
        titleLabel.text = reminder.title
    }
    
    // MARK: - Private
    
    private lazy var titleLabel: UILabel = _titleLabel
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func applyConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    } 
    
    // MARK: - Actions
    
    
}

// MARK: - Subviews creation

private extension RemindersListTableViewCell {
    var _titleLabel: UILabel {
        let result = UILabel()
        result.font = .systemFont(ofSize: 22)
        return result
    }
}  
