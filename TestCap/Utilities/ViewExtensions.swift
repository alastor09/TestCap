//
//  ViewExtensions.swift
//  TestCap
//
//  Created by Soan Saini on 14/4/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func DisplayAlert(_ title: String, message: String, OkBlock :(() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            guard let okBlck = OkBlock else
            {
                return
            }
            okBlck()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
