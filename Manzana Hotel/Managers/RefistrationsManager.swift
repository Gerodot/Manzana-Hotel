//
//  RefistrationsManager.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/6/22.
//

import UIKit

class RefistrationsManager {
    func configure (_ cell: RegistrationsTableViewCell, with registration: Registration) {
        cell.clientName.text = "\(registration.firstName) \(registration.lastName) (A:\(registration.numberOfAdults) Ch:\(registration.numbersOfChtldren))"
        cell.roomNumer.text = "\(String(describing: registration.roomType!.id)) \(String(describing: registration.roomType!.name))"
    }
}
