//
//  DetailsViewController.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 15.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var bookNameTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var model: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = model {
            setContent(with: model)
        }
    }
    
    func setContent(with model: Result) {
        configureButton()
        bookNameTitle.text = model.name
        informationTextView.text = model.artistName + "\n" + model.releaseDate
        imageView.downloadImage(with: model.imgUrl)
    }
    
    private func configureButton() {
        guard let model = model else { return }
        if DataOperations().checkFavorites(with: model) {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        guard let model = model else { return }
        if DataOperations().checkFavorites(with: model) {
            DataOperations().removeFromFavorites(with: model)
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            DataOperations().saveToFavorites(with: model)
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        
    }
    

}
