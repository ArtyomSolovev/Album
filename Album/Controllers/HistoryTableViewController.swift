//
//  HistoryTableViewController.swift
//  Album
//
//  Created by Артем Соловьев on 09.09.2021.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    // Dependencies
    private var arrayOfHistory = [String]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getHistory()
        tableView.reloadData()
        tableView.tableFooterView =  UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
//    Method
    private func getHistory(){
        arrayOfHistory = UserDefaults.standard.object(forKey: Constants.Store.key) as? [String] ?? [String]()
        arrayOfHistory.reverse()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfHistory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ID.historyId, for: indexPath)
        cell.textLabel?.text = arrayOfHistory[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.arrayOfHistory.remove(at: indexPath.row)
        let array = Array (arrayOfHistory.reversed())
        UserDefaults.standard.setValue(array, forKey: Constants.Store.key)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (tabBarController?.viewControllers![0])! as! ViewController
        vc.searchBar.text = arrayOfHistory[indexPath.row]
        vc.searchBarSearchButtonClicked(vc.searchBar)
        tabBarController?.selectedIndex = 0   
    }

}
