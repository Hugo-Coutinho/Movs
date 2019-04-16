//
//  File.swift
//  Movs
//
//  Created by BRQ on 16/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

protocol ImageHelper {
    func downloadImage(_ url: String, _ name: String, _ imageView: UIImageView)
}

extension ImageHelper {
    func downloadImage(_ url: String, _ name: String, _ imageView: UIImageView) {
        if let url:URL = URL(string: url) {
            let resource = ImageResource(downloadURL: url, cacheKey: name)
            imageView.kf.setImage(with: resource, options: nil, completionHandler: { (image, _, _, _) in
                if let imageResult = image {
                    imageView.image = imageResult
                }else {
                    print("error")
                    imageView.image = self.getImageDefault()
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


