//
//  SongTableDataSource.swift
//  Day08
//
//  Created by Duy Anh on 1/27/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation
import UIKit

class SongTableDataSource: NSObject, UITableViewDataSource {
    var tableView: UITableView!
    var songs: [Song] = []
    
    func getSongs() {
        let url = URL(string: "https://itunes.apple.com/vn/rss/topsongs/limit=50/json")!
        let dataTask = URLSession.shared.dataTask(with: url) { [unowned self]
            data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.global().async {
                let entry = JSON(data: data!)["feed"]["entry"]
                for (index,song) in entry.arrayValue.enumerated() {
                    let name = song["im:name"]["label"].stringValue
                    let artist = song["im:artist"]["label"].stringValue
                    let price = song["im:price"]["label"].stringValue
                    let imageLink = song["im:image"][0]["label"].stringValue
                    
                    let songToBeAdded = Song(name: name, artist: artist, image: UIImage(), price: price)
                    self.songs.append(songToBeAdded)
                    
                    let imageData = try! Data(contentsOf: URL(string: imageLink)!)
                    songToBeAdded.image = UIImage(data: imageData)!
                
                    DispatchQueue.main.sync {
                        self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSongCell, for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        cell.songImage.image = song.image
        cell.songName.text = song.name
        cell.songArtist.text = song.artist
        cell.buyButton.setTitle(song.price, for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
}
