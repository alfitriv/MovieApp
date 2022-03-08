//
//  ResultsViewController.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import UIKit

enum ResultsSection {
    case date
    case list
}

protocol ResultsViewControllerDelegate: AnyObject {
    func movieDidSetAsFavorite(movie: Result)
    func removeFromFavorite(movie: Result)
    func displayResults(movies: [Result])
}

class ResultsViewController: UIViewController {
    private let presenter: ResultsPresenterDelegate
    @IBOutlet weak var tableView: UITableView!
    var movieList: [Result]?
    var favoritedMovies: [Result]?
    var sections: [ResultsSection]?
    weak var delegate: ResultsViewControllerDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    
    
    init(presenter: ResultsPresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Music"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "results")
        tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "date")
        sections = [ResultsSection.date, ResultsSection.list]
        
        self.presenter.fetchMovieResults(keyword: "Adam")
        
    }
    
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections?[section]
        switch section {
        case .date:
            return 1
        case .list:
            return movieList?.count ?? 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections?[indexPath.section]
        
        switch section {
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath) as? DateTableViewCell
            if UserDefaults.standard.string(forKey: "lastVisited") != nil {
                cell?.dateLabel.text = UserDefaults.standard.string(forKey: "lastVisited")
            } else {
                cell?.setupDate()
            }
            return cell ?? DateTableViewCell()
        case .list:
            let cell = tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as? ResultsTableViewCell
            let movie = movieList?[indexPath.row] ?? Result(artistName: "", trackName: "", collectionName: "", artworkUrl60: "", trackPrice: 0.0, longDescription: "", primaryGenreName: "")
            cell?.favoritedMovies = favoritedMovies
            cell?.setUpCell(data: movie)
            
            for item in favoritedMovies ?? [Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, artworkUrl100: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil)] {
                if item.uuid == movie.uuid {
                    cell?.isFavorite = true
                    cell?.favoriteIcon.image = UIImage(systemName: "heart.fill")
                }
            }

            cell?.delegate = self
            return cell ?? UITableViewCell()
        case .none:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList?[indexPath.row] ?? Result(artistName: "", trackName: "", collectionName: "", artworkUrl60: "", trackPrice: 0.0, longDescription: "", primaryGenreName: "")
        let detailVC = DetailViewController()
        detailVC.movie = movie
        self.navigationController?.present(detailVC, animated: true, completion: nil)
    }
}

extension ResultsViewController: ResultsTableViewCellDelegate {
    func removeFromFavorite(movie: Result) {
        delegate?.removeFromFavorite(movie: movie)
    }
    
    func movieDidSetAsFavorite(movie: Result) {
        delegate?.movieDidSetAsFavorite(movie: movie)
    }
    
    func displayResults(movies: [Result]) {
        self.movieList = movies
        self.tableView.reloadData()
    }

}

extension ResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchKeywordStr = replaceSpace(searchController.searchBar.text!)
        if searchController.searchBar.text?.count ?? 0 > 3 {
            self.presenter.fetchMovieResults(keyword: searchKeywordStr)
            self.tableView.reloadData()
        }
    }
    
    private func replaceSpace(_ inputStr: String) -> String {
            let outputStr = inputStr.replacingOccurrences(of: " ", with: "%20")
            return outputStr
        }
}

