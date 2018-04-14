//
//  HomeViewModel.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation

protocol ServerResponse {
    func stateChanged(success : Bool, error: String)
}


class HomeViewModel {
    
    var numberOfCells : Int { return facts.count }
    let ApiClient :FactsApiClient
    var facts  = Array<Fact>.init()
    
    let delegate: ServerResponse
    
    func viewModelForCell(at index: Int) -> HomeCellViewModel {
        return HomeCellViewModel(fact: facts[index])
    }
    
    init(delegate : ServerResponse) {
        self.delegate = delegate
        ApiClient = FactsApiClient.init()
    }
    
    func refreshData() {
        ApiClient.fetchFeed { (result) in
            switch result{
            case .response(let data):
                self.facts = data
                self.delegate.stateChanged(success: true, error: "")
                break
            case .error(error: let error):
                self.facts.removeAll()
                self.delegate.stateChanged(success: false, error: error.localizedDescription)
                break
            }
        }
    }
}
