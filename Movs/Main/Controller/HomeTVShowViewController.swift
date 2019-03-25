//
//  FirstViewController.swift
//  Movs
//
//  Created by BRQ on 14/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class HomeTVShowViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
//        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSize(width: view.frame.width*0.4, height: self.collectionView.frame.height/3)
    }
}


extension HomeTVShowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "tvShowCell", for: indexPath) as! TvShowCell
    }
}
