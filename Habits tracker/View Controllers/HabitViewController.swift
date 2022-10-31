//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habitComplition: (()->Void)?
    
    private lazy var attributes = TextAttributes.shared
    private lazy var habitView = HabitView()
    
    @available(iOS 14.0, *)
    var habitPickerViewController: UIColorPickerViewController {
        let vc = UIColorPickerViewController()
        vc.delegate = self
        vc.selectedColor = habitView.habitColor
        vc.supportsAlpha = true
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarButtonItem()
        presentHabitPickerViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
       
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = attributes.navigationTitleAttributes
        navigationItem.title = "Создать"
        
        view.addSubview(habitView)
        NSLayoutConstraint.activate([
            habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func setupBarButtonItem() {
        let backBarButton = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(cancell))
        backBarButton.setTitleTextAttributes(attributes.cancellBarButtonItemTitleAttributes, for: .normal)
        
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        rightBarButtonItem.setTitleTextAttributes(attributes.saveBarButtonItemTitleAttributes, for: .normal)
        
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func presentHabitPickerViewController() {
        habitView.completion = {[weak self] in
            guard let self else {return}
            if #available(iOS 14.0, *) {
                self.present(self.habitPickerViewController, animated: true)
            }
        }
    }
    
    @objc func save() {
        guard let name = habitView.habitName else {return}
        let date = habitView.habitDate
        let color = habitView.habitColor
        let newHabit = Habit(name: name,
                             date: date,
                             color: color)
        let store = HabitsStore.shared
        store.habits.insert(newHabit, at: 0)
        dismiss(animated: true){
            self.habitComplition?()
        }
    }
    
    @objc func cancell() {
        dismiss(animated: true)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitView.habitColor = viewController.selectedColor
    }
    
}
