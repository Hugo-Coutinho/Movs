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
        self.labelShowYear.text = element.releaseDate.dateFormated()
        self.labelShowDescription.text = element.description
        self.imageManager(element.urlImage, element.titleTvShow, self.imageViewShow)
    }
    
}

extension FavoriteCell: ImageHelper {

    private func imageManager(_ url: String, _ name: String, _ imageView: UIImageView) {
        self.downloadImage(url, name, imageView)
    }
}
