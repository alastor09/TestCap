//
//  HomeCellViewModel.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

class HomeCellViewModel {
    
    let fact : Fact
    
    let title: String
    let description: String
    let imageUrl: String
    
    init(fact: Fact) {
        self.fact = fact
        
        title = fact.title
        description = fact.description ?? "No Description"
        imageUrl = APPIMAGES.NoImageAvailable
    }
}