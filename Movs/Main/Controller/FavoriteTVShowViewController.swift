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
        vm = FavoriteViewModel(view: self)
        configureTableViewDelegate()
        configure()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.validateAnimation()
        self.vm.fetchFavorites()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowViewController,
            let currentElement = sender as? TvViewDataElement {
            vc.element = currentElement
        }
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
        
        tableView
            .rx
            .itemDeleted
            .subscribe(onNext: { self.vm.removeItemAt(index: $0.row) })
            .disposed(by: self.vm.bag)
        
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: {
                self.performSegue(withIdentifier: Constants.viewControllerIdentifier.showDetails, sender: self.vm.db.findAll()[$0.row])
            }).disposed(by: self.vm.bag)
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
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
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
        FavoriteTvVisibility()
        if searchText.isEmpty {
            self.vm.fetchFavorites()
        } else {
            self.vm.favoriteList.accept(self.vm.db.findAll().filter({ $0.titleTvShow.lowercased().contains(searchText.lowercased()) }))
            let filteredItems = self.vm.db.findAll().filter({ $0.titleTvShow.lowercased().contains(searchText.lowercased()) })
            if filteredItems.count == 0 {
                setupAnimationVisibility(animationMode: Constants.LottieAnimation.notFound, message: Constants.LottieAnimation.Message.notFoundMessage)
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        FavoriteTvVisibility()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.vm.fetchFavorites()
    }
}

// MARK: - VIEWMODEL DELEGATE
extension FavoriteTVShowViewController: FavoriteViewModelDelegate, LottieAnimationVisibility {
    func FavoriteTvVisibility() {
        UIView.animate(withDuration: 0.2) {
            self.animationContainer.isHidden = true
            self.tableView.isHidden = false
            self.animationView.pause()
        }
    }
    
    func setupAnimationVisibility(animationMode: String, message: String) {
        UIView.animate(withDuration: 0.2) {
            self.tableView.isHidden = true
            self.animationContainer.isHidden = false
            self.labelAnimationMessage.text = message
            self.setupAnimation(animationMode: animationMode, view: self.animationView)
        }
    }
}

