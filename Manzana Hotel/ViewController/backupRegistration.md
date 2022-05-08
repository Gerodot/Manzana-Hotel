#  <#Title#>

//
//  RegistrationsTableViewController.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/6/22.
//

import UIKit

class RegistrationsTableViewController: UITableViewController {

    // MARK: - Properites
    var registrationsManager = RefistrationsManager()
    var registrations: [Registration]!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registrations = Registration.loadDefault()
    }

    //MARK: - Navigatiom
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "editRegistration",
            let selectedPath = tableView.indexPathForSelectedRow
        else {return}
        
//        let registration = registrations[selectedPath.row]
//        let description = segue.destination as! AddEditRegistrationTableViewController
//        description.registration = registration
                
    }
}

// MARK: - UITableViewSouces
extension RegistrationsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let registration = registrations[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell")
                as? RegistrationsTableViewCell else {
            fatalError("UITableViewCell failed while casting")
        }
        registrationsManager.configure(cell, with: registration)
        return cell
    }
}
