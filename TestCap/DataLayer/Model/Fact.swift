//
//  Facts.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

// Model to represent a Fact in JSON Object
class Fact {
    var title: String
    var description: String?
    var imageHref: String?
    
    init(title: String, description: String?, imageHref: String?) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
    
    // Initialiser which Parses the JSON object and returns a model object from json
    init(jsonDict: [String: Any]) {
        self.title = (jsonDict["title"] as? String)!
        self.description = (jsonDict["description"] as? String) ?? nil
        self.imageHref = (jsonDict["imageHref"] as? String) ?? nil
    }
}
