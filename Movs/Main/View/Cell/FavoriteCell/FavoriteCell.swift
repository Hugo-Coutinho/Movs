//
//  FavoriteCell.swift
//  Movs
//
//  Created by BRQ on 09/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var labelShowTitle: UILabel!
    @IBOutlet weak var labelShowYear: UILabel!
    @IBOutlet weak var labelShowDescription: UILabel!
    @IBOutlet weak var imageViewShow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
