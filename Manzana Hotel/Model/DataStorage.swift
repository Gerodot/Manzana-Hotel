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
        print(#line, #function, registrationsDBURL ?? "URL Not available")
        guard let registrationsDBURL = registrationsDBURL else {return nil}
        guard let encodedRegistraionsDB = try? Data(contentsOf: registrationsDBURL) else { return nil }

        let decoder = JSONDecoder()
        return try? decoder.decode([Registration].self, from: encodedRegistraionsDB)
    }

    // Save data to JSON file
    func saveRegistraionsDB(_ registrations: [Registration]) {
        print(#line, #function, registrationsDBURL ?? "URL Not available")
        guard let archiveURL = registrationsDBURL else {return}

        let encoder = JSONEncoder()
        guard let encodedEmoji = try? encoder.encode(registrations) else {return}

        try? encodedEmoji.write(to: archiveURL, options: .noFileProtection)
    }
}
