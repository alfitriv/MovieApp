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
    func removeFromFavorite(movie: Result)
}

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var genreType: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate: ResultsTableViewCellDelegate?
    var movie: Result?
    var isFavorite: Bool = false
    var isForFavoriteScreen: Bool?
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    func setUpCell(data: Result) {
        self.movie = data
        let url = URL(string: data.artworkUrl60 ?? "")
        avatarImageView.kf.setImage(with: url)
        trackName.text = data.trackName
        genreType.text = data.primaryGenreName
        priceLabel.text = data.trackPrice?.description
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        favoriteIcon.isUserInteractionEnabled = true
        favoriteIcon.addGestureRecognizer(tapGestureRecognizer)
        
        if isForFavoriteScreen == true {
            favoriteIcon.isHidden = true
        }
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        setUpFavoriteIcon()
        
    }
    
    func setUpFavoriteIcon() {
        isFavorite = !isFavorite
        if isFavorite {
            favoriteIcon.image = UIImage(systemName: "heart.fill")
            delegate?.movieDidSetAsFavorite(movie: movie ?? Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil))
        } else {
            favoriteIcon.image = UIImage(systemName: "heart")
            delegate?.removeFromFavorite(movie: movie ?? Result(artistName: nil, trackName: nil, collectionName: nil, artworkUrl60: nil, trackPrice: nil, longDescription: nil, primaryGenreName: nil))
        }
    }
    
    
}
