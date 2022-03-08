//
//  HomeViewController.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import UIKit

class HomeViewController: UITabBarController {
    let movieService = NetworkLayer.shared
    let defaults = UserDefaults.standard
    var favoriteVC: FavoritesViewController?
    var resultVC: ResultsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        
    }
    
    /// This function sets up the VCs that we need in the tab bar along with its delegates
    func setupVCs() {
        let presenter = ResultsPresenter(service: movieService)
        presenter.delegate = self
        let resultVC = ResultsViewController(presenter: presenter)
        resultVC.delegate = self
        self.resultVC = resultVC
        
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
    func displayResults(movies: [Result]) {
        resultVC?.movieList = movies
        resultVC?.tableView.reloadData()
    }
    
    func movieDidSetAsFavorite(movie: Result) {
        favoriteVC?.movieList?.append(movie)
        resultVC?.favoritedMovies = favoriteVC?.movieList
    }
    
    func removeFromFavorite(movie: Result) {
        let currentList = favoriteVC?.movieList
        let indexToRemove = currentList?.firstIndex(where: { $0.trackName == movie.trackName }) ?? 0
        favoriteVC?.movieList?.remove(at: indexToRemove)
        resultVC?.favoritedMovies = favoriteVC?.movieList
    }
    
}

