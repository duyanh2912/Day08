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
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.tintColor = .white
        super.viewDidLoad()
        configTableView()    
    }
    
    func configTableView() {
        let nib = UINib(nibName: "SongCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kSongCell)
        
        delegate = SongTableDelegate()
        tableView.delegate = delegate
        
        dataSource = SongTableDataSource()
        dataSource.tableView = tableView
        tableView.dataSource = dataSource
        
        dataSource.getSongs()
    }
}

