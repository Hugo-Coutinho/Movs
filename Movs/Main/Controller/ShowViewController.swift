//
//  ShowViewController.swift
//  Movs
//
//  Created by BRQ on 17/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelSinopse: UILabel!
    
    var element: TvViewDataElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.element != nil {
         setupDetail()
        }
    }
}

// MARK: - HELPER FUNCTIONS
extension ShowViewController: ImageHelper {
    private func setupDetail() {
        let element = self.element!
        
        self.labelName.text = element.titleTvShow
        self.labelYear.text = element.releaseDate
        self.labelSinopse.text = element.description
        self.labelGenre.text = element.genres?.joined(separator: ", ")
        downloadImage(element.urlImage, element.titleTvShow, self.imageShow)
        favoriteImage.image = UIImage(named: Constants.viewImage.favorite)
    }
}
