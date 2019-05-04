//
//  TvShowCell.swift
//  Movs
//
//  Created by BRQ on 30/03/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit
import Kingfisher

class TvShowCell: UICollectionViewCell {
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var labelShowName: UILabel!
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    private var viewData: TvViewDataElement?
    private var db: FavoriteManager!
    private var favHelper: FavoriteHelper?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        db = FavoriteManager()
        favHelper = FavoriteHelper()
    }
    
    override func prepareForReuse() {
        self.labelShowName.text = ""
        self.imageShow.image = nil
        self.buttonFavorite.setImage(Image(named: Constants.viewImage.notFavorite), for: .normal)
    }
    
    @IBAction func selectFavorite(_ sender: Any) {
        guard let isFavorite = self.viewData?.isFavorite else { return }
        self.favHelper?.validation(show: self.viewData, isFavorite: isFavorite, isFromDatabase: false, button: self.buttonFavorite)
    }
    
    func prepare(element: TvViewDataElement) {
        self.viewData = element
        self.labelShowName.text = element.titleTvShow
        imageManager(element.urlImage, element.titleTvShow, self.imageShow)
        
        guard let dbElement = db.getCurrentFavorite(title: element.titleTvShow) else { return }
        self.viewData?.isFavorite = dbElement.isFavorite
        self.favHelper?.validation(show: dbElement, isFavorite: dbElement.isFavorite, isFromDatabase: true, button: self.buttonFavorite)
    }
}


extension TvShowCell: ImageHelper {
    private func imageManager(_ url: String, _ name: String, _ imageView: UIImageView) {
        self.downloadImage(url, name, imageView)
    }
}
