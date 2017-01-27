//
//  ViewController.swift
//  Day08
//
//  Created by Duy Anh on 1/19/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit

let kSongCell = "SongCell"

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: SongTableDataSource!
    var delegate: SongTableDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        let url = URL(string: "https://itunes.apple.com/us/rss/topsongs/limit=10/json")!
        let dataTask = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if error != nil {
                print(error!)
                return
            }

            let jsonData = JSON(data: data!)
            let feed = jsonData["feed"]
            
            print(feed)
        }
        dataTask.resume()
    }
    
    func configTableView() {
        let nib = UINib(nibName: "SongCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kSongCell)
        
        dataSource = SongTableDataSource()
        tableView.dataSource = dataSource
        
        delegate = SongTableDelegate()
        tableView.delegate = delegate
    }
}

