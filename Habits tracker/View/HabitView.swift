//
//  HabitView.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 31.10.2022.
//

import UIKit

class HabitView: UIView {
    
    private lazy var attributes = TextAttributes.shared
    private var leftPartDateLabelText = "Каждый день в "
    
    private var datePickerDateString: String {
        dateFormatter.string(from: datePicker.date)
    }
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "НАЗВАНИЕ", attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var habitTextField: UITextField = {
        let texField = UITextField()
        texField.defaultTextAttributes = attributes.habitTextFieldTextlAttributes
        texField.attributedPlaceholder = NSAttributedString(string: "Бегать по утрам, спать 8 часов и т.п", attributes: attributes.habitTextFieldPlaceHolderlAttributes)
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    
    private lazy var habitColorLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "ЦВЕТ", attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var habitColorPicker:
    
    private lazy var habitDateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "ВРЕМЯ", attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = createAttributedText(leftString: leftPartDateLabelText, rightString: datePickerDateString)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker = UIDatePicker(frame: .zero)
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .time
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
//        guard let localId = Locale.preferredLanguages.first else {return}
//        datePicker.locale = Locale(identifier: localId)
//        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        return datePicker
//    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAttributedText(leftString: String, rightString: String, attributes: [NSAttributedString.Key : Any]? = nil) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(string: leftString + rightString, attributes: attributes)
        string.addAttributes(self.attributes.dateLabelAttributes, range: NSRange(location: leftString.count, length: rightString.count))
        return string
    }
    
    private func createView() {
        self.backgroundColor = .systemGray6
        self.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        guard let localId = Locale.preferredLanguages.first else {return}
        datePicker.locale = Locale(identifier: localId)
        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let mainViewes = [habitNameLabel, habitTextField, habitColorLabel, habitColorPickerButton, habitDateLabel, dateLabel, datePicker]
        mainViewes.forEach({self.addSubview($0)})
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            habitNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        
            habitTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 7),
            habitTextField.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
        
            habitColorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 15),
            habitColorLabel.leadingAnchor.constraint(equalTo: habitTextField.leadingAnchor),
            
            habitColorPickerButton.topAnchor.constraint(equalTo: habitColorLabel.bottomAnchor, constant: 7),
            habitColorPickerButton.leadingAnchor.constraint(equalTo: habitColorLabel.leadingAnchor),
            habitColorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            habitColorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            
            habitDateLabel.topAnchor.constraint(equalTo: habitColorPickerButton.bottomAnchor, constant: 15),
            habitDateLabel.leadingAnchor.constraint(equalTo: habitColorPickerButton.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: habitDateLabel.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: habitDateLabel.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor)
        ])
    }
    
    @objc func setDate() {
        let newDate = dateFormatter.string(from: datePicker.date)
        dateLabel.attributedText = createAttributedText(leftString: leftPartDateLabelText, rightString: newDate)
    }
}
