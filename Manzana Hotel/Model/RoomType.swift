//
//  RoomType.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/3/22.
//

struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType: Equatable{
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}
