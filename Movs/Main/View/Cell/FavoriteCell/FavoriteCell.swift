//
//  FavoriteCell.swift
//  Movs
//
//  Created by BRQ on 09/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var labelShowTitle: UILabel!
    @IBOutlet weak var labelShowYear: UILabel!
    @IBOutlet weak var labelShowDescription: UILabel!
    @IBOutlet weak var imageViewShow: UIImageView!
    
    private var viewData: TvViewDataElement?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(element: TvViewDataElement) {
        self.viewData = element
        self.labelShowTitle.text = element.titleTvShow
        self.labelShowYear.text = element.releaseDate
        self.labelShowDescription.text = element.description
        self.downloadImage(element.urlImage, element.titleTvShow, self.imageViewShow)
    }
    
}

extension FavoriteCell {
    private func downloadImage(_ url: String, _ name: String, _ imageView: UIImageView) {
        if let url:URL = URL(string: url) {
            let resource = ImageResource(downloadURL: url, cacheKey: name)
            imageView.kf.setImage(with: resource, options: nil, completionHandler: { (image, _, _, _) in
                if let imageResult = image {
                    self.imageViewShow.image = imageResult
                }else {
                    print("error")
                    self.imageViewShow.image = self.getImageDefault()
                }
            })
        }
    }
    
    private func getImageDefault() -> UIImage {
        if let image = UIImage(named: Constants.viewImage.defaultImage) {
            return image
        }
        return UIImage()
    }
}
