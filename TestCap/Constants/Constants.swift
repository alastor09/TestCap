//
//  Constants.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

// Constants for the Application

// All possible URLs defined in here, so that can easily be changed
struct APPURL {
    // All the possible Domains
    private struct Domains {
        static let Prod = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl"
    }
    
    private static let Domain = Domains.Prod
    
    // All the URls used inside Application
    private static let FactsEndPoint = "/facts.json"
    
    static let FactsURL = Domains.Prod + FactsEndPoint
    static let FactsLocalFileName = "dummy"
}

// Constants for images used inside App
struct APPIMAGES {
    static let NoImageAvailable = "NoImageAvailable"
}
// Constants for all the Text used in App
struct APPDisplayText {
    static let NoDescriptionAvailable = "No Description Available"
}
