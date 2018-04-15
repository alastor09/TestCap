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
    
    // Saves the Size of cell in a cache so that can be used to relayout cell
    private var cellSizeCache = NSCache<NSIndexPath, NSValue>()
    
    // Default image used to get dimensions of cell before downloading anything
    let initialImage: UIImage = UIImage(named: APPIMAGES.NoImageAvailable)!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailSegue {
            let vc = segue.destination as! DetailViewController
            vc.loadData(vm: viewModel.selectedViewModel())
        }
    }
    
    func defaultSizeForImageView() -> CGSize {
        return initialImage.size
    }
    
    // Recreate UI once Device rotates as cell size can shrink and get big depending upon dimensions
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
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
        cell.loadData(viewModel: viewModel.viewModelForCell(at: indexPath.row), delegate: self)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellSelected(index: indexPath.row)
        self.performSegue(withIdentifier: showDetailSegue , sender: nil)
    }
}

extension ViewController: ServerResponse  {
    // Gets a response from View model if state of model has changed
    func stateChanged(success: Bool, error: String) {
        if !success {
            self.displayAlert("Error", message: error, okBlock: nil)
        }
        refreshUI()
    }
}

extension ViewController: ImageDownloaded{
    // Gets the size of cell and cache it.
    // This func can be more optimised to include a logic so that collectionview layout is invalidated once we have enough data
    // or after a little time
    func cellReadyToBeResized(at index: Int, size: CGSize) {
        let indexPath = NSIndexPath.init(item: index, section: 0)
        cellSizeCache.setObject(NSValue(cgSize: size), forKey: indexPath)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewFlowLayout Delegate

extension ViewController: UICollectionViewDelegateFlowLayout {
    // Uses the cache to get the size of cell
    // If cache doesnt has any data that means no image has been downloaded
    // It calculates the ending height and width depending upon collection view width to put a constraint on the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // If fitted size was computed in the past for this cell, return it from cache
        if let size = cellSizeCache.object(forKey: indexPath as NSIndexPath) {
            let cellSize = size.cgSizeValue
            let requiredWidth = collectionView.bounds.size.width
            
            let cellNewWidth = cellSize.width > requiredWidth ? requiredWidth : cellSize.width
            let cellNewheight = cellSize.height * cellNewWidth / cellSize.width
            return CGSize(width: cellNewWidth, height: cellNewheight)
        }
        return defaultSizeForImageView()
    }
}


