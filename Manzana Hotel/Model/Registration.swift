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

extension Registration {
    static var all: [Registration] {
        let midnightToday = Calendar.current.startOfDay(for: Date())
        let tomorrow = midnightToday.addingTimeInterval(60 * 60 * 24)
        return
            [
                Registration(
                    firstName: "Jhon",
                    lastName: "Appleseed",
                    email: "jhon@appleseed.com",
                    chekInDate: midnightToday,
                    chekOutDate: tomorrow,
                    numberOfAdults: 1,
                    numbersOfChtldren: 0,
                    roomType:  RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                    wifi: true
                ),
                Registration(
                    firstName: "Hoshimi",
                    lastName: "Nagate",
                    email: "hoshimi@nagate.jp",
                    chekInDate: midnightToday,
                    chekOutDate: tomorrow,
                    numberOfAdults: 1,
                    numbersOfChtldren: 0,
                    roomType:  RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309),
                    wifi: true
                ),
            ]
        
    }
    
    static func loadDefault () -> [Registration] {
        return all
    }
}
