//
//  AddEditRegistrationTableVC.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/3/22.
//

import UIKit

class AddEditRegistrationTableVC: UITableViewController {

    // MARK: - Outlets
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var chekInDateLabel: UILabel!
    @IBOutlet var chekInDatePicker: UIDatePicker!
    @IBOutlet var chekOutDateLabel: UILabel!
    @IBOutlet var chekOutDatePicker: UIDatePicker!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var wifiSwich: UISwitch!
    @IBOutlet var roomTypeLabel: UILabel!
    @IBOutlet var navigationTitile: UINavigationItem!
    
    // MARK: - Props
    let chekInDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let chekInDatePicherIndexPath = IndexPath(row: 1, section: 1)
    let chekOutDateLabelIndexPath = IndexPath(row: 2, section: 1)
    let chekOutDatePicherIndexPath = IndexPath(row: 3, section: 1)

    var isChekInDatePickerShown: Bool = false {
        didSet {
            chekInDatePicker.isHidden = !isChekInDatePickerShown
        }
    }
    var isChekOutDatePickerShown: Bool = false {
        didSet {
            chekOutDatePicker.isHidden = !isChekOutDatePickerShown
        }
    }

    var roomType: RoomType?
    var registration: Registration?

    // MARK: - UIViewController Methds
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        chekInDatePicker.minimumDate = midnightToday
        chekInDatePicker.date = midnightToday
        updateDateView()
        updateNumberOfGuests()
        updateRoomType()
        editMode()
        
        saveButton.isEnabled = false
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "SelectedRoomType" {
            guard let destination = segue.destination as? SelectRoomTypeTableVC else { return }
            // Swift Lint "as!" bad way rewrite to guard let
            destination.delegate = self
            destination.roomType = roomType
        } else if segue.identifier == "SaveRegistration" {
            saveRegistration()
        }

    }
    // MARK: - UI Methoods
    private func editMode() {
        if let registration = registration {

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.locale = Locale.current

            navigationTitile.title = "Edit registration"
            firstNameTextField.text = registration.firstName
            lastNameTextField.text = registration.lastName
            emailTextField.text = registration.email
            chekInDateLabel.text = dateFormatter.string(from: registration.chekInDate)
            chekInDatePicker.minimumDate = registration.chekInDate
            chekOutDateLabel.text = dateFormatter.string(from: registration.chekOutDate)
            chekOutDatePicker.minimumDate = registration.chekInDate.addingTimeInterval(60 * 60 * 24)
            numberOfAdultsStepper.value = Double(registration.numberOfAdults)
            numberOfAdultsLabel.text = String(registration.numberOfAdults)
            numberOfChildrenStepper.value = Double(registration.numbersOfChtldren)
            numberOfChildrenLabel.text = String(registration.numbersOfChtldren)
            wifiSwich.isOn = registration.wifi
            roomType = registration.roomType // very important value !!!
            roomTypeLabel.text =  "\(registration.roomType!.id) - \(registration.roomType!.name)"
        }
    }

    private func formValidation() {
        guard
            let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text, !lastName.isEmpty,
            let email = emailTextField.text, isValidEmailAddress(emailAddressString: email),
            let roomType = roomType?.name, !roomType.isEmpty
        else {
            saveButton.isEnabled = false
            return
        }

        saveButton.isEnabled = true
    }

    func saveRegistration() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let chekInDate = chekInDatePicker.date
        let chekOutDate = chekOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numbersOfChtldren = Int(numberOfChildrenStepper.value)
        let roomType = roomType
        let wifi = wifiSwich.isOn

        registration = Registration(
            firstName: firstName,
            lastName: lastName,
            email: email,
            chekInDate: chekInDate,
            chekOutDate: chekOutDate,
            numberOfAdults: numberOfAdults,
            numbersOfChtldren: numbersOfChtldren,
            roomType: roomType,
            wifi: wifi
        )
    }
    
    private func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }

    private func updateDateView() {
        chekOutDatePicker.minimumDate = chekInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        chekInDateLabel.text = dateFormatter.string(from: chekInDatePicker.date)
        chekOutDateLabel.text = dateFormatter.string(from: chekOutDatePicker.date)
    }

    private func updateNumberOfGuests() {
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        numberOfAdultsLabel.text = "\(numberOfAdults)"
        numberOfChildrenLabel.text = "\(numberOfChildren)"
    }

    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = "\(roomType.id) - \(roomType.name)"
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }

    // MARK: - Actions
    @IBAction func datePickerValueChanged (_ sender: UIDatePicker) {
        updateDateView()
    }

    @IBAction func stepperValueChanged (_ sender: UIStepper) {
        updateNumberOfGuests()
    }

    @IBAction func textFieldActive (_ sender: UITextField) {
        formValidation()
    }
}

// MARK: - UITableviewDataSource
extension AddEditRegistrationTableVC /*:UITableViewDataSource*/ {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
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
extension AddEditRegistrationTableVC /*: UITableViewDelegate*/ {
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

// MARK: - SelectRoomTypeTableViewProtocol
extension AddEditRegistrationTableVC: SelectRoomTypeTableVCP {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
        formValidation()
    }
}
