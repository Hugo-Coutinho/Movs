//
//  SecondViewController.swift
//  Movs
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit
import Lottie

class FavoriteTVShowViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var animationView: LOTAnimationView!
    @IBOutlet weak var labelAnimationMessage: UILabel!
    
    // MARK: - PROPERTIES
    private var vm: FavoriteViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = FavoriteViewModel()
        configureTableViewDelegate()
        configure()
        setupNavBar()
        self.FavoriteTvVisibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.animationContainer.isHidden = true
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

// MARK: - NAVBAR HELPER
extension FavoriteTVShowViewController {
    private func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true
    }
}

// MARK: - SEARCHBAR DELEGATE
extension FavoriteTVShowViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.vm.fetchFavorites()
        } else {
            self.vm.favoriteList.accept(self.vm.db.findAll().filter({ $0.titleTvShow.lowercased().contains(searchText.lowercased()) }))
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.vm.fetchFavorites()
    }
}

// MARK: - VIEWMODEL DELEGATE
extension FavoriteTVShowViewController: FavoriteViewModelDelegate, LottieAnimationVisibility {
    func FavoriteTvVisibility() {
        UIView.animate(withDuration: 0.2) {
            self.animationView.isHidden = true
            self.tableView.isHidden = false
            self.animationView.pause()
        }
    }
    
    func setupAnimationVisibility(animationMode: String, message: String) {
        UIView.animate(withDuration: 0.2) {
            self.tableView.isHidden = true
            self.labelAnimationMessage.text = message
            self.setupAnimation(animationMode: animationMode, view: self.animationView)
        }
    }
}

