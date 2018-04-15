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
        
        DispatchQueue.global(qos: .background).async {
            if let path = Bundle.main.path(forResource: APPURL.FactsLocalFileName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    
                    guard let jsonData = jsonResult as? [String: Any] else {
                        DispatchQueue.main.async {
                            completionHandler(Result.error(error: NSError(domain:"JSON Not Proper", code:1101, userInfo:nil)))
                        }
                        return
                    }
                    
                    if !self.canParse(jsonData: jsonData) {
                        DispatchQueue.main.async {
                            completionHandler(Result.error(error: NSError(domain:"Json not in Right Format", code:1103, userInfo:nil)))
                        }
                        return
                    }
                    
                    let feedReceived = self.parseFeed(jsonData: jsonData)
                    
                    DispatchQueue.main.async {
                        completionHandler(Result.response(feedReceived))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(Result.error(error: NSError(domain:"Unable to Parse JSON", code:1104, userInfo:nil)))
                    }
                }
            }
        }
    }
}
