//
//  String.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 18.09.2022.
//

import Foundation

//I know this extension could be problematic but have to try.

extension String {
    func toDate(withFormat format: String? = "yyyy-MM-dd") -> Date {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }
}
