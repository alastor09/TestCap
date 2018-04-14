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
    var endPoint: String { get }
    func canParse(jsonData: [String : Any]) -> Bool
    func parseFeed(jsonData: [String: Any]) -> T
    func fetchFeed( completionHandler: @escaping (Result<T>) -> Void)
}
