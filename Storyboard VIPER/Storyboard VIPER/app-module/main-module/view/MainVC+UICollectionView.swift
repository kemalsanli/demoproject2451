//
//  MainVC+UICollectionView.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 17.09.2022.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func createCVLayout(spacing: CGFloat, columnCount: CGFloat) -> UICollectionViewFlowLayout {
        
        let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.collectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        let cellWidth = (width - ((columnCount + 1) * spacing)) / columnCount
        
        // 1.50 is UX value for this design.
        design.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.50)
        
        design.minimumInteritemSpacing = spacing
        design.minimumLineSpacing = spacing
        
        return design
    }
    
     func setCollectionViewAttributes() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCVLayout(spacing: 10 , columnCount: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MainPresenter?.getBooksCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "elementCell", for: indexPath) as! ElementCell
        cell = (MainPresenter?.getCellModel(cell: cell, index: indexPath))!
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MainPresenter?.didSelectBook(index: indexPath)
    }
    
    
}

//Cell button delegate
extension MainViewController: ElementCellProtocol {
    func addToFavorites(with url: String?) {
        guard let url = url else { return }
        MainPresenter?.addBookToFavorites(with: url)
    }
    
    func removeFromFavorites(with url: String?) {
        guard let url = url else { return }
        MainPresenter?.removeBookFromFavorites(with: url)
    }
}

//Scrollview operations for pagination
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView.contentSize.height - scrollView.frame.size.height) {
            MainPresenter?.getNextIndex()
        }
    }
}
