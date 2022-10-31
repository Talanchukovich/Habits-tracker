//
//  HabitView.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 31.10.2022.
//

import UIKit

class HabitView: UIView {
    
    let attributes = TextAttributes.shared
    var completion: (()-> Void)?
    var habitName: String?
    var habitDate = Date()
    var habitColor = HabitsStore.shared.habits.last?.color ?? .red {
        didSet {
            habitColorPickerButton.backgroundColor = self.habitColor
        }
    }
    
    private lazy var leftPartDateLabelText = "Каждый день в "
    
    private var datePickerDateString: String {
        dateFormatter.string(from: datePicker.date)
    }
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "НАЗВАНИЕ",
                                                  attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var habitTextField: UITextField = {
        let texField = UITextField()
        texField.defaultTextAttributes = attributes.habitTextFieldTextlAttributes
        texField.attributedPlaceholder = NSAttributedString(string: "Бегать по утрам, спать 8 часов и т.п",
                                                            attributes: attributes.habitTextFieldPlaceHolderlAttributes)
        texField.delegate = self
        texField.addTarget(self, action: #selector(setHabitName), for: .editingChanged)
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    
    private lazy var habitColorLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "ЦВЕТ",
                                                  attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = habitColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(habitColorPickerButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "ВРЕМЯ",
                                                  attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var HabitDateLabel: UILabel = {
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
    
     lazy var dateFormatter: DateFormatter = {
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
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(setHabitDate), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let mainViewes = [habitNameLabel, habitTextField, habitColorLabel, habitColorPickerButton, dateLabel, HabitDateLabel, datePicker]
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
            
            dateLabel.topAnchor.constraint(equalTo: habitColorPickerButton.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: habitColorPickerButton.leadingAnchor),
            
            HabitDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            HabitDateLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 35),
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc func setHabitName() {
        habitName = habitTextField.text
    }
    
    @objc func setHabitDate() {
        let date = datePicker.date
        habitDate = date
        let newDate = dateFormatter.string(from: date)
        HabitDateLabel.attributedText = createAttributedText(leftString: leftPartDateLabelText, rightString: newDate)
    }
    
    @objc func habitColorPickerButtonAction() {
        habitTextField.resignFirstResponder()
        completion?()
    }
}

extension HabitView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == " " && textField.text == "" {
            return false
        }
        return true
    }
}
