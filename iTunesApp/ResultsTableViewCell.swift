//
//  ResultsTableViewCell.swift
//  iTunesApp
//
//  Created by Mila on 07/03/22.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var genreType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(data: Result) {
        trackName.text = data.trackName
        genreType.text = data.primaryGenreName
    }
    
}
