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
    private var vc: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        db = FavoriteManager()
    }
    
    
    @IBAction func selectFavorite(_ sender: Any) {
        guard let isFavorite = self.viewData?.isFavorite else { return }
        favoriteValidation(isFavorite: isFavorite, isFromDatabase: false)
    }
    
    func prepare(element: TvViewDataElement) {
        self.viewData = element
        self.labelShowName.text = element.titleTvShow
        imageManager(element.urlImage, element.titleTvShow, self.imageShow)
        
        guard let dbElement = db.getCurrentFavorite(title: element.titleTvShow) else { return }
        self.viewData?.isFavorite = dbElement.isFavorite
        favoriteValidation(isFavorite: dbElement.isFavorite, isFromDatabase: true)
    }
}


extension TvShowCell: LottieAnimationImageManager {
    private func imageManager(_ url: String, _ name: String, _ imageView: UIImageView) {
        self.downloadImage(url, name, imageView)
    }
}


// MARK: - HELPER FUNCTIONS
extension TvShowCell {
    private func favoriteValidation(isFavorite: Bool, isFromDatabase: Bool) {
        if isFromDatabase {
            favoriteValidationFromDB(isFavorite: isFavorite)
        } else {
            favoriteValidationFromSelected(isFavorite: isFavorite)
        }
    }
    
    private func favoriteValidationFromDB(isFavorite: Bool) {
        if isFavorite {
            self.buttonFavorite.setImage(Image(named: Constants.viewImage.favorite), for: .normal)
        } else {
            self.buttonFavorite.setImage(Image(named: Constants.viewImage.notFavorite), for: .normal)
        }
    }
    
    private func favoriteValidationFromSelected(isFavorite: Bool) {
        if !isFavorite {
            self.buttonFavorite.setImage(Image(named: Constants.viewImage.favorite), for: .normal)
            saveToDatabase()
        } else {
            self.buttonFavorite.setImage(Image(named: Constants.viewImage.notFavorite), for: .normal)
            deleteFromDatabase()
        }
    }
    
    internal func downloadImage(_ url: String, _ name: String, _ imageView: UIImageView) {
        if let url:URL = URL(string: url) {
            let resource = ImageResource(downloadURL: url, cacheKey: name)
            imageView.kf.setImage(with: resource, options: nil, completionHandler: { (image, _, _, _) in
                    if let imageResult = image {
                        self.imageShow.image = imageResult
                    }else {
                        print("error")
                        self.imageShow.image = self.getImageDefault()
                    }
            })
        }
    }
    
    private func saveToDatabase() {
        self.viewData?.isFavorite = true
        guard let viewData = self.viewData else { return }
        self.db.save(element: viewData)
    }
    
    private func deleteFromDatabase() {
        self.viewData?.isFavorite = false
        guard let viewData = self.viewData else { return }
        self.db.delete(element: viewData)
    }
    
    private func getImageDefault() -> UIImage {
        if let image = UIImage(named: Constants.viewImage.defaultImage) {
            return image
        }
        return UIImage()
    }
}
