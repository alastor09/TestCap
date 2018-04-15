//
//  DetailViewController.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    var viewModel : HomeCellViewModel!
    
    func loadData(vm: HomeCellViewModel) {
        viewModel = vm
    }
    // AS SDWebimage cache images internally so its safe to ask Image from Sdwebimage
    // As it will check internal cache and memory before making a request again for same URL
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = viewModel.desc
        if let url = viewModel.imageUrl {
            self.topImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: APPIMAGES.NoImageAvailable))
        }
        else {
            self.topImageView.image = UIImage(named: APPIMAGES.NoImageAvailable)
        }
        self.title = viewModel.title
    }
    
    // As iPad Traits doesnt change, so explicitly changing it so that landscape and portrait requirement can be met.
    // It was either this or updating constraints like in commit before this one
    override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isLandscape {
            return UITraitCollection(traitsFrom:[UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .compact)])
        }
        return super.traitCollection
    }
}

