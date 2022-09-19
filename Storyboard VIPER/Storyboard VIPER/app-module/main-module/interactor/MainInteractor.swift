//
//  MainInteractor.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 17.09.2022.
//

import Foundation

///:Api that provided for me not compatible with "Pagination", I have to add it locally
///https://developer.apple.com/forums/thread/60775

final class MainInteractor: PresenterToInteractorMainProtocol{

    var MainPresenter: InteractorToPresenterMainProtocol?
    var isLoading: Bool = false
    
    func fetchBookData(with limit: Int, pagination: Bool) {
        guard 100 >= limit else { return } //Api has 100 limit
        guard let url =  URL(string: String(format: Constants.mainUrl, limit)) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, taskError in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode),
                  let data = data else {
                fatalError()
            }
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(BooksModel.self, from: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                //Due to pagination limits, data limited to last 20
                if pagination {
                    self?.MainPresenter?.sendNextIndex(with: response.feed.results.suffix(20))
                } else {
                    self?.MainPresenter?.sendBookData(with: response.feed.results.suffix(20))
                }
                
            }
            
        }.resume()
    }
    
    func getNextIndex(with limit: Int) {
        fetchBookData(with: limit,pagination: true)
    }
    
}

private enum Constants {
    static let mainUrl: String = "https://rss.applemarketingtools.com/api/v2/tr/books/top-free/%d/books.json"
}
