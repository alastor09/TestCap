//
//  ImageCollectionViewCell.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel : HomeCellViewModel!
    
    func loadData(viewModel : HomeCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = self.viewModel.title
        if let url = viewModel.imageUrl {
            self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: APPIMAGES.NoImageAvailable))
        }
        else
        {
            self.imageView.image = UIImage(named: APPIMAGES.NoImageAvailable)
        }
    }
    
    func setWidth(width: CGFloat) {
        imageViewWidthConstraint.constant = width
    }
}
