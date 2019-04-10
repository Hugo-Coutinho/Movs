//
//  SecondViewController.swift
//  Movs
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class FavoriteTVShowViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - PROPERTIES
    private var vm: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = FavoriteViewModel()
        configureTableViewDelegate()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.fetchFavorites()
    }
}

// MARK: - BIND TX TABLEVIEW
extension FavoriteTVShowViewController {
    private func configure() {
        bindCellItems()
        tableViewRegister()
    }
    
    private func configureTableViewDelegate() {
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: self.vm.bag)
    }
    
    private func  bindCellItems() {
        vm.favoriteList
            .bind(to: tableView.rx.items(cellIdentifier: Constants.cellIdentifier.tvFavoriteShowCell, cellType: FavoriteCell.self)) { _, element, cell in
                cell.prepare(element: element)
            }
            .disposed(by: self.vm.bag)
    }
    
    private func tableViewRegister() {
        tableView.register(UINib(nibName: Constants.cellIdentifier.tvFavoriteShowCell, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier.tvFavoriteShowCell)
    }
}

// MARK: - TABLEVIEW DELEGATE
extension FavoriteTVShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
    }
}

