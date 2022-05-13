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
            RoomType(id: 101, name: "One Queen", shortName: "1Q", price: 129),
            RoomType(id: 102, name: "One Queen", shortName: "1Q", price: 129),
            RoomType(id: 103, name: "One Queen", shortName: "1Q", price: 129),
            RoomType(id: 104, name: "One Queen", shortName: "1Q", price: 129),
            RoomType(id: 105, name: "One Queen", shortName: "1Q", price: 129),
            RoomType(id: 106, name: "One Queen", shortName: "1Q", price: 129),

            RoomType(id: 201, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 202, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 203, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 204, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 205, name: "Two Queens", shortName: "2Q", price: 179),
            RoomType(id: 206, name: "Two Queens", shortName: "2Q", price: 179),

            RoomType(id: 301, name: "One King", shortName: "K", price: 209),
            RoomType(id: 302, name: "One King", shortName: "K", price: 209),
            RoomType(id: 303, name: "One King", shortName: "K", price: 209),
            RoomType(id: 304, name: "One King", shortName: "K", price: 209),
            RoomType(id: 305, name: "One King", shortName: "K", price: 209),
            RoomType(id: 306, name: "One King", shortName: "K", price: 209),

            RoomType(id: 401, name: "Penthouse Suite", shortName: "PHS", price: 309),
            RoomType(id: 402, name: "Penthouse Suite", shortName: "PHS", price: 309)
        ]
    }
}
extension RoomType {
    var floor: Int {
        return Int(String(String(id).first!))!
    }
}
