//
//  RegistrationsTableViewController.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/6/22.
//

import UIKit

class RegistrationsTableViewController: UITableViewController {

    // MARK: - Properites
    var registrations: [Registration]!
    var roomType: RoomType?

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registrations = Registration.all
    }

    // MARK: - Navigatiom
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "editRegistration",
            let selectedPath = tableView.indexPathForSelectedRow,
            let description = segue.destination as? AddEditRegistrationTableViewController
        else {return}

        let registration = registrations[selectedPath.row]
        dump(registration)
        description.registration = registration
        dump(description.registration)
    }
}

// MARK: - UITableViewDataSource
extension RegistrationsTableViewController /*: UITableViewDataSource*/ {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Registration.all.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = Registration.all[indexPath.row]

        let firstName = registration.firstName
        let lastName = registration.lastName
        let numberOfAdults = registration.numberOfAdults
        let numbersOfChtldren = registration.numbersOfChtldren
        let roomNumber = String(describing: registration.roomType!.id)
        let roomName = String(describing: registration.roomType!.name)

        let adulsSFImage = NSTextAttachment()
        let childrenSFImage = NSTextAttachment()
        let wifiSFImage = NSTextAttachment()

        adulsSFImage.image = UIImage(systemName: "person.fill")?.withTintColor(UIColor.label)
        childrenSFImage.image = UIImage(systemName: "person.2.fill")?.withTintColor(UIColor.label)
        wifiSFImage.image = UIImage(systemName: "wifi")?.withTintColor(UIColor.label)

        let fullString = NSMutableAttributedString(string: "\(roomName) - ")
        fullString.append(NSAttributedString(attachment: adulsSFImage))
        fullString.append(NSAttributedString(string: ": \(numberOfAdults) "))
        fullString.append(NSAttributedString(attachment: childrenSFImage))
        fullString.append(NSAttributedString(string: ": \(numbersOfChtldren) "))
        if registration.wifi {
            fullString.append(NSAttributedString(attachment: wifiSFImage))
        }

        cell.textLabel?.text = "\(roomNumber) - \(firstName) \(lastName)"
        cell.detailTextLabel?.attributedText = fullString

        return cell
    }
}
