//
//  SongTableDataSource.swift
//  Day08
//
//  Created by Duy Anh on 1/27/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SongTableDataSource: NSObject {
    var disposeBag = DisposeBag()
    var tableView: UITableView!
    
    var songs: Variable<[Song]>
    
    func modelObservable() -> Observable<[AnimatableSectionModel<String,Song>]> {
        return songs.asObservable()
            .map {
                return [AnimatableSectionModel<String,Song>.init(model: "", items: $0)]
        }
    }
    
    override init() {
        songs = Variable([])

        performURLTask()
            .flatMapLatest { (json: JSON) -> Observable<Song> in
                return parseSongs(json: json)
            }
            .scan([]) { acc, val in
                var array = acc
                array.append(val)
                return array
            }
            .bindTo(songs)
            .addDisposableTo(disposeBag)
    }
}


func performURLTask() -> Observable<JSON> {
    let url = URL(string: "https://itunes.apple.com/vn/rss/topsongs/limit=100/json")!
    let request = URLRequest(url: url)
    return URLSession.shared
        .rx
        .data(request: request)
        .map { data in
            return try JSON(data: data)
        }
        .catchError { e in
            print(e)
            return Observable<JSON>.create { o in
                o.onCompleted()
                return Disposables.create()
            }
        }
}

fileprivate func parseSongs(json: JSON) -> Observable<Song> {
    return Observable<Song>.create { o in
        let entry = json["feed"]["entry"]
        
        for (_,song) in entry.arrayValue.enumerated() {
            let name = song["im:name"]["label"].stringValue
            let artist = song["im:artist"]["label"].stringValue
            let price = song["im:price"]["label"].stringValue
            let imageLink = song["im:image"][2]["label"].stringValue
            let album = song["im:collection"]["im:name"]["label"].stringValue
            
            let song = Song(name: name, artist: artist, imageLink: imageLink, price: price, album: album)
            o.onNext(song)
        }
        return Disposables.create()
    }
}


