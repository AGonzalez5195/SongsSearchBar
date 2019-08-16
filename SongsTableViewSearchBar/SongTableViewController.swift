//
//  SongTableViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Anthony Gonzalez on 8/15/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let songs = Song.loveSongs
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var SongSearchResults: [Song] {
        get {
            guard let searchString = searchString else { return songs }
            guard searchString != ""  else { return songs}
            switch searchBarOutlet.selectedScopeButtonIndex {
            case 0:
                return songs.filter{$0.name.lowercased().contains(searchString.lowercased())}
            case 1:
                return songs.filter{$0.artist.lowercased().contains(searchString.lowercased())}
            default: return songs
            }
        }
    }
    
    
    var searchString: String? = nil {
        didSet { self.tableView.reloadData() }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if SongSearchResults.count == 0 {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No Search Results"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        } else {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        }
        return numOfSections
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongSearchResults.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        cell.textLabel?.text = SongSearchResults[indexPath.row].name
        cell.detailTextLabel?.text = SongSearchResults[indexPath.row].artist
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBarOutlet.delegate = self
    }
}


extension SongTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsScopeBar = false
        searchBar.sizeToFit()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = false
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.sizeToFit()
        return true
    }
}










//
//func alert(message: String, title: String = "") {
//    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//    alertController.addAction(OKAction)
//    self.present(alertController, animated: true, completion: nil)
//}



//func updateLabelFrame() {
//    resultsNotFoundLabel.translatesAutoresizingMaskIntoConstraints = false
//    resultsNotFoundLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
//    resultsNotFoundLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
//}


//func numberOfSections(in tableView: UITableView) -> Int {
//    if SongSearchResults.count == 0 {
//        resultsNotFoundLabel.isHidden = false
//        tableView.isHidden = true
//        return 0
//    }
//    return 1
//}

//And make the resultsNotFoundLabel in storyboard.
