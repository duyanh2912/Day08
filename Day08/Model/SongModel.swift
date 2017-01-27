//
//  SongModel.swift
//  Day08
//
//  Created by Duy Anh on 1/27/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation

class Song: NSObject {
    var image: UIImage
    var artist: String
    var name: String
    var price: String
    
    init(name: String, artist: String, image: UIImage, price: String) {
        self.name = name
        self.artist = artist
        self.image = image
        self.price = price
    }
}
