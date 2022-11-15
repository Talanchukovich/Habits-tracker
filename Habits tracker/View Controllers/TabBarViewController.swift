//
//  TabBarViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewTabBar()
        setupTabBar()
    }
    
    private func setupViewTabBar() {
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        tabBar.backgroundColor = UIColor.white
        tabBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    private func setupTabBar() {
        let habitsViewController = createNavigationController(viewController: HabitsViewController(), title: "Привычки", imageName: "Glyph")
        let infoViewController = createNavigationController(viewController: InfoViewController(), title: "Информация", imageName: "SF Symbol")
        viewControllers = [habitsViewController, infoViewController]
    }
    
    private func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        let item = UITabBarItem(title: title, image: UIImage(named: imageName), tag: 0)
        item.setTitleTextAttributes(TextAttributes.self.tabBarAttributes, for: .normal)
        navigationController.tabBarItem = item
        return navigationController
    }
}
