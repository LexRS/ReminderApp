//
//  MoreTableViewCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 02.03.2023.
//

import Foundation
import UIKit

protocol MoreTableViewCellDelegate: AnyObject {
    
}

class MoreTableViewCell: UITableViewCell {
    weak var delegate: MoreTableViewCellDelegate?
    
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
    
    private lazy var moreLabel: UILabel = _moreLabel
    
    private func setupSubviews() {
        contentView.addSubview(moreLabel)
    }
    
    private func applyConstraints() {
        moreLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(120)
        }
    }
}

// MARK: - Subviews creation

private extension MoreTableViewCell {
    var _moreLabel: UILabel {
        let result = UILabel()
        result.text = "Details"
        return result
    }
}
