//
//  iTunes.swift
//  Album
//
//  Created by Артем Соловьев on 10.09.2021.
//

import Foundation

class ItunesConnection {
    
    static let instance = ItunesConnection()
    
    func getAlbums (searchRequest: String, complition: @escaping ([Album])->()) {
        var albums = [Album]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "\(Constants.url.BASE_URL)\(searchString)") else {
            print("Invalid URL")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let albumsResults = json["results"] as? NSArray {
                        for album in albumsResults {
                            if let albumInfo = album as? [String: AnyObject] {
                                guard let artistName = albumInfo["artistName"] as? String,
                                      let artworkUrl100 = albumInfo["artworkUrl100"] as? String,
                                      let collectionId = albumInfo["collectionId"] as? Int,
                                      let collectionName = albumInfo["collectionName"] as? String,
                                      let country = albumInfo["country"] as? String,
                                      let primaryStyleName = albumInfo["primaryGenreName"] as? String,
                                      let releaseDate = albumInfo["releaseDate"] as? String else {
                                    return
                                }
                                let releaseDateFormatted = releaseDate.prefix(4)
                                let albumInstance = Album(artistName: artistName, artworkUrl100: artworkUrl100, collectionId: collectionId, collectionName: collectionName, country: country, primaryStyleName: primaryStyleName, releaseDate: String(releaseDateFormatted))
                                albums.append(albumInstance)
                            }
                        }
                        complition(albums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    func getAlbumTracks (collectionId: Int, complition: @escaping ([Track]) -> ()) {
        var tracks = [Track]()
        let url = URL(string: "\(Constants.url.ALBUM_URL)\(collectionId)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let trackResults = json["results"] as? NSArray {
                        for song in trackResults {
                            if trackResults.index(of: song) != 0 {
                                if let songInfo = song as? [String: AnyObject] {
                                    guard let trackName = songInfo["trackName"] as? String,
                                          let trackNumber = songInfo["trackNumber"] as? Int else {
                                        return}
                                    let track = Track(trackName: trackName, trackNumber: trackNumber)
                                    tracks.append(track)
                                }
                            }
                        }
                        complition(tracks)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
}
