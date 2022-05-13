//
//  RegistrationsTableVC.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/6/22.
//

import UIKit

class RegistrationsTableVC: UITableViewController {
// MARK: - Properties

    let dataStorage = DataStorage()
    var roomType: RoomType?
    var registrations: [Registration]! {
        didSet {
            // Sort registrations by room id
            registrations = registrations
                .sorted(by: { $0.roomType!.id < $1.roomType!.id })
            // Save registrations to DataStorage
            dataStorage.saveRegistraionsDB(registrations)
            // Groupig registrations by floor to display on the user interface
            sortByFloor()
        }
    }
    var regByFloorToDispaly: [[Registration]] = []

    // MARK: - Methods

    // Preparing the information to be displayed on the VC
    override func viewDidLoad() {
        super.viewDidLoad()
        registrations = dataStorage.loadRegistraionsDB() ?? Registration.all
        sortByFloor()
    }

    // Grouping an array of registrations by floors into subarrays
    func sortByFloor() {
        regByFloorToDispaly = Array(Dictionary(grouping: registrations) { $0.roomType!.floor }.values)
            .sorted(by: { $0[0].roomType!.floor < $1[0].roomType!.floor })
    }

    // MARK: - Navigatiom
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "EditRegistration",
            let selectedPath = tableView.indexPathForSelectedRow,
            let description = segue.destination as? AddEditRegistrationTableVC
        else { return }

        // Preparing information and transferring to another VC
        let registration = regByFloorToDispaly[selectedPath.section][selectedPath.row]
        description.registration = registration
    }
}

// MARK: - UITableViewDataSource
extension RegistrationsTableVC /*: UITableViewDataSource*/ {

    // Definition of the maximum number of floors to be grouped by floor by section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return regByFloorToDispaly.count
    }
    // Determining the number of registrations per floor to display in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regByFloorToDispaly[section].count
    }

    // Getting the section name
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Floor \(regByFloorToDispaly[section][0].roomType!.floor)"
    }

    // Forming cell contents
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Declaring TableViewCell value
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        // Get registration value from registrations array
        let registration = regByFloorToDispaly[indexPath.section][indexPath.row]

        // Declaring service variables (Lint Best Practicles)
        let firstName = registration.firstName
        let lastName = registration.lastName
        let numberOfAdults = registration.numberOfAdults
        let numbersOfChtldren = registration.numbersOfChtldren
        let roomNumber = String(describing: registration.roomType!.id)
        let roomName = String(describing: registration.roomType!.name)

        // Head Text strinf
        let headString = "\(roomNumber) - \(firstName) \(lastName)"

        // Declaring icons from SF Sybols library
        let adulsSFImage = NSTextAttachment()
        let childrenSFImage = NSTextAttachment()
        let wifiSFImage = NSTextAttachment()

        // Insert SF Symbol value to icon variables
        adulsSFImage.image = UIImage(systemName: "person.fill")?.withTintColor(UIColor.label)
        childrenSFImage.image = UIImage(systemName: "person.2.fill")?.withTintColor(UIColor.label)
        wifiSFImage.image = UIImage(systemName: "wifi")?.withTintColor(UIColor.label)

        // Ganeration of the String line
        let detailString = NSMutableAttributedString(string: "\(roomName) - ")
        detailString.append(NSAttributedString(attachment: adulsSFImage))
        detailString.append(NSAttributedString(string: ":\(numberOfAdults) "))
        detailString.append(NSAttributedString(attachment: childrenSFImage))
        detailString.append(NSAttributedString(string: ":\(numbersOfChtldren) "))
        if registration.wifi {
            detailString.append(NSAttributedString(attachment: wifiSFImage))
        }

        // Send date to cell labels
        cell.textLabel?.text = headString
        cell.detailTextLabel?.attributedText = detailString

        return cell
    }
}

// MARK: - Actions
extension RegistrationsTableVC {
    @IBAction func unwind(_ segue: UIStoryboardSegue) {

        guard
            segue.identifier == "SaveRegistration",
            let source = segue.source as? AddEditRegistrationTableVC
        else { return }

        let registration = source.registration!

//      if let selectedPath = tableView.indexPathForSelectedRow {
//          // Edited cell
//          registrations[selectedPath.row] = registration
//          tableView.reloadRows(at: [selectedPath], with: .automatic)
//      } else {
//          // Added cell
//          let indexPath = IndexPath(row: registrations.count, section: 0)
//          registrations.append(registration)
//          tableView.insertRows(at: [indexPath], with: .automatic)
//      }

        if let selectedPath = tableView.indexPathForSelectedRow {
            // Edited cell
            regByFloorToDispaly[selectedPath.section][selectedPath.row] = registration
            registrations = Array(regByFloorToDispaly.joined())
            sortByFloor()
        } else {
            // Added cell
            registrations.append(registration)
            sortByFloor()
        }

        tableView.reloadData()
    }
}
