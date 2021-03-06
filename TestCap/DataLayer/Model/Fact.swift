//
//  Facts.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

// Model to represent a Fact in JSON Object
struct Fact {
    let title: String
    let description: String?
    let imageHref: String?
    
    // Initialiser which Parses the JSON object and returns a model object from json
    init(jsonDict: [String: Any]) {
        self.title = (jsonDict["title"] as? String)!
        self.description = (jsonDict["description"] as? String) ?? nil
        self.imageHref = (jsonDict["imageHref"] as? String) ?? nil
    }
}
