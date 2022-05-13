//
//  DataStorage.swift
//  Manzana Hotel
//
//  Created by Gerodot on 5/9/22.
//
import Foundation

class DataStorage {
    // MARK: - Propertis
    var registrationsDBURL: URL? {
        guard let documentDictonary = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDictonary.appendingPathComponent("registraionsDB").appendingPathExtension("json")
    }

    // MARK: - Methods
    // JSON file data loader
    func loadRegistraionsDB () -> [Registration]? {
        let decoder = JSONDecoder()

        guard let registrationsDBURL = registrationsDBURL else { return nil }
        guard let encodedRegistraionsDB = try? Data(contentsOf: registrationsDBURL) else { return nil }

        return try? decoder.decode([Registration].self, from: encodedRegistraionsDB)
    }

    // Save data to JSON file
    func saveRegistraionsDB(_ registrations: [Registration]) {
        let encoder = JSONEncoder()

        guard let registrationsDBURL = registrationsDBURL else { return }
        guard let encodedRegistraionsDB = try? encoder.encode(registrations) else { return }

        try? encodedRegistraionsDB.write(to: registrationsDBURL, options: .noFileProtection)
    }
}
