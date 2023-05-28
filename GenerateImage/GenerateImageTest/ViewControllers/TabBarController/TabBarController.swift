//
//  TabBarController.swift
//  GenerateImageTest
//
//  Created by Anton  on 23.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addItems()
        customizeTabBarAppearance()
    }
}

private extension TabBarController {
    
    private func setUp() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func addItems() {
        let firstItem = UITabBarItem(
            title: "Создать",
            image: UIImage(named: "home.png"),
            tag: 0
        )
        
        let imageViewController = ImageViewController()
        imageViewController.tabBarItem = firstItem
        
        let secondItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(named: "fav.png"),
            tag: 1
        )
        
        let favouritesViewController = FavouritesViewController()
        favouritesViewController.tabBarItem = secondItem
        
        viewControllers = [imageViewController, favouritesViewController]
    }
    
    private func customizeTabBarAppearance() {
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
        tabBar.layer.borderWidth = 1.0
        tabBar.layer.borderColor = UIColor.gray.cgColor
    }
}
