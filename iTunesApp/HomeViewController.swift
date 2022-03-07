//
//  HomeViewController.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import UIKit

class HomeViewController: UITabBarController {
    let movieService = NetworkLayer.shared
    var favoriteVC: FavoritesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        
    }
    
    func setupVCs() {
        let resultVC = ResultsViewController(movieService: movieService)
        resultVC.delegate = self
        
        let favoriteVC = FavoritesViewController()
        self.favoriteVC = favoriteVC
        viewControllers = [
            createNavController(for: resultVC, title: "List", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: favoriteVC, title: "Favorites", image: UIImage(systemName: "heart")!)
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

extension HomeViewController: ResultsViewControllerDelegate {
    func movieDidSetAsFavorite(movie: Result) {
        favoriteVC?.movieList?.append(movie)
    }
    
    func removeFromFavorite(movie: Result) {
        let currentList = favoriteVC?.movieList
        let indexToRemove = currentList?.firstIndex(where: { $0.trackName == movie.trackName }) ?? 0
        favoriteVC?.movieList?.remove(at: indexToRemove)
    }
    
}

