//
//  TrackTableViewCell.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet private weak var trackNumber: UILabel!
    @IBOutlet private weak var trackName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
