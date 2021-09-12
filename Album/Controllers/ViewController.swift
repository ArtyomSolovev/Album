//
//  ViewController.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import UIKit

class ViewController: UIViewController{
    
    // UI
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var welcomeLabel: UILabel!
    
    // Dependencies
    private var albums = [Album]()
    
    // MARK: - Lifecycle
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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ID.cellId, for: indexPath) as? AlbumCell {
            cell.updateCell(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.ID.albumId) as! AlbumViewController
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
            var arrayOfHistory = UserDefaults.standard.object(forKey: Constants.Store.key) as? [String] ?? [String]()
            if arrayOfHistory.contains(searchBar.text!){
                arrayOfHistory.remove(at: arrayOfHistory.firstIndex(of: searchBar.text!)!)
            }
            arrayOfHistory.append(searchBar.text!)
            UserDefaults.standard.setValue(arrayOfHistory, forKey: Constants.Store.key)
            ItunesConnection.instance.getAlbums(searchRequest: searchBar.text!) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async { [self] in
                    if albums.capacity == 0{
                        let alertController = UIAlertController(title: Constants.Alert.title, message:
                                                                    Constants.Alert.message, preferredStyle: .alert)
                        let okeyAction = UIAlertAction(title: Constants.Alert.ok, style: .default, handler: {
                            (action : UIAlertAction!) -> Void in })
                        alertController.addAction(okeyAction)
                        present(alertController, animated: true, completion: nil)
                        welcomeLabel.isHidden = false
                    }
                    activityIndicator.stopAnimating()
                    collectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBarSearchButtonClicked(searchBar)
        searchBar.showsCancelButton = false
    }
}
