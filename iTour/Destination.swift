//
//  Destination.swift
//  iTour
//
//  Created by Mayur Vaity on 07/08/24.
//

import Foundation
import SwiftData

//model macro to make this class a swiftdata table 
@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    
//    priority values could be 1, 2 or 3
//    1 - high
//    2 - medium
//    3 - low
    
    //setting default values if not passed
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
