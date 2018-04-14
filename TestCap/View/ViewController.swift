//
//  ViewController.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionImageCell"
private let showDetailSegue = "detailShow"

class ViewController: UICollectionViewController{
    
    var viewModel : HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel.init(delegate: self)
        
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
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
        cell.setWidth(width: self.view.frame.width)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellSelected(index: indexPath.row)
        self.performSegue(withIdentifier: showDetailSegue , sender: nil)
    }
}

extension ViewController: ServerResponse  {
    func stateChanged(success: Bool, error: String) {
        if !success {
            self.displayAlert("Error", message: error, okBlock: nil)
        }
        refreshUI()
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailSegue {
            let vc = segue.destination as! DetailViewController
            vc.loadData(vm: viewModel.selectedViewModel())
        }
    }
}
