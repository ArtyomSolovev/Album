//
//  AlbumCell.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet private weak var albumTitleLabel: UILabel!
    
    // Method
    func updateCell (album: Album) {
        let imageUrl = URL(string: album.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl!) {
                DispatchQueue.main.async {
                    self.albumImage.image = UIImage(data: imageData)
                }
            }
        }
        albumTitleLabel.text = album.collectionName
    }
    
//    override func prepareForReuse() {
//        albumImage.image = UIImage()
//        albumTitleLabel.text = ""
//    }
}
