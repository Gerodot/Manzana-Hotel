//
//  AddRegistrationTableViewController.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/3/22.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet weak var chekInDateLabel: UILabel!
    @IBOutlet weak var chekInDatePicker: UIDatePicker!
    @IBOutlet weak var chekOutDateLabel: UILabel!
    @IBOutlet weak var chekOutDatePicker: UIDatePicker!
    
    // MARK: - Props
    let chekInDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let chekInDatePicherIndexPath = IndexPath (row: 1, section: 1)
    let chekOutDateLabelIndexPath = IndexPath(row: 2, section: 1)
    let chekOutDatePicherIndexPath = IndexPath (row: 3, section: 1)

    var isChekInDatePickerShown: Bool = false {
        didSet {
            chekInDatePicker.isHidden = !isChekInDatePickerShown
        }
    }
    var isChekOutDatePickerShown: Bool = false {
        didSet{
            chekOutDatePicker.isHidden = !isChekOutDatePickerShown
        }
    }
    
    // MARK: - UIViewController Methds
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        chekInDatePicker.minimumDate = midnightToday
        chekInDatePicker.date = midnightToday
        
        updateDateView()
    }
    
    // MARK: - Methood
    func updateDateView() {
        chekOutDatePicker.minimumDate = chekInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        
        chekInDateLabel.text = dateFormatter.string(from: chekInDatePicker.date)
        chekOutDateLabel.text = dateFormatter.string(from: chekOutDatePicker.date)
    }
    
    
    // MARK: - Actions
    @IBAction func datePickerValueChanged (_ sender: UIDatePicker) {
        updateDateView()
    }
    
    @IBAction func doneButtonTapped (_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let chekInDate = chekInDatePicker.date
        let chekOutDate = chekOutDatePicker.date
        
        let registration = Registration(
            firstName: firstName,
            lastName: lastName,
            email: email,
            chekInDate: chekInDate,
            chekOutDate: chekOutDate,
            numberOfAdults: 0,
            numbersOfChtldren: 0,
            roomType: RoomType(
                id: 0,
                name: "",
                shortName: "",
                price: 0
            ),
            wifi: false
        )
        dump(registration)
    }
}

// MARK: - UITableviewDataSource
extension AddRegistrationTableViewController /*:UITableViewDataSource*/ {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case chekInDatePicherIndexPath:
            return isChekInDatePickerShown ? UITableView.automaticDimension : 0
        case chekOutDatePicherIndexPath:
            return isChekOutDatePickerShown ? UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDelegate
extension AddRegistrationTableViewController /*: UITableViewDelegate*/ {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case chekInDateLabelIndexPath:
            isChekInDatePickerShown.toggle()
            isChekOutDatePickerShown = false
        case chekOutDateLabelIndexPath:
            isChekOutDatePickerShown.toggle()
            isChekInDatePickerShown = false
        default:
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
