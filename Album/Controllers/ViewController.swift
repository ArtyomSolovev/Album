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
    private var welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWelcome()
    }

    private func setupWelcome() {
        welcomeLabel.text = Constants.welcomeText
        welcomeLabel.textAlignment = .center
        welcomeLabel.center = view.center
        view.addSubview(welcomeLabel)
    }

}

