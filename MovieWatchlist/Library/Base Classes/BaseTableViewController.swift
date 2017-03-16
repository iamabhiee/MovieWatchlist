//
//  BaseTableViewController.swift
//  MovieWatchlist
//
//  Created by Abhishek Sheth on 16/03/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTableView() {
        self.hideProgressView()
        self.tableView.reloadData()
    }
}
