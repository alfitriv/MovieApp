//
//  DateTableViewCell.swift
//  iTunesApp
//
//  Created by Mila on 08/03/22.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    
    func setupDate() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        dateLabel.text = formatter.string(from: today)
        UserDefaults.standard.set(formatter.string(from: today), forKey: "lastVisited")
    }
    
}
