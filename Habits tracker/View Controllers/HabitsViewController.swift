//
//  HabitsViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Symbol"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRightBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    func setupRightBarButton() {
        let barButton = UIBarButtonItem(customView: addButton)
        addButton.addTarget(self, action: #selector(pushHabitViewController), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [barButton]
    }
    
    @objc func pushHabitViewController(){
        let habitViewController = HabitViewController()
        navigationItem.title = ""
        self.navigationController?.pushViewController(habitViewController, animated: true)
    }
}
