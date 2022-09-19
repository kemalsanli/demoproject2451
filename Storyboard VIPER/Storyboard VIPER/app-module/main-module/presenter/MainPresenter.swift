//
//  MainPresenter.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 17.09.2022.
//

import Foundation
import UIKit

final class MainPresenter: ViewToPresenterMainProtocol, InteractorToPresenterMainProtocol{

    var MainInteractor: PresenterToInteractorMainProtocol?
    
    var MainView: PresenterToViewMainProtocol?
    
    private var index: Int = 20
    var onFavorites: Bool = false
    var books: [Result] = []
    var isLoading: Bool = false
    var customOrderBooks: [Result] = [] {
        didSet {
            MainView?.sendNextIndex()
        }
    }
    
    var favoriteBooks: [Result] = [] {
        didSet {
            saveFavoriteBooks()
        }
    }
    
    func getBookData() {
        loadFavoriteBooks()
        isLoading = true
        MainInteractor?.fetchBookData(with: index, pagination: false)
    }
    
    func sendBookData(with object: [Result]) {
        isLoading = false
        books = object
        customOrderBooks = object
        MainView?.sendBookData()
    }
    
    func getNextIndex() {
        if !isLoading && !onFavorites {
            index += 20
            isLoading = true
            MainInteractor?.getNextIndex(with: index)
        }
    }
    
    func sendNextIndex(with object: [Result]) {
        self.books.append(contentsOf: object)
        self.customOrderBooks.append(contentsOf: object)
        self.isLoading = false
        MainView?.sendNextIndex()
    }
    
}

// Data Operations
extension MainPresenter {
    func saveFavoriteBooks() {
        DataOperations().saveJSONBooks(with: favoriteBooks)
    }
    
    func loadFavoriteBooks() {
        favoriteBooks = DataOperations().loadJSONBooks()
    }
}

//Navigation Bar actions
extension MainPresenter {
    func actionAll() {
        self.onFavorites = false
        self.customOrderBooks = self.books
        //self.collectionView.reloadData()
    }
    func actionNewest() {
        self.onFavorites = false
        self.customOrderBooks = self.books.sorted {  $0.releaseDate.toDate().compare($1.releaseDate.toDate()) == .orderedDescending }
    }
    func actionOldest() {
        self.onFavorites = false
        self.customOrderBooks = self.books.sorted {  $0.releaseDate.toDate().compare($1.releaseDate.toDate()) == .orderedAscending }
    }
    func actionFavorites() {
        self.onFavorites = true
        self.customOrderBooks = self.favoriteBooks.sorted {  $0.releaseDate.toDate().compare($1.releaseDate.toDate()) == .orderedDescending }
    }
}

//CollectionView requirements
extension MainPresenter {
    func getBooksCount() -> Int {
        return customOrderBooks.count
    }
    
    func getCellModel(cell: ElementCell, index: IndexPath) -> ElementCell {
        let book = customOrderBooks[index.row]
        let isFavorite = !favoriteBooks.filter { $0.imgUrl == book.imgUrl }.isEmpty
        cell.setCell(model: CollectionViewElementModel(name: book.name,
                                                       imgUrl: book.imgUrl,
                                                       isFavorite: isFavorite))
        return cell
    }
    
    func addBookToFavorites(with url: String) {
        let book = customOrderBooks.filter { $0.imgUrl == url }
        if let selectedBook = book.first {
            favoriteBooks.append(selectedBook)
        }
    }
    
    func removeBookFromFavorites(with url: String) {
        favoriteBooks = favoriteBooks.filter { $0.imgUrl != url }
        if onFavorites {
            customOrderBooks = favoriteBooks
        }
    }
    
    func didSelectBook(index: IndexPath) {
        MainView?.sendSegueObject(object: customOrderBooks[index.row])
    }
    
}
