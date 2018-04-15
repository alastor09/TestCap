//
//  ServerInteraction.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

enum Result<T>{
    case response(T)
    case error(error: Error)
}

// Protocol Declares Func required for a class to Fetch and Parse data
protocol ServerInteraction {
    associatedtype T
    // Gets which URL to get data from
    var endPoint: String { get }
    // Asks individual class if it can validate the Json and is able to parse
    func canParse(jsonData: [String : Any]) -> Bool
    // Asks class to Parse the json
    func parseFeed(jsonData: [String: Any]) -> T
    // It makes the request to server or Internal JSON depending upon configuration chosen
    func fetchFeed( completionHandler: @escaping (Result<T>) -> Void)
}
