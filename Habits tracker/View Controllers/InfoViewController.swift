//
//  InfoViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
//        navigationController?.navigationBar.backgroundColor = .white
//        navigationController?.navigationBar.titleTextAttributes = TextAttributes.shared.navigationTitleAttributedString
        navigationItem.title = "Информация"
    }
}
