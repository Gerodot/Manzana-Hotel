//
//  Registration.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/3/22.
//

import Foundation

struct Registration: Codable {
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
        let today = Calendar.current.startOfDay(for: Date())
        let tomorrow = today.addingTimeInterval(60 * 60 * 24)
        return [
             Registration(
                firstName: "Arseniy",
                lastName: "Petrov",
                email: "petrovbars@ya.com",
                chekInDate: today,
                chekOutDate: tomorrow,
                numberOfAdults: 1,
                numbersOfChtldren: 0,
                roomType: RoomType(
                    id: 104,
                    name: "One Queen",
                    shortName: "1Q",
                    price: 129
                ),
                wifi: true
             ),
             Registration(
                firstName: "Valentine ",
                lastName: "Petukhov",
                email: "ads@wilsa.com",
                chekInDate: today,
                chekOutDate: tomorrow,
                numberOfAdults: 2,
                numbersOfChtldren: 2,
                roomType: RoomType(
                    id: 203,
                    name: "Two Queens",
                    shortName: "2Q",
                    price: 179),
                wifi: true
             ),
             Registration(
                firstName: "Jhon",
                lastName: "Appleseed",
                email: "jhon@appleseed.com",
                chekInDate: today,
                chekOutDate: tomorrow,
                numberOfAdults: 1,
                numbersOfChtldren: 0,
                roomType: RoomType(
                    id: 204,
                    name: "Two Queens",
                    shortName: "2Q",
                    price: 179),
                wifi: true
             ),
             Registration(
                firstName: "Vuasya",
                lastName: "Pumpkin",
                email: "vyasya@pumpkon.ru",
                chekInDate: today,
                chekOutDate: tomorrow,
                numberOfAdults: 2,
                numbersOfChtldren: 2,
                roomType: RoomType(
                    id: 205,
                    name: "Two Queens",
                    shortName: "2Q",
                    price: 179),
                wifi: false
             ),
             Registration(
                firstName: "Takuya",
                lastName: "Matsuyama",
                email: "info@inkdrop.app",
                chekInDate: today,
                chekOutDate: tomorrow,
                numberOfAdults: 1,
                numbersOfChtldren: 0,
                roomType: RoomType(
                    id: 306,
                    name: "One King",
                    shortName: "K", price: 209
                ),
                wifi: true),
             Registration(
                firstName: "Pasha",
                lastName: "Durov ",
                email: "durov@telegram.com",
                chekInDate: today,
                chekOutDate: tomorrow,
                numberOfAdults: 1,
                numbersOfChtldren: 0,
                roomType: RoomType(
                    id: 402,
                    name: "Penthouse Suite",
                    shortName: "PHS",
                    price: 309),
                wifi: false
             )
        ]

    }
}
