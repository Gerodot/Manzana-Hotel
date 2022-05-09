//
//  RoomType.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/3/22.
//

struct RoomType: Codable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType: Equatable {
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}

extension RoomType {
    static var all: [RoomType] {
        return [
            RoomType(id: 101, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 102, name: "One King", shortName: "K", price: 209),
            RoomType(id: 301, name: "Penthouse Suite", shortName: "PHS", price: 309)
        ]
    }
}
