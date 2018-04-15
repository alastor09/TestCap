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
    let desc: String
    let imageUrl: String?
    let index: Int
    
    init(fact: Fact, index: Int) {
        self.fact = fact
        self.index = index
        title = fact.title
        desc = fact.description ?? APPDisplayText.NoDescriptionAvailable
        imageUrl = fact.imageHref
    }
}
