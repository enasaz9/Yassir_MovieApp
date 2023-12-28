//
//  DateFormatterHelper.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 28/12/2023.
//

import Foundation

class DateFormatterHelper {
    static private let dateFormatter = DateFormatter()
    
    static func formateDateString(_ inputDateString: String, inputDateFormat: String = "yyyy-MM-dd", outputDateFormat: String = "MMM dd, yyyy") -> String {
        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateFromString  = dateFormatter.date(from: inputDateString) ?? Date()
        dateFormatter.dateFormat = outputDateFormat
        
        return dateFormatter.string(from: dateFromString as Date)
    }
}
