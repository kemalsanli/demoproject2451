//
//  UIImageView.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 17.09.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(with url: String) {
        guard let URL = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: URL) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.image =  UIImage(data: data)
                }
                
            }
        }
        
        task.resume()
    }
}
