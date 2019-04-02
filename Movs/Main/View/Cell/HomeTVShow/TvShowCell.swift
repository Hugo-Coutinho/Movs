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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func selectFavorite(_ sender: Any) {
        if let isFavorite = self.viewData?.isFavorite,
            isFavorite == false {
            self.viewData?.isFavorite = true
            self.buttonFavorite.setImage(Image(named: Constants.viewImages.favorite), for: .normal)
        } else {
            self.viewData?.isFavorite = false
            self.buttonFavorite.setImage(Image(named: Constants.viewImages.notFavorite), for: .normal)
        }
        
    }
    
    func prepare(element: TvViewDataElement) {
        self.viewData = element
        self.labelShowName.text = element.titleTvShow
        downloadImage(element.urlImage, element.titleTvShow, self.imageShow)
    }
}

// MARK: - HELPER FUNCTIONS
extension TvShowCell {
    private func downloadImage(_ url: String, _ name: String, _ imageView: UIImageView) {
        if let url:URL = URL(string: url) {
            let resource = ImageResource(downloadURL: url, cacheKey: name)
            imageView.kf.setImage(with: resource, options: nil, completionHandler: { (image, _, _, _) in
                DispatchQueue.main.async(execute: {
                    if let imageResult = image {
                        self.imageShow.image = imageResult
                    }else {
//                        self.imageMovie.image = self.getImageDefault()
                    }
                })
            })
        }
    }
    
    private func getImageDefault() -> UIImage {
        if let image = UIImage(named: "errorImage"){
            return image
        }
        return UIImage()
    }
}
