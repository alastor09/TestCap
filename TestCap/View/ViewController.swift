//
//  ViewController.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionImageCell"

class ViewController: UICollectionViewController{

    var viewModel : HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel.init(delegate: self)
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        refreshData()
    }
    
    func refreshData() {
        viewModel.refreshData()
    }
    
    func refreshUI() {
        self.collectionView?.reloadData()
    }
}

extension ViewController {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.loadData(viewModel: viewModel.viewModelForCell(at: indexPath.row))
        return cell
    }
}

extension ViewController: ServerResponse  {
    func stateChanged(success: Bool, error: String) {
        if !success {
            self.DisplayAlert("Error", message: error, OkBlock: nil)
        }
        refreshUI()
    }
}

