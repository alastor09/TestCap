//
//  CapFeed.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

// Fetches Facts and Parses Them into Models
class FactsApiClient: ServerInteraction {
    typealias T = [Fact]
    
    // End point which is to be used for fetching
    var endPoint: String = APPURL.FactsURL
    
    // Ensures everything in Json is correct and in desired format
    func canParse(jsonData: [String : Any]) -> Bool {
        if jsonData["rows"] != nil {
            return true
        }
        return false
    }
    
    // Parses the object and returns array of models
    func parseFeed(jsonData: [String : Any]) -> [Fact] {
        var dataArray: [Fact] = []
        for data in jsonData["rows"] as! [[String : Any]] {
            if shouldParse(data: data) {
                dataArray.append(Fact(jsonDict: data))
            }
        }
        return dataArray
    }
    
    // Initialiser which Parses the JSON object and returns a model object from json
    func shouldParse(data: [String: Any]) -> Bool {
        guard (data["title"] as? String) != nil else {
            return false
        }
        return true
    }
}
