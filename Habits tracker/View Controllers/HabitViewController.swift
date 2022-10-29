//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Создать"
        navigationController?.navigationBar.titleTextAttributes = TextAttributes.shared.navigationTitleAttributedString
    }
}
