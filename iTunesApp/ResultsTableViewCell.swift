//
//  ResultsTableViewCell.swift
//  iTunesApp
//
//  Created by Mila on 07/03/22.
//

import UIKit
import Kingfisher

protocol ResultsTableViewCellDelegate: AnyObject {
    func movieDidSetAsFavorite(movie: Result)
}

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var genreType: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    weak var delegate: ResultsTableViewCellDelegate?
    var movie: Result?
    
    
    func setUpCell(data: Result) {
        self.movie = data
        let url = URL(string: data.artworkUrl60 ?? "")
        avatarImageView.kf.setImage(with: url)
        trackName.text = data.trackName
        genreType.text = data.primaryGenreName
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favoriteIcon.isUserInteractionEnabled = true
        favoriteIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        delegate?.movieDidSetAsFavorite(movie: movie ?? Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil))
    }
    
    
}
