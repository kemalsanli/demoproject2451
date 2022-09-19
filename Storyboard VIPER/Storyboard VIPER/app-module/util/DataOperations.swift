//
//  DataOperations.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 18.09.2022.
//

import Foundation

class DataOperations {
    let favoriteBooksJsonUrl = URL(fileURLWithPath: "FavoriteBooks",
                           relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    init(){}
    
     func loadJSONBooks() ->  [Result] {
      let decoder = JSONDecoder()
        var loadedBooks: [Result] = []
      do {
        let booksData = try Data(contentsOf: favoriteBooksJsonUrl)
        loadedBooks = try decoder.decode([Result].self, from: booksData)
      } catch let error {
        print(error)
      }
        return loadedBooks
    }
    
    func saveJSONBooks(with books: [Result]) {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted

      do {
        let tasksData = try encoder.encode(books)
        
        try tasksData.write(to: favoriteBooksJsonUrl, options: .atomicWrite)
      } catch let error {
        print(error)
      }
    }
    
    func saveToFavorites(with model: Result) {
        var favorites = loadJSONBooks()
        favorites.append(model)
        saveJSONBooks(with: favorites)
    }
    
    func removeFromFavorites(with model: Result) {
        var favorites = loadJSONBooks()
        favorites = favorites.filter { $0.imgUrl != model.imgUrl }
        saveJSONBooks(with: favorites)
    }
    
    func checkFavorites(with model: Result) -> Bool {
        let favorites = loadJSONBooks()
        return !favorites.filter { $0.imgUrl == model.imgUrl }.isEmpty
    }
    
}

fileprivate extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
