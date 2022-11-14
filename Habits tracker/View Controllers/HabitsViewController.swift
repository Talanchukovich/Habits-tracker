//
//  HabitsViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var habitsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionLayout())
        view.backgroundColor = .systemGray6
        view.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        view.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRightBarButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        habitsCollectionView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Сегодня"
        
        view.addSubview(habitsCollectionView)
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func setupRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Symbol")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(addHabit))
    }
    
    func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                return self.createSectionLayout(sectionIndex: sectionIndex)
            } else {
                return self.createSectionLayout(sectionIndex: sectionIndex)}
        }
        return layout
    }
    
    func createSectionLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        if sectionIndex == 1 {
            item.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
        }
        var groupHeight: CGFloat
        if sectionIndex == 0 {
            groupHeight = 60
        } else {
            groupHeight = 130
        }
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        if sectionIndex == 0 {
            section.contentInsets = .init(top: 22, leading: 16, bottom: 0, trailing: 16)
        } else {
            section.contentInsets = .init(top: 18, leading: 16, bottom: 6, trailing: 16)
        }
        return section
    }
    
    @objc func addHabit(){
        let navHabitViewController = UINavigationController(rootViewController: HabitViewController(habitMode: .addind))
        navHabitViewController.modalPresentationStyle = .fullScreen
        self.present(navHabitViewController, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let progressCell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as? ProgressCollectionViewCell else {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath)
            return cell}
        progressCell.layer.cornerRadius = 8
        let progressViewModel = ProgressCollectionViewCell.ViewModel(todayProgress: HabitsStore.shared.todayProgress)
        UIView.animate(withDuration: 0.3) {
            progressCell.updateView(viewModel: progressViewModel)
        }
        
        
        guard let habitCell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as? HabitCollectionViewCell else {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath)
            return cell
        }
        
        if HabitsStore.shared.habits.isEmpty == false {
            let habit = HabitsStore.shared.habits[indexPath.row]
            let habitViewModel = HabitCollectionViewCell.ViewModel(name: habit.name,
                                                                   date: habit.date,
                                                                   color: habit.color,
                                                                   count: habit.trackDates.count,
                                                                   isAlreadyTakenToday: habit.isAlreadyTakenToday)
            habitCell.updateView(viewModel: habitViewModel)
            habitCell.trackHabitComletision = {
                if habit.isAlreadyTakenToday == false {
                    HabitsStore.shared.track(habit)
                    habitCell.habitCircleButton.backgroundColor = habit.color
                    collectionView.reloadData()
                }
            }
            habitCell.layer.cornerRadius = 8
        }
        switch indexPath.section {
        case 0:
            return progressCell
        default:
            return habitCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habit = HabitsStore.shared.habits[indexPath.row]
        let habitDetailsViewController = HabitDetailsViewController(habit: habit)
        navigationController?.pushViewController(habitDetailsViewController, animated: true)
    }
}
