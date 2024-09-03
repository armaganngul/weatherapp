//
//  TabViewController.swift
//  ASISProject2
//
//  Created by Armağan Gül on 8.08.2024.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tab1 = WeatherViewController()
        tab1.title = "Weather"
        
        let tab2 = MapViewController()
        tab2.title = "Map View"
        
        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        nav1.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Map View", image: UIImage(systemName: "map"), tag: 2)
        
        
        viewControllers = [nav1,nav2]
    }
}
