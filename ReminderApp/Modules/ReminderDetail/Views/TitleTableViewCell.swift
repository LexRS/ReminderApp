//
//  ReminderDetailTableViewCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 02.03.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol TitleTableViewCellDelegate: AnyObject {
    
}

class TitleTableViewCell: UITableViewCell {
    weak var delegate: TitleTableViewCellDelegate?
    
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
        disposeBag = DisposeBag()
    }

    // MARK: - Private
    
    private lazy var inputTextField: UITextField = _inputTextField
    
    private func setupSubviews() {
        contentView.addSubview(inputTextField)
    }
    
    private func applyConstraints() {
        inputTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - Public
    var disposeBag = DisposeBag()
    
    var rxInputText: Observable<String?> {
        inputTextField.rx.text.asObservable()
    }
}

extension TitleTableViewCell: UITextFieldDelegate {
    
}

// MARK: - Subviews

extension TitleTableViewCell {
    var _inputTextField: UITextField {
        let result = UITextField()
        result.placeholder = "Title"
        result.delegate = self
        return result
    }
}
