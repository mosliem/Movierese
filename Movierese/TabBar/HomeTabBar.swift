//
//  HomeTabBar.swift
//  Movierese
//
//  Created by mohamedSliem on 7/7/22.
//

import UIKit

class HomeTabBar: UITabBarController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        vc1.title = "Home"
        vc1.navigationItem.largeTitleDisplayMode = .always
 
        let vc2 = SearchVC()
        vc2.title = "Search"
        vc2.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.navigationBar.prefersLargeTitles = true
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.navigationBar.prefersLargeTitles = true
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"),tag:1)
        
        setViewControllers([nav1 , nav2], animated: true)

        tabBar.tintColor = .gray
        tabBar.barTintColor = .clear
    }


}
