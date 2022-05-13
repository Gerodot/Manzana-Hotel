//
//  SelectRoomTypeTableVC.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/6/22.
//

import UIKit

class SelectRoomTypeTableVC: UITableViewController {

    // MARK: - Properties
    private let dataStorage = DataStorage()
    var delegate: SelectRoomTypeTableVCP?
    var roomType: RoomType?
    var currectRoomType: RoomType?
    private var emptyRoomsByFloor: [[RoomType]] = []

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())

        // Creating a list of rooms that are busy today
        let busyRmms = dataStorage.loadRegistraionsDB()!
            .filter({ $0.chekInDate...$0.chekOutDate ~= midnightToday})
            .map { $0.roomType! }

        // Filtering list of rooms that are free today
        var emptyRooms = RoomType.all.filter({ !busyRmms.contains($0)})

        // Adding an already-occupied room to the vacancy list
        if let roomType = roomType {
            emptyRooms.append(roomType)
            emptyRooms = emptyRooms.sorted(by: { $0.id < $1.id })
        }

        // Creating lists of rooms available today sorted by floor
        emptyRoomsByFloor = Array(Dictionary(grouping: emptyRooms) { $0.floor }.values)
            .sorted(by: { $0.first!.floor < $1.first!.floor })
    }
}

// MARK: - UITableViewDataSource
extension SelectRoomTypeTableVC /*: UITableViewDataSource*/ {

    // Definition of the maximum number of floors to be grouped by floor by section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return emptyRoomsByFloor.count
    }

    // Determining the number of registrations per floor to display in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyRoomsByFloor[section].count
    }

    // Getting the section name
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Floor \(String(emptyRoomsByFloor[section].first!.id).first!)"
    }

    // Adding content to the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Declaring TableViewCell value
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)

        // Get room value from rooms array
        let roomType = emptyRoomsByFloor[indexPath.section][indexPath.row]

        // Adding chekmark indicator to cell
        cell.accessoryType = roomType == self.roomType ? .checkmark : .none

        // Send date to cell labels
        cell.textLabel?.text = "\(roomType.id) - \(roomType.name)"
        cell.detailTextLabel?.text = "$ \(roomType.price)"

        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectRoomTypeTableVC/*: UITableViewDelegate*/ {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        roomType = emptyRoomsByFloor[indexPath.section][indexPath.row]
        delegate?.didSelect(roomType: roomType!)
        tableView.reloadData()
    }
}
