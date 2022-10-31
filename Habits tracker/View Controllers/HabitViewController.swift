//
//  HabitViewController.swift
//  Habits tracker
//
//  Created by Andrey Talanchuk on 29.10.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    private lazy var attributes = TextAttributes.shared
    private lazy var habitView = HabitView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarButtonItem()
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
        
        let rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: nil, action: nil)
        rightBarButtonItem.setTitleTextAttributes(attributes.saveBarButtonItemTitleAttributes, for: .normal)
        
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func cancell() {
        dismiss(animated: true)
    }
}
