//
//  DescriptionTableViewCell.swift
//  iTunesApp
//
//  Created by Mila on 08/03/22.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupLabels(data: Result) {
        titleLabel.text = data.trackName
        descriptionLabel.text = data.longDescription
    }
    
}
