//
//  Constants.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import Foundation

enum Constants {
    static let welcomeText = "Enter the album name there 👆"
    
    enum Itunes {
        enum URL {
            static let baseURL = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&limit=99&term="
            static let albumURL = "https://itunes.apple.com/lookup?entity=song&id="
            static let invalid = "Invalid URL"
        }
        
        enum Results {
            static let results = "results"
            static let artworkUrl100 = "artworkUrl100"
            static let collectionId = "collectionId"
            static let collectionName = "collectionName"
            static let country = "country"
            static let primaryGenreName = "primaryGenreName"
            static let artistName = "artistName"
            static let releaseDate = "releaseDate"
        }
        
        enum Track {
            static let trackName = "trackName"
            static let trackNumber = "trackNumber"
        }
    }
    
    enum ID {
        static let cellId = "AlbumCell"
        static let trackId = "TrackCell"
        static let albumId = "AlbumViewController"
        static let historyId = "historyIdentifier"
    }
    
    enum Store {
        static let key = "SavedHistory"
    }
    
    enum Alert {
        static let title = "Attention"
        static let message = "The search for artists did not give results, enter another artist"
        static let ok = "Okey"
    }
}
