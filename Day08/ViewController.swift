//
//  ViewController.swift
//  Day08
//
//  Created by Duy Anh on 1/19/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

let kSongCell = "SongCell"

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var dataSource = SongTableDataSource()
    lazy var delegate = SongTableDelegate()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.tintColor = .white
        super.viewDidLoad()
        configTableView()
    }
    
    func configTableView() {
        let nib = UINib(nibName: "SongCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kSongCell)
        
        let dataSources = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String,Song>>()
        dataSources.configureCell = { dt,tb,id,song in
            let cell = tb.dequeueReusableCell(withIdentifier: kSongCell, for: id) as! SongCell
            cell.config(with: song, tableView: tb, indexPath: id)
            return cell
        }
        
        dataSource.modelObservable()
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
            .bindTo(tableView
                .rx
                .items(dataSource: dataSources))
            .addDisposableTo(disposeBag)
        
        tableView
            .rx
            .setDelegate(delegate)
            .addDisposableTo(disposeBag)
    }
}

