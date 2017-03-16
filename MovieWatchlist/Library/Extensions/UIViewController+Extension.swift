//
//  ViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showProgressView() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgressView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func handleError(error : Error?) {
        self.hideProgressView()
        
        if let error = error {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
    func showAlert(title : String!, message : String!) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
