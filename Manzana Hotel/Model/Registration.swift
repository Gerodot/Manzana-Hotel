//
//  Registration.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/3/22.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var email: String
    
    var chekInDate: Date
    var chekOutDate: Date
    var numberOfAdults: Int
    var numbersOfChtldren: Int
    
    var roomType: RoomType?
    var wifi: Bool
}
