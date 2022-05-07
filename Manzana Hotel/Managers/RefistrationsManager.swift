//
//  RefistrationsManager.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/6/22.
//

import UIKit

class RefistrationsManager {
    func configure (_ cell: RegistrationsTableViewCell, with registration: Registration) {
        let firstName = registration.firstName
        let lastName = registration.lastName
        let numberOfAdults = registration.numberOfAdults
        let numbersOfChtldren = registration.numbersOfChtldren
        let roomNumber = String(describing: registration.roomType!.id)
        let roomName = String(describing: registration.roomType!.name)
        cell.clientName.text = "\(firstName) \(lastName) (\(numberOfAdults) \(numbersOfChtldren))"
        cell.roomNumer.text = "\(roomNumber) \(roomName)"
    }
}
