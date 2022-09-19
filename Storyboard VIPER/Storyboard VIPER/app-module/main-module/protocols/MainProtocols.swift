//
//  MainProtocols.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 17.09.2022.
//

import Foundation
import UIKit

protocol ViewToPresenterMainProtocol {
    var MainInteractor:PresenterToInteractorMainProtocol? {get set}
    var MainView:PresenterToViewMainProtocol? {get set}
    
    func getBookData()
    func getNextIndex()
    
    func actionAll()
    func actionNewest()
    func actionOldest()
    func actionFavorites()
    
    func getBooksCount() -> Int
    func getCellModel(cell: ElementCell, index: IndexPath) -> ElementCell 
    func addBookToFavorites(with url: String)
    func removeBookFromFavorites(with url: String)
    func didSelectBook(index: IndexPath)
    
}

protocol PresenterToInteractorMainProtocol {
    var MainPresenter:InteractorToPresenterMainProtocol? {get set}
    
    func fetchBookData(with limit:Int, pagination: Bool)
    func getNextIndex(with limit: Int)
}

protocol InteractorToPresenterMainProtocol {
    func sendBookData(with object: [Result])
    func sendNextIndex(with object: [Result])
}

protocol PresenterToViewMainProtocol {
    func sendBookData()
    func sendNextIndex()
    func sendSegueObject(object: Result)
}

protocol PresenterToRouterMainProtocol {
    static func createModule(ref:MainViewController)
}
