//
//  FetchApiClient.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation
import Alamofire

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

// Default Implementation for fetch Feed
extension ServerInteraction {
    public func fetchFeed( completionHandler: @escaping (Result<T>) -> Void) {
        let _ = Alamofire.request(endPoint)
            .responseJSON { response in
                if let error = response.result.error {
                    completionHandler(Result.error(error: error))
                    return
                }
                guard let jsonData = response.result.value as? [String: Any] else {
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }
                
                if !self.canParse(jsonData: jsonData) {
                    completionHandler(Result.error(error: NSError(domain:"Json not in Right Format", code:1102, userInfo:nil)))
                    return
                }
                
                let feedReceived = self.parseFeed(jsonData: jsonData)
                completionHandler(Result.response(feedReceived))
        }
    }
}
