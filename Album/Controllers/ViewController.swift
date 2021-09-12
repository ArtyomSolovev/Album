//
//  ViewController.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import Foundation
import UIKit

class ViewController: UIViewController{
    
    // UI
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        welcomeLabel.text = Constants.welcomeText
        activityIndicator.hidesWhenStopped = true
    }

}

// MARK: - CollectionView methods

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.id.cellId, for: indexPath) as? AlbumCell {
            cell.updateCell(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.id.albumId) as! AlbumViewController
        vc.album = albums[indexPath.row]
        if let cell = collectionView.cellForItem(at: indexPath) as? AlbumCell {
            vc.image = cell.albumImage.image
        }
        self.present(vc, animated: true, completion: nil)
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - SearchBar methods

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            welcomeLabel.isHidden = true
            activityIndicator.startAnimating()
            var arrayOfHistory = UserDefaults.standard.object(forKey: "SavedHistory") as? [String] ?? [String]()
            if arrayOfHistory.contains(searchBar.text!){
                arrayOfHistory.remove(at: arrayOfHistory.firstIndex(of: searchBar.text!)!)
            }
            arrayOfHistory.append(searchBar.text!)
            UserDefaults.standard.setValue(arrayOfHistory, forKey: "SavedHistory")
            ItunesConnection.instance.getAlbums(searchRequest: searchBar.text!) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async { [self] in
                    activityIndicator.stopAnimating()
                    collectionView.reloadData()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            if self.collectionView.visibleCells.count == 0 {
                let alertController = UIAlertController(title: "Attention", message: "The search for artists did not give results, enter another artist", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: {
                    (action : UIAlertAction!) -> Void in })
                alertController.addAction(okeyAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
        
        searchBar.resignFirstResponder()
    }
}
