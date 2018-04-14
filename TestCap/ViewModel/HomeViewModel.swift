//
//  HomeViewModel.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

class HomeViewModel {
    var numberOfCells : Int = 0
    
}

class HomeCellViewModel {
    let title: String
    let description: String
    let imageUrl: String
    
    init(fact: Fact) {
        title = fact.title
        description = fact.description ?? "No Description"
        imageUrl = fact.imageHref ?? APPIMAGES.NoImageAvailable
    }
    
}
