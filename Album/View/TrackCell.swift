//
//  TrackTableViewCell.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import UIKit

class TrackCell: UITableViewCell {
    
    // UI
    @IBOutlet weak var trackNumber: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    // Method
    func updateCell (track: Track) {
        trackNumber.text = String(track.trackNumber)
        trackName.text = track.trackName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
