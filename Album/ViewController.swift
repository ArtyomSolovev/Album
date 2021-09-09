//
//  ViewController.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // UI
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    private let welcomeText = "Enter the album name there 👆"
    private var welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWelcome()
    }

    func setupWelcome() {
        welcomeLabel.text = welcomeText
        welcomeLabel.textAlignment = .center
        welcomeLabel.center = view.center
        view.addSubview(welcomeLabel)
    }

}

