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
    @IBOutlet weak var imageFavorite: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepare(element: TvViewDataElement) {
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
