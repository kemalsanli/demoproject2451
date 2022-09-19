//
//  MainVC+UINavigationController.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 18.09.2022.
//

import Foundation
import UIKit

//UINavigation Controller
extension MainViewController {
     func configureNavigation() {
        let allItem = UIAction(title: "All", image: UIImage(systemName: "lightbulb.fill")) { [weak self] _ in
            guard let self = self else  { return }
            self.MainPresenter?.actionAll()
        }
        
        let newestItem = UIAction(title: "Newest", image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            guard let self = self else  { return }
            self.MainPresenter?.actionNewest()
        }
        
        let oldestItem = UIAction(title: "Oldest", image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            guard let self = self else { return }
            self.MainPresenter?.actionOldest()
        }
        
        let favoritesItem = UIAction(title: "Favorites", image: UIImage(systemName: "star.fill")) { [weak self] _ in
            guard let self = self else { return }
            self.MainPresenter?.actionFavorites()
        }
        
        let menu = UIMenu(title: "Sort", options: .displayInline, children: [allItem , newestItem , oldestItem, favoritesItem])
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle") , menu: menu )
    }
}
