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
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var heightOfImage: NSLayoutConstraint!
    @IBOutlet weak var widthOfImage: NSLayoutConstraint!
    @IBOutlet weak var heightOfLabel: NSLayoutConstraint!
    @IBOutlet weak var widthOfLabel: NSLayoutConstraint!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    var viewModel : HomeCellViewModel!
    
    func loadData(vm: HomeCellViewModel) {
        viewModel = vm
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = viewModel.desc
        if let url = viewModel.imageUrl {
            self.topImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: APPIMAGES.NoImageAvailable))
        }
        else
        {
            self.topImageView.image = UIImage(named: APPIMAGES.NoImageAvailable)
        }
        self.title = viewModel.title
    }
    
    override func viewDidLayoutSubviews() {
        decideOrientation()
    }
}

// Handling View Orientations
extension DetailViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.decideOrientation()
        }, completion: nil)
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func decideOrientation() {
        let orient = UIApplication.shared.statusBarOrientation
        switch orient {
        case .portrait:
            self.updatePortraitConstraint()
            break
        default:
            self.updateLandScapeConstraint()
            break
        }
    }
    
    func updateLandScapeConstraint() {
        let viewFrame = self.backgroundView.frame
        self.heightOfImage.constant = viewFrame.height
        self.widthOfImage.constant = viewFrame.width * 0.3
        self.heightOfLabel.constant = viewFrame.height
        self.widthOfLabel.constant = viewFrame.width * 0.7
    }
    
    func updatePortraitConstraint() {
        let viewFrame = self.backgroundView.frame
        self.heightOfImage.constant = viewFrame.height * 0.3
        self.widthOfImage.constant = viewFrame.width
        self.heightOfLabel.constant = viewFrame.height * 0.7
        self.widthOfLabel.constant = viewFrame.width
    }
}
