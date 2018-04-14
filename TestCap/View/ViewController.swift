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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellSelected(index: indexPath.row)
        self.performSegue(withIdentifier: showDetailSegue , sender: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            self?.collectionView?.collectionViewLayout.invalidateLayout()
            }, completion: nil)
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

// MARK: UICollectionViewDelegateFlowLayout protocol methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let columns: Int = {
            var count = 2
            if traitCollection.horizontalSizeClass == .regular {
                count = count + 1
            }
            if collectionView.bounds.width > collectionView.bounds.height {
                count = count + 1
            }
            return count
        }()
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(columns - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(columns))
        return CGSize(width: size, height: 90)
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
