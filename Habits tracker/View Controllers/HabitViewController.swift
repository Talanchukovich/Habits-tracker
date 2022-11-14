//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    var dismisHabitDetailsComlition: (()->Void)?
    var habitMode: HabitViewMode?
    var habit: Habit?
    var indexPath: IndexPath?
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
    
    convenience init(habitMode: HabitViewMode, habit: Habit, indexPath: IndexPath) {
        self.init(nibName: nil, bundle: nil)
        self.habitMode = habitMode
        self.habit = habit
        self.indexPath = indexPath
    }
    
    convenience init(habitMode: HabitViewMode) {
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
        navigationItem.title = habitMode == .addind ? "Создать" : "Править"
        
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
        if habitMode == .editing {
            guard let habit else {return}
            let viewModel = HabitView.ViewModel(habit: habit, buttonIsHidden: false)
            habitView.updateViewModel(viewModel: viewModel)
        }
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
            let habitName = HabitsStore.shared.habits[indexPath.row].name
            let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habitName)\"?", preferredStyle: .alert)
            self.present(alert, animated: true)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel){_ in
                alert.dismiss(animated: true)
            }
            let deleteAction = UIAlertAction(title:  "Удалить", style: .destructive) {_ in
                HabitsStore.shared.habits.remove(at: indexPath.row)
                self.dismisHabitDetailsComlition?()
                self.navigationController?.dismiss(animated: true)
            }
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
        }
    }
    
    @objc func save() {
        guard let name = habitView.habitName else {
            let alert = UIAlertController(title: "Не заполнено поле", message: "Заполните поле название", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ок", style: .cancel){_ in
                alert.dismiss(animated: true)
                self.habitView.habitTextField.becomeFirstResponder()
            }
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            return
        }
        let date = habitView.habitDate
        let color = habitView.habitColor
        let newHabit = Habit(name: name, date: date, color: color)
        
        switch habitMode {
        case .addind:
            HabitsStore.shared.habits.append(newHabit)
        case .editing:
            guard let indexPath else {return}
            HabitsStore.shared.habits[indexPath.row].name = name
            HabitsStore.shared.habits[indexPath.row].date = date
            HabitsStore.shared.habits[indexPath.row].color = color
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
