//
//  ShowViewController.swift
//  Movs
//
//  Created by BRQ on 17/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelSinopse: UILabel!
    
    // MARK: - PROPERTYS
    var element: TvViewDataElement?
    private var favHelper = FavoriteHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
         setupDetail()
    }
    
    
    @IBAction func favoriteClicked(_ sender: Any) {
        guard let element = self.element else { return }
            
        self.favHelper.validation(show: element, isFavorite: element.isFavorite, isFromDatabase: false, button: self.favoriteButton)
    }
    
}

// MARK: - HELPER FUNCTIONS
extension ShowViewController: ImageHelper {
    private func setupDetail() {
        let element = self.element!
        
        self.labelName.text = element.titleTvShow
        self.labelYear.text = element.releaseDate.dateFormated()
        self.labelSinopse.text = element.description
        self.labelGenre.text = element.genres?.joined(separator: ", ")
        downloadImage(element.urlImage, element.titleTvShow, self.imageShow)
        if element.isFavorite {
            self.favoriteButton.setImage(UIImage(named: Constants.viewImage.favorite), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: Constants.viewImage.notFavorite), for: .normal)
        }
    }
}
