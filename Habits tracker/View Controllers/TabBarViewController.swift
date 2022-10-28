//
//  TabBarViewController.swift
//  Habits tracker
//
//  Created by Андрей Таланчук on 28.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    var habitsViewController: UINavigationController!
    var infoViewController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupHabitsItem()
        setupInfoItem()
    }
    
    func setupTabBar() {
        habitsViewController = UINavigationController.init(rootViewController: HabitsViewController())
        infoViewController = UINavigationController.init(rootViewController: InfoViewController())
        self.viewControllers = [habitsViewController, infoViewController]
        view.backgroundColor = .white
        view.layer.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 0.8).cgColor
    }
    
    func setupHabitsItem(){
        
        var button: UIButton = {
            
            let button = UIButton(frame: CGRect(x: (tabBar.frame.width / 4) - 23 / 2, y: self.tabBar.bounds.minY + 7, width: 23, height: 23))
            button.backgroundColor = .green
            return button
        }()
        tabBar.addSubview(button)
        habitsViewController.tabBarItem.title = "Привычки"
        habitsViewController.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        tabBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    func setupInfoItem(){
        infoViewController.tabBarItem.title = "Информация"
        infoViewController.tabBarItem.image = UIImage(systemName: "info.circle.fill")
        tabBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    }
    
    
}
