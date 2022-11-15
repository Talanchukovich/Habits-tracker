//
//  HabitView.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 31.10.2022.
//

import UIKit

class HabitView: UIView {
    
    struct ViewModel {
        var habit: Habit
        var buttonIsHidden: Bool
    }
    
    var habitColorPickerCompletion: (()-> Void)?
    var deleteButtonCompletion: (()-> Void)?
    var habitName: String?
    var habitDate = Date()
    var habitColor = HabitsStore.shared.habits.last?.color ?? .red {
        didSet {
            habitColorPickerButton.backgroundColor = self.habitColor
        }
    }
    
    private var datePickerDateString: String {
        TextAttributes.dateFormatter.string(from: datePicker.date)
    }
    private var dateString: String {
        "Каждый день в " + datePickerDateString
    }
    
    private var attributeDateString: NSMutableAttributedString {
        let str = NSMutableAttributedString(string: "Каждый день в " + datePickerDateString)
        let location = dateString.count - datePickerDateString.count
        let length = datePickerDateString.count
        str.addAttributes(TextAttributes.dateLabelAttributes, range: NSRange(location: location, length: length))
        return str
    }
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        let text = "НАЗВАНИЕ"
        label.attributedText = NSAttributedString(string: text, attributes: TextAttributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .sentences
        textField.clearButtonMode = .whileEditing
        textField.defaultTextAttributes = TextAttributes.habitTextFieldTextlAttributes
        let text = "Бегать по утрам, спать 8 часов и т.п"
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: TextAttributes.habitTextFieldPlaceHolderlAttributes)
        textField.addTarget(self, action: #selector(setHabitName), for: .editingChanged)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var habitColorLabel: UILabel = {
        let label = UILabel()
        let text = "ЦВЕТ"
        label.attributedText = NSAttributedString(string: text, attributes: TextAttributes.habitLabelAttributes)
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
        let text = "ВРЕМЯ"
        label.attributedText = NSAttributedString(string: text, attributes: TextAttributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitDateLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: dateString)
        let location = dateString.count - datePickerDateString.count
        let length = datePickerDateString.count
        attributedString.addAttributes(TextAttributes.dateLabelAttributes, range: NSRange(location: location, length: length))
        label.attributedText = attributeDateString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker = UIDatePicker(frame: .zero)
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(string: "Удалить привычку", attributes: TextAttributes.deleteButtonAttributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateViewModel(viewModel: ViewModel) {
        habitName = viewModel.habit.name
        habitTextField.text = habitName
        habitColor = viewModel.habit.color
        datePicker.date = viewModel.habit.date
        deleteButton.isHidden = viewModel.buttonIsHidden
        setHabitDate()
    }
    
    func showKeyboardAfterCloseAlert() {
        habitTextField.becomeFirstResponder()
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(setHabitDate), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupView() {
        self.backgroundColor = .systemGray6
        self.translatesAutoresizingMaskIntoConstraints = false
        let mainViewes = [habitNameLabel, habitTextField, habitColorLabel, habitColorPickerButton, dateLabel, habitDateLabel, datePicker, deleteButton]
        mainViewes.forEach({self.addSubview($0)})
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            habitNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            habitTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 7),
            habitTextField.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
            habitTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            habitColorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 15),
            habitColorLabel.leadingAnchor.constraint(equalTo: habitTextField.leadingAnchor),
            
            habitColorPickerButton.topAnchor.constraint(equalTo: habitColorLabel.bottomAnchor, constant: 7),
            habitColorPickerButton.leadingAnchor.constraint(equalTo: habitColorLabel.leadingAnchor),
            habitColorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            habitColorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: habitColorPickerButton.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: habitColorPickerButton.leadingAnchor),
            
            habitDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            habitDateLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 35),
            datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc private func setHabitDate() {
        habitDate = datePicker.date
        habitDateLabel.attributedText = attributeDateString
    }
    
    @objc private func setHabitName() {
        habitName = habitTextField.text
    }
    
    @objc private func habitColorPickerButtonAction() {
        habitTextField.resignFirstResponder()
        habitColorPickerCompletion?()
    }
    
    @objc private func deleteButtonAction() {
        deleteButtonCompletion?()
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
