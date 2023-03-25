//
//  NotesTableViewCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 02.03.2023.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol NotesTableViewCellDelegate: AnyObject {
    func updateNotesTableViewCellHeight()
}

class NotesTableViewCell: UITableViewCell {
    weak var delegate: NotesTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private lazy var inputTextView: UITextView = _inputTextView
    
    private func setupSubviews() {
        contentView.addSubview(inputTextView)
    }
    
    private func applyConstraints() {
        inputTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    //MARK: - Public
    
    var notesInputText: Observable<String?> {
        inputTextView.rx.text.asObservable()
    }
}

extension NotesTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.updateNotesTableViewCellHeight()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let text = textView.text, text == "Notes" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = textView.text, text == "" {
            textView.textColor = UIColor.systemGray3
            textView.text = "Notes"
        }
    }
}

// MARK: - Subviews creation

private extension NotesTableViewCell {
    var _inputTextView: UITextView {
        let result = UITextView()
        result.sizeToFit()
        result.isScrollEnabled = false
        result.font = .systemFont(ofSize: 16)
        result.delegate = self
        result.text = "Notes"
        result.textColor = UIColor.systemGray3
        return result
    }
}
