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

final class HomeTVShowViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var vm: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewDelegate()
        configure()
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

