//
//  FavoritesViewController.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import UIKit


class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var movieList: [Result]? = [] {
        didSet {
            print(movieList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "results")
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as? ResultsTableViewCell
        let data = movieList?[indexPath.row] ?? Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil)
        cell?.setUpCell(data: data)
        return cell ?? UITableViewCell()
    }
    
    
}
