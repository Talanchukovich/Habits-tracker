//
//  HabitsViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Сегодня"
    }
    
    func setupRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Symbol")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(pushHabitViewController))
    }
    
    @objc func pushHabitViewController(){
        let habitViewController = UINavigationController(rootViewController: HabitViewController())
        habitViewController.modalPresentationStyle = .fullScreen
        self.present(habitViewController, animated: true)
    }
}
