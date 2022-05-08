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
    // Test data
    static var all: [Registration] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return [
            Registration(
                firstName: "Jhon",
                lastName: "Appleseed",
                email: "jhon@appleseed.com",
                chekInDate: dateFormatter.date(from: "2016/10/08 22:31")!,
                chekOutDate: dateFormatter.date(from: "2016/11/28 22:31")!,
                numberOfAdults: 1,
                numbersOfChtldren: 0,
                roomType: RoomType(
                    id: 202,
                    name: "Two Queens",
                    shortName: "2Q",
                    price: 179
                ),
                wifi: false
            ),
            Registration(
                firstName: "Hoshimi",
                lastName: "Nagate",
                email: "hoshimi@nagate.jp",
                chekInDate: dateFormatter.date(from: "2016/10/08 22:31")!,
                chekOutDate: dateFormatter.date(from: "2016/11/28 22:31")!,
                numberOfAdults: 1,
                numbersOfChtldren: 0,
                roomType: RoomType(
                    id: 401,
                    name: "Penthouse Suite",
                    shortName: "PHS",
                    price: 309
                ),
                wifi: true
            )
        ]
    }
}
