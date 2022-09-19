//
//  BooksModel.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 17.09.2022.
//

import Foundation

// MARK: - BooksModel
struct BooksModel: Codable {
    var feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    var results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let artistName, id, name, releaseDate: String
    let imgUrl: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate
        case imgUrl = "artworkUrl100"
    }
}

