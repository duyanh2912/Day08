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
        let url = URL(string: "https://itunes.apple.com/us/rss/topsongs/limit=50/json")!
        let dataTask = URLSession.shared.dataTask(with: url) { [unowned self]
            data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.global().async { [unowned self] in
                do {
                    let entry = try JSON(data: data!)["feed"]["entry"]
                    
                    for (index,song) in entry.arrayValue.enumerated() {
                        let name = song["im:name"]["label"].stringValue
                        let artist = song["im:artist"]["label"].stringValue
                        let price = song["im:price"]["label"].stringValue
                        let imageLink = song["im:image"][2]["label"].stringValue
                        let album = song["im:collection"]["im:name"]["label"].stringValue
                        
                        let songToBeAdded = Song(name: name, artist: artist, imageLink: imageLink, price: price, album: album)
                        self.songs.append(songToBeAdded)
                        
                        DispatchQueue.main.sync { [unowned self] in
                            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                        }
                    }
                } catch {
                    print("Can't load JSON data")
                }
            }
        }
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSongCell, for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        
        cell.songName.text = song.name
        cell.songArtist.text = song.artist
        cell.buyButton.setTitle(song.price, for: .normal)
        
        DispatchQueue.global().async {
            let image = AlbumImageManager.shared.getImage(artist: song.artist, album: song.album, imageLink: song.imageLink)
            
            DispatchQueue.main.sync {
                guard tableView.indexPath(for: cell) == indexPath else { return }
                cell.songImage.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
}
