//
//  TableViewCell.swift
//  ReminderApp
//
//  Created by Алексей Поддубный on 10.04.2023.
//

import UIKit

protocol DateTimeTableViewCellDelegate: AnyObject {
    func datePickedInCell(date: Date)
}

class DateTimeTableViewCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = _dateLabel
    private lazy var dateSwitch: UISwitch = _dateSwitch
    
    weak var delegate: DateTimeTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIndentifier)
        setupSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(dateSwitch)
    }
    
    private func applyConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(200)
        }
        
        dateSwitch.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    // MARK: - Public
    
    func configure(for index: Int) {
        switch index {
        case 0:
            dateLabel.text = "Date"
        case 1:
            dateLabel.text = "Time"
        default:
            return
        }
    }
    
    @objc private func onSwitchValueChanged() {
        additionalView(isShown: dateSwitch.isOn)
    }
    
    private func additionalView(isShown: Bool) {
        
    }

}

private extension DateTimeTableViewCell {
    var _dateLabel: UILabel {
        let result = UILabel()
        result.font = .systemFont(ofSize: 18)
        return result
    }
    
    var _dateSwitch: UISwitch {
        let result = UISwitch()
        result.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
        return result
    }
}
