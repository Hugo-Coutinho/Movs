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
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: LOTAnimationView!
    @IBOutlet weak var labelLoadingMessage: UILabel!
    
    
    private var vm: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = HomeViewModel(delegate: self)
        configureTableViewDelegate()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
}

// MARK: - BIND RX COLLECTION VIEW
extension HomeTVShowViewController {
    private func configure() {
        bindCellItems()
        collectionViewRegister()
    }
    
    private func configureTableViewDelegate() {
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: self.vm.bag)
    }
    
    private func  bindCellItems() {
        vm.items
            .bind(to: collectionView.rx.items(cellIdentifier: Constants.cellIdentifier.tvShowCell, cellType: TvShowCell.self)) { _, element, cell in
                if cell.labelShowName != nil {
                    cell.prepare(element: element)
                }
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
extension HomeTVShowViewController: HomeViewModelDelegate {
    func success() {
        UIView.animate(withDuration: 0.2) {
            self.loadingView.isHidden = true
            self.collectionView.isHidden = false
            self.loadingView.pause()
        }
    }
    
    func loading() {
        UIView.animate(withDuration: 0.2) {
            self.loadingView.isHidden = false
            self.collectionView.isHidden = true
            self.loadingView.setAnimation(named: Constants.LottieAnimation.loading)
            self.loadingView.play()
            self.loadingView.loopAnimation = true
            self.labelLoadingMessage.text = Constants.LottieAnimation.Message.loadingMessage
        }
    }
    
    func error() {
        UIView.animate(withDuration: 0.2) {
            self.loadingView.isHidden = false
            self.collectionView.isHidden = true
            self.loadingView.setAnimation(named: Constants.LottieAnimation.error)
            self.loadingView.play()
            self.loadingView.loopAnimation = true
            self.labelLoadingMessage.text = Constants.LottieAnimation.Message.errorMessage
        }
    }
}

// MARK: - NAVBAR HELPER
extension HomeTVShowViewController {
    private func setupNavBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        setupSearchBar()
        
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

// MARK: - SEARCHBAR DELEGATE
extension HomeTVShowViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
        self.vm.items.accept(self.vm.allItems)
        } else {
            self.vm.items.accept(self.vm.allItems.filter({ $0.titleTvShow.lowercased().contains(searchText.lowercased()) }))
        }
        
    }
}
