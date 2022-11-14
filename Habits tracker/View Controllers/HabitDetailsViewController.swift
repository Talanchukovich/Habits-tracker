//
//  HabitDetailsViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 03.11.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let habitViewController = HabitViewController()
    
    private var navigationTitle: String?
    private var habit: Habit?
    
    private lazy var attributes = TextAttributes.shared
    private lazy var habitDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: "HabitDetailsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    convenience init(habit: Habit) {
        self.init(nibName: nil, bundle: nil)
        self.navigationTitle = habit.name
        self.habit = habit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHabitDetailsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = attributes.navigationTitleAttributes
        navigationItem.title = navigationTitle
        
        let arrowBackBarButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "Arrow")))
        let textBackBarButton = UIBarButtonItem(title: "Сегодня", style: .done, target: self, action: #selector(cancel))
        textBackBarButton.setTitleTextAttributes(attributes.cancellBarButtonItemTitleAttributes, for: .normal)
        let rightBarButton = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editHabit))
        rightBarButton.setTitleTextAttributes(attributes.cancellBarButtonItemTitleAttributes, for: .normal)
        navigationItem.leftBarButtonItems = [arrowBackBarButton, textBackBarButton]
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupHabitDetailsTableView() {
        view.addSubview(habitDetailsTableView)
        
        NSLayoutConstraint.activate([
            habitDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitDetailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitDetailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    @objc func editHabit(){
        guard let habit else {return}
        habitViewController = 
//        let habitViewController = UINavigationController(rootViewController: HabitViewController(habitMode: .editing(habit)))
        habitViewController.modalPresentationStyle = .fullScreen
        self.present(habitViewController, animated: true)
    }
    
    @objc func cancel(){
        navigationController?.popViewController(animated: true)
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = habitDetailsTableView.dequeueReusableCell(withIdentifier: "HabitDetailsTableViewCell", for: indexPath) as? HabitDetailsTableViewCell else {
            let cell = habitDetailsTableView.dequeueReusableCell(withIdentifier: "HabitDetailsTableViewCell", for: indexPath)
            return cell}
        guard let habit else {return cell}
        let date = HabitsStore.shared.dates[indexPath.row]
        guard let dateString = HabitsStore.shared.trackDateString(forIndex: indexPath.row) else {return cell}
        let isHidden = !HabitsStore.shared.habit(habit, isTrackedIn: date)
        let viewModel = HabitDetailsTableViewCell.ViewModel(dateLabelText: dateString, isHidden: isHidden)
        cell.setupView(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
