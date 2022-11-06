//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var habitMode: HabitMode?
    var habit: Habit?
    var indexPath: IndexPath?
    private lazy var attributes = TextAttributes.shared
    private lazy var habitView = HabitView()
    
    @available(iOS 14.0, *)
    var habitPickerViewController: UIColorPickerViewController {
        let vc = UIColorPickerViewController()
        vc.delegate = self
        vc.selectedColor = habitView.habitColor ?? .red
        vc.supportsAlpha = true
        return vc
    }
    
    convenience init(habitMode: HabitMode, habit: Habit, indexPath: IndexPath) {
        self.init(nibName: nil, bundle: nil)
        self.habitMode = habitMode
        self.indexPath = indexPath
        self.habit = habit
    }
    
    convenience init(habitMode: HabitMode) {
        self.init(nibName: nil, bundle: nil)
        self.habitMode = habitMode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHabitView()
        updateHabitView()
        presentHabitPickerViewController()
        deleteHabit()
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = attributes.navigationTitleAttributes
        navigationItem.title = "Создать"
        
        let backBarButton = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(cancell))
        backBarButton.setTitleTextAttributes(attributes.cancellBarButtonItemTitleAttributes, for: .normal)
        
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        rightBarButtonItem.setTitleTextAttributes(attributes.saveBarButtonItemTitleAttributes, for: .normal)
        
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupHabitView() {
        view.addSubview(habitView)
        NSLayoutConstraint.activate([
            habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func updateHabitView() {
        let color = HabitsStore.shared.habits.last?.color
        var viewModel: HabitView.ViewModel
        switch habitMode {
        case .addind:
            viewModel = HabitView.ViewModel(habitName: "", habitDate: Date(), habitColor: color ?? .red, buttonIsHidden: true)
        case .editing:
            guard let habit else {return}
            viewModel = HabitView.ViewModel(habitName: habit.name, habitDate: habit.date, habitColor: habit.color, buttonIsHidden: false)
        case .none:
            return
        }
        habitView.updateViewModel(viewModel: viewModel)
    }
    
    func presentHabitPickerViewController() {
        habitView.habitColorPickerCompletion = {[weak self] in
            guard let self else {return}
            if #available(iOS 14.0, *) {
                self.present(self.habitPickerViewController, animated: true)
            }
        }
    }
    
    func deleteHabit() {
        habitView.deleteButtonCompletion = {[weak self] in
            guard let self else {return}
            guard let indexPath = self.indexPath else {return}
            HabitsStore.shared.habits.remove(at: indexPath.row)
            self.dismiss(animated: true)
        }
       
    }
    
    @objc func save() {
        guard let name = habitView.habitName else {return}
        guard let date = habitView.habitDate else {return}
        guard let color = habitView.habitColor else {return}
        let newHabit = Habit(name: name, date: date, color: color)
        switch habitMode {
        case .addind:
            HabitsStore.shared.habits.append(newHabit)
        case .editing:
            guard let indexPath else {return}
            HabitsStore.shared.habits.remove(at: indexPath.row)
            HabitsStore.shared.habits.insert(newHabit, at: indexPath.row)
        case .none:
            return
        }
            dismiss(animated: true) {[weak self] in
                self?.habitView.habitTextField.text?.removeAll()
            }

    }
    
    @objc func cancell() {
        dismiss(animated: true)
        {[weak self] in
            self?.habitView.habitColor = HabitsStore.shared.habits.last?.color ?? .red
            self?.habitView.habitTextField.text?.removeAll()
        }
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitView.habitColor = viewController.selectedColor
    }
    
}
