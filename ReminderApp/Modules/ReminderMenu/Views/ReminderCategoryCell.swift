//
//  ReminderCategoryCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 25.12.2022.
//

import Foundation
import UIKit
import SnapKit

class ReminderCategoryCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = _imageView
    private lazy var titleLabel: UILabel = _titleLabel
    private lazy var amountLabel: UILabel = _amountLabel
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentView.clipsToBounds = true
        layer.cornerRadius = 10
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    // MARK: - Public
    
    func configure(with reminders: [Reminder], for index: Int) {
        switch index {
        case 0:
            titleLabel.text = "All"
            amountLabel.text = String(reminders.count)
            imageView.image = UIImage(systemName: "square.and.pencil")
        case 1:
            titleLabel.text = "Next Week"
            amountLabel.text = String(reminders.count)
            imageView.image = UIImage(systemName: "folder.fill")
        case 2:
            titleLabel.text = "Completed"
            amountLabel.text = String(reminders.count)
            imageView.image = UIImage(systemName: "tray.full")
        default:
            return
        }
    }
}

private extension ReminderCategoryCell {
    var _imageView: UIImageView {
        let result = UIImageView()
        result.contentMode = .scaleAspectFit
        return result
    }
    
    var _titleLabel: UILabel {
        let result = UILabel()
        result.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        return result
    }
    
    var _amountLabel: UILabel {
        let result = UILabel()
        result.textAlignment = .center
        result.font = UIFont(name: "AmericanTypewriter-Bold", size: 36)
        return result
    }
}
