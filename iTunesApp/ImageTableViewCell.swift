//
//  ImageTableViewCell.swift
//  iTunesApp
//
//  Created by Mila on 08/03/22.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(data: Result) {
        let url = URL(string: data.artworkUrl100 ?? "")
        movieImageView.kf.setImage(with: url)
    }
    
}
