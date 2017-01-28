//
//  ImageManager.swift
//  Day08
//
//  Created by Duy Anh on 1/28/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation

class AlbumImageManager {
    static let shared = AlbumImageManager()
    
    var storagePath: String {
        var path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        path += "/Album Images"
        return path
    }
    
    init() {
        if !FileManager.default.fileExists(atPath: storagePath) {
            do {
                try FileManager.default.createDirectory(atPath: storagePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Unable to create folder")
            }
        }
    }
    
    func getImage(artist: String, album: String, imageLink: String?) -> UIImage? {
        let path = storagePath + "/" + artist + " - " + album + ".png"
        
        if FileManager.default.fileExists(atPath: path) {
            let data = FileManager.default.contents(atPath: path)!
            return UIImage(data: data)
        } else {
            guard let link = imageLink else { return nil }
            
            do {
                let url = URL(string: link)
                let data = try Data(contentsOf: url!)
                
                let image = UIImage(data: data)
                FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
                
                return image
                
            } catch {
                print("Can't get data")
            }
        }
        return nil
    }
}
