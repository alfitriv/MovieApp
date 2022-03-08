//
//  DetailViewController.swift
//  iTunesApp
//
//  Created by Mila on 08/03/22.
//

import UIKit

enum DetailSection {
    case image
    case description
}

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var movie: Result?
    var sections: [DetailSection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [DetailSection.image, DetailSection.description]
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "image")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "description")
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections?[section]
        
        switch section {
        case .image, .description:
            return 1
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections?[indexPath.section]
        
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as? ImageTableViewCell
            cell?.setImage(data: movie ?? Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil))
            return cell ?? UITableViewCell()
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "description", for: indexPath) as? DescriptionTableViewCell
            cell?.setupLabels(data: movie ?? Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil))
            return cell ?? UITableViewCell()
        case .none:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections?[indexPath.section]
        
        switch section {
        case .image:
            return 200
        case .description:
            return UITableView.automaticDimension
        case .none:
            return 0
        }
    }
    
    
}
