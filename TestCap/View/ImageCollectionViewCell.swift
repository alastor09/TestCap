//
//  ImageCollectionViewCell.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel : HomeCellViewModel!
    
    func loadData(viewModel : HomeCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = self.viewModel.title
        self.imageView.image = UIImage(named: viewModel.imageUrl)
    }
}
