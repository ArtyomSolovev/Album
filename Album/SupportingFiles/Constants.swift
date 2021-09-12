//
//  Constants.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import Foundation

enum Constants {
    static let welcomeText = "Enter the album name there 👆"
    enum url {
        static let BASE_URL = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&limit=99&term="
        static let ALBUM_URL = "https://itunes.apple.com/lookup?entity=song&id="
    }
    enum id {
        static let cellId = "AlbumCell"
        static let trackId = "TrackCell"
        static let albumId = "AlbumViewController"
    }
}
