//
//  JSON.swift
//  Day08
//
//  Created by Duy Anh on 1/28/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation

struct JSON {
    var object: Any
    
    init(data: Data) throws {
        do {
        let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            self.object = jsonData
        }
        catch {
            throw error
        }
    }
    
    private init(object: Any) {
        self.object = object
    }
    
    subscript(index: Int) -> JSON {
        let array = object as! [Any]
        return JSON(object: array[index])
    }
    
    subscript(key: String) -> JSON {
        let dict = object as! [String: Any]
        return JSON(object: dict[key]!)
    }
    
    var arrayValue: [JSON] {
        var jsonArray: [JSON] = []
        for element in object as! [Any] {
            jsonArray.append(JSON(object: element))
        }
        return jsonArray
    }
    
    var stringValue: String {
        return object as! String
    }
    
    var intValue: Int {
        return object as! Int
    }
}
