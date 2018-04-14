//
//  FetchApiClient.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation
import Alamofire

// Default Implementation for fetch Feed
extension ServerInteraction {
    public func fetchFeed( completionHandler: @escaping (Result<T>) -> Void) {
        Alamofire.request(endPoint).responseJSON { (responseData) in
            
            if let error = responseData.result.error {
                completionHandler(Result.error(error: error))
                return
            }
            
            guard let jsonData = responseData.result.value as? [String: Any] else {
                completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                return
            }
            
            if !self.canParse(jsonData: jsonData) {
                completionHandler(Result.error(error: NSError(domain:"Json not in Right Format", code:1103, userInfo:nil)))
                return
            }
            
            let feedReceived = self.parseFeed(jsonData: jsonData)
            completionHandler(Result.response(feedReceived))
        }
    }
}
