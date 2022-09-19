//
//  ElementCell.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 15.09.2022.
//

import UIKit

protocol ElementCellProtocol {
    func addToFavorites(with url: String?)
    func removeFromFavorites(with url: String?)
}

class ElementCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var delegate: ElementCellProtocol?
    var identifierUrl: String?
    var isFavorite: Bool = false {
        didSet{
            if isFavorite {
                favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                favoritesButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    func setCell(model: CollectionViewElementModel) {
        titleLabel.text = model.name
        imageView.downloadImage(with: model.imgUrl)
        identifierUrl = model.imgUrl
        isFavorite = model.isFavorite
    }
    
    @IBAction func favoritesButtonAction(_ sender: UIButton) {
        isFavorite.toggle()
        
        if isFavorite {
            delegate?.addToFavorites(with: identifierUrl)
        } else {
            delegate?.removeFromFavorites(with: identifierUrl)
        }
        
    }
    
}
