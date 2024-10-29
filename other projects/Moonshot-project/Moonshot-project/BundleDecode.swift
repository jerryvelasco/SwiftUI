//
//  BundleDecode.swift
//  Moonshot-project
//
//  Created by jerry on 10/24/24.
//

import Foundation

/*
 used to decode json file
 */
extension Bundle {
    
    
    //uses generics
    func decode<type: Codable>(_ file: String) -> type {
        
        //try to locate the file
        guard let fileUrl = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate the \(file) in the bundle")
        }
        
        //try to load the data
        guard let loadData = try? Data(contentsOf: fileUrl) else {
            fatalError("failed to load the data in \(fileUrl) from bundle")
        }
        
        //instance of decoder and date formatter
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        
        //matches the date format of the launch date from the json files
        //then taps into decoder method to format date 
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        //tries to decode the data from the property above
        guard let fileLoaded = try? decoder.decode(type.self, from: loadData) else {
            fatalError("failed to decode \(file) from bundle")
        }
        
        return fileLoaded
    }
}
