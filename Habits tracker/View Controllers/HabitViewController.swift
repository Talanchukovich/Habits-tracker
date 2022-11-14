//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    private var dismisHabitDetailsComlition: (()->Void)?
    private var habitMode: HabitViewMode?
    private var habit: Habit?
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
        
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
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
        if case .editing(let habit) = habitMode {
            self.habit = habit
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
            
            guard let habitName = self?.habit?.name else {return}
            let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habitName)\"?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            let deleteAction = UIAlertAction(title:  "Удалить", style: .destructive) {[weak self] _ in
                HabitsStore.shared.habits.removeAll(where: {$0 == self?.habit})
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            self?.present(alert, animated: true)
        }
    }
    
    @objc func saveHabit() {
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
            guard let habit else{return}
            guard let insertIndex = HabitsStore.shared.habits.firstIndex(of: habit) else {return}
            HabitsStore.shared.habits.remove(at: insertIndex)
            HabitsStore.shared.habits.insert(newHabit, at: insertIndex)
            dismisHabitDetailsComlition?()
        case .none:
            return
        }
        dismiss(animated: true)
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
