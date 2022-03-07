//
//  ResultsViewController.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import UIKit

protocol ResultsViewControllerDelegate: AnyObject {
    func movieDidSetAsFavorite(movie: Result)
}

class ResultsViewController: UIViewController {
    private let movieService: MovieService
    @IBOutlet weak var tableView: UITableView!
    var movieList: [Result]?
    weak var delegate: ResultsViewControllerDelegate?
    
    
    init(movieService: MovieService) {
            self.movieService = movieService
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "results")

        self.movieService.fetchResults(searchText: "Adam") { response in
            print(response)
            self.movieList = response.results
            self.tableView.reloadData()
        } errorHandler: { error in
            print(error)
        }

    }

}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as? ResultsTableViewCell
        let movie = movieList?[indexPath.row] ?? Result(artistName: "", trackName: "", collectionName: "", artworkUrl60: "", trackPrice: 0.0, longDescription: "", primaryGenreName: "")
        cell?.setUpCell(data: movie)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension ResultsViewController: ResultsTableViewCellDelegate {
    func movieDidSetAsFavorite(movie: Result) {
        delegate?.movieDidSetAsFavorite(movie: movie)
    }
    
    
}

