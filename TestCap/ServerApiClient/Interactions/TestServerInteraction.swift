//
//  TestServerInteraction.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

// Default Implementation for Testing Local Json fetch Feed
extension ServerInteraction {
    public func fetchFeed( completionHandler: @escaping (Result<T>) -> Void) {
        if let path = Bundle.main.path(forResource: APPURL.FactsLocalFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                guard let jsonData = jsonResult as? [String: Any] else {
                    completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                    return
                }
                
                if !self.canParse(jsonData: jsonData) {
                    completionHandler(Result.error(error: NSError(domain:"Json not in Right Format", code:1103, userInfo:nil)))
                    return
                }
                
                let feedReceived = self.parseFeed(jsonData: jsonData)
                completionHandler(Result.response(feedReceived))
                
            } catch {
                completionHandler(Result.error(error: NSError(domain:"Unable to Parse JSON", code:1104, userInfo:nil)))
            }
        }
    }
}
