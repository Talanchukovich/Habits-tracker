//
//  HabitsViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return layout
    }()
    
    lazy var habitsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemGray6
        view.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
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
        navigationController?.navigationBar.backgroundColor = .white
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
            action: #selector(pushHabitViewController))
    }
    
    @objc func pushHabitViewController(){
        let habitViewController = UINavigationController(rootViewController: HabitViewController(habitMode: .addind))
        habitViewController.modalPresentationStyle = .fullScreen
        self.present(habitViewController, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as? HabitCollectionViewCell else {
            let cell = habitsCollectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath)
            return cell
        }
        
        let habit = HabitsStore.shared.habits[indexPath.row]
        let habitViewModel = HabitCollectionViewCell.ViewModel(name: habit.name,
                                                               date: habit.date,
                                                               color: habit.color,
                                                               count: habit.trackDates.count,
                                                               isAlreadyTakenToday: habit.isAlreadyTakenToday)
        
        cell.updateView(viewModel: habitViewModel)
        cell.comletisionToHabitsVC = {[weak self] in
            if habit.isAlreadyTakenToday == false {
                HabitsStore.shared.track(habit)
                cell.habitCircleButton.backgroundColor = habit.color
                self?.habitsCollectionView.reloadData()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - layout.sectionInset.left * 2
        return CGSize(width: width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? HabitCollectionViewCell else {return}
        let habit = HabitsStore.shared.habits[indexPath.row]
        let habitDetailsViewController = UINavigationController(rootViewController: HabitDetailsViewController(navigationTitle: item.habitNameLabel.text ?? "", habit: habit, indexPax: indexPath))
        habitDetailsViewController.modalPresentationStyle = .fullScreen
        self.present(habitDetailsViewController, animated: true)
    }
}
