//
//  HomeViewController.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import UIKit

class HomeViewController: UITabBarController {
    let movieService = NetworkLayer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: ResultsViewController(movieService: movieService), title: "List", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: FavoritesViewController(), title: "Favorites", image: UIImage(systemName: "heart")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
