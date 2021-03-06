//
//  SongModel.swift
//  Day08
//
//  Created by Duy Anh on 1/27/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation
import RxDataSources

class Song: Equatable, Hashable, IdentifiableType {
    var imageLink: String
    var artist: String
    var name: String
    var price: String
    var album: String
    
    init(name: String, artist: String, imageLink: String, price: String, album: String) {
        self.name = name
        self.artist = artist
        self.imageLink = imageLink
        self.price = price
        self.album = album
    }
    
    public static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.name == rhs.name && lhs.artist == rhs.artist && lhs.album == rhs.album
    }
    
    var hashValue: Int {
        return name.hashValue &+ artist.hashValue &+ album.hashValue
    }
    
    typealias Identity = Song
    
    var identity: Song {
        return self
    }
}
