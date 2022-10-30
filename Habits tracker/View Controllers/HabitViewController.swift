//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    let attributes = TextAttributes.shared
    
    private lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "НАЗВАНИЕ", attributes: attributes.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let habitTextField: UITextField = {
        let texField = UITextField()
        texField.defaultTextAttributes = TextAttributes.shared.habitTextFieldTextlAttributes
        texField.attributedPlaceholder = NSAttributedString(string: "Бегать по утрам, спать 8 часов и т.п", attributes: TextAttributes.shared.habitTextFieldPlaceHolderlAttributes)
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    
    let habitColorLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "ЦВЕТ", attributes: TextAttributes.shared.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let habitColorImageVie: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let habitDateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "ВРЕМЯ", attributes: TextAttributes.shared.habitLabelAttributes)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
//        let attributedText = NSAttributedString(string: "Каждый день в ", attributes: TextAttributes.shared.habitLabelAttributes)
//        let attributedDate = NSAttributedString(string: "Дата", attributes: TextAttributes.shared.dateLabelAttributes)
//        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .time
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        }
//        guard let localId = Locale.preferredLanguages.first else {return}
//        datePicker.locale = Locale(identifier: localId)
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        return datePicker
//    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarButtonItem()
        createView()
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        guard let localId = Locale.preferredLanguages.first else {return}
        datePicker.locale = Locale(identifier: localId)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(setDate), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
       
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94)
        navigationController?.navigationBar.titleTextAttributes = attributes.navigationTitleAttributes
        navigationItem.title = "Создать"
    }
    
    func setupBarButtonItem() {
        let backBarButton = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(cancell))
        backBarButton.setTitleTextAttributes(attributes.cancellBarButtonItemTitleAttributes, for: .normal)
        
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: nil, action: nil)
        rightBarButtonItem.setTitleTextAttributes(attributes.saveBarButtonItemTitleAttributes, for: .normal)
        
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func createView() {
        var mainViewes = [habitNameLabel, habitTextField, habitColorLabel, habitColorImageVie, habitDateLabel, dateLabel, datePicker]
        mainViewes.forEach({view.addSubview($0)})
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            habitNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        
            habitTextField.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 7),
            habitTextField.leadingAnchor.constraint(equalTo: habitNameLabel.leadingAnchor),
        
            habitColorLabel.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 15),
            habitColorLabel.leadingAnchor.constraint(equalTo: habitTextField.leadingAnchor),
            
            habitColorImageVie.topAnchor.constraint(equalTo: habitColorLabel.bottomAnchor, constant: 7),
            habitColorImageVie.leadingAnchor.constraint(equalTo: habitColorLabel.leadingAnchor),
            habitColorImageVie.widthAnchor.constraint(equalToConstant: 30),
            habitColorImageVie.heightAnchor.constraint(equalToConstant: 30),
            
            habitDateLabel.topAnchor.constraint(equalTo: habitColorImageVie.bottomAnchor, constant: 15),
            habitDateLabel.leadingAnchor.constraint(equalTo: habitColorImageVie.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: habitDateLabel.bottomAnchor, constant: 7),
            dateLabel.leadingAnchor.constraint(equalTo: habitDateLabel.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor)
        ])
    }
    
    @objc func cancell() {
        dismiss(animated: true)
    }
    
    @objc func setDate() {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        print("Done")
    }
}
