//
//  FirstViewController.swift
//  Movs
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

final class HomeTVShowViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: LOTAnimationView!
    @IBOutlet weak var labelLoadingMessage: UILabel!
    
    // MARK: - PROPERTIES
    private var vm: HomeViewModel!
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTap()
        self.vm = HomeViewModel(delegate: self)
        configureCollectionViewDelegate()
        configure()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.fetchFavoriteShows()
    }
}

// MARK: - BIND RX COLLECTION VIEW
extension HomeTVShowViewController {
    private func configure() {
        bindCellItems()
        collectionViewRegister()
    }
    
    private func configureCollectionViewDelegate() {
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: self.vm.bag)
    }
    
    private func  bindCellItems() {
        vm.items
            .bind(to: collectionView.rx.items(cellIdentifier: Constants.cellIdentifier.tvShowCell, cellType: TvShowCell.self)) { _, element, cell in
                    cell.prepare(element: element)
            }
            .disposed(by: self.vm.bag)
    }
    
    private func collectionViewRegister() {
        collectionView.register(UINib(nibName: Constants.cellIdentifier.tvShowCell, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier.tvShowCell)
    }
}

// MARK: - COLLECTION VIEW DELEGATE FLOW
extension HomeTVShowViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.4, height: view.frame.height/3)
    }
    
}

// MARK: - VIEWMODEL DELEGATE
extension HomeTVShowViewController: HomeViewModelDelegate, LottieAnimationVisibility {
    func setupTvShowVisibility() {
        UIView.animate(withDuration: 0.2) {
            self.loadingView.isHidden = true
            self.collectionView.isHidden = false
            self.loadingView.pause()
        }
    }
    
    func setupAnimationVisibility(animationMode: String, message: String) {
        UIView.animate(withDuration: 0.2) {
            self.collectionView.isHidden = true
            self.labelLoadingMessage.text = message
            self.setupAnimation(animationMode: animationMode, view: self.loadingView)
        }
    }
}

// MARK: - NAVBAR HELPER
extension HomeTVShowViewController {
    private func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
    }
}

// MARK: - SEARCHBAR DELEGATE
extension HomeTVShowViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setupTvShowVisibility()
        if searchText.isEmpty {
            self.vm.items.accept(self.vm.allItems)
        } else {
            let filteredItems = self.vm.allItems.filter({ $0.titleTvShow.lowercased().contains(searchText.lowercased()) })
            self.vm.items.accept(filteredItems)
            if filteredItems.count == 0 {
                setupAnimationVisibility(animationMode: Constants.LottieAnimation.notFound, message: Constants.LottieAnimation.Message.notFoundMessage)
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        setupTvShowVisibility()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.vm.items.accept(self.vm.allItems)
    }
}

// MARK: - SETUP TAP
extension HomeTVShowViewController {
    
    private func setTap() {
        self.tap = UITapGestureRecognizer(target: self, action: #selector(HomeTVShowViewController.animationTapped))
        self.loadingView.addGestureRecognizer(self.tap)
    }
    
    @objc private func animationTapped() {
        self.vm = HomeViewModel(delegate: self)
        configureCollectionViewDelegate()
        configure()
    }
}
