//
//  UserGroupsTableViewCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 02.03.2023.
//

import Foundation
import UIKit

protocol UserGroupTableViewCellDelegate: AnyObject {
    
}

class UserGroupTableViewCell: UITableViewCell {
    weak var delegate: UserGroupTableViewCellDelegate?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private lazy var infoLabel: UILabel = _infoLabel
    private lazy var groupLabel: UILabel = _groupLabel
    
    private func setupSubviews() {
        contentView.addSubview(infoLabel)
        contentView.addSubview(groupLabel)
    }
    
    private func applyConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(80)
        }
        
        groupLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(80)
        }
    }
}

private extension UserGroupTableViewCell {
    var _infoLabel: UILabel {
        let result = UILabel()
        result.text = "Group"
        return result
    }
    
    var _groupLabel: UILabel {
        let result = UILabel()
        return result
    }
}
