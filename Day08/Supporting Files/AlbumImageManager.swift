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
    
    func getImageOrDownloadIfNeeded(artist: String, album: String, imageLink: String?) -> UIImage? {
        var image = getImageLocally(artist: artist, album: album)
        if image != nil{
            return image
        } else {
            downloadImage(artist: artist, album: album, imageLink: imageLink) {
                [unowned self]
                (completion, error) in
                if error != nil {
                    print(error!)
                } else {
                    image = self.getImageLocally(artist: artist, album: album)
                }
            }
            return image
        }
    }
    
    func getImageLocally(artist: String, album: String) -> UIImage? {
        let path = storagePath + "/" + artist + " - " + album + ".png"
        
        if FileManager.default.fileExists(atPath: path) {
            let data = FileManager.default.contents(atPath: path)!
            return UIImage(data: data)
        }
        
        return nil
    }
    
    func downloadImage(artist: String, album: String, imageLink: String?, completed: @escaping (Bool, String?) -> ()) {
        let path = storagePath + "/" + artist + " - " + album + ".png"
        
        if FileManager.default.fileExists(atPath: path) {
            completed(false,"File alreay existed")
            return
        } else {
            guard let link = imageLink else {
                completed(false, "Link is invalid")
                return
            }
            
            do {
                let url = URL(string: link)
                let data = try Data(contentsOf: url!)
                FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
                completed(true, nil)
            } catch {
                completed(false, "Can't get or save data")
            }
        }
    }
}
