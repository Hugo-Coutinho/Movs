//
//  SecondViewController.swift
//  Movs
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class FavoriteTVShowViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var vm: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = FavoriteViewModel()
        
    }


}

