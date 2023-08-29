//
//  EventiLatteApp.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/27/23.
//

import SwiftUI
import Firebase

var unis: [String] = []
@main
struct EventiLatteApp: App {
    func readCSV(inputFile: String) -> [String] {
            if let filepath = Bundle.main.path(forResource: inputFile, ofType: nil) {
                do {
                    let fileContent = try String(contentsOfFile: filepath)
                    let lines = fileContent.components(separatedBy: "\n")
                    var results: [String] = []
                    lines.dropFirst().forEach { line in
                        let data = line.components(separatedBy: ",h")
                        if data.count == 2 {
                            results.append(data[0])
                        }
                    }
                    return results
                } catch {
                    print("error: \(error)") // to do deal with errors
                }
            } else {
                print("\(inputFile) could not be found")
            }
            return []
        }
    init() {
        FirebaseApp.configure()
        unis = readCSV(inputFile: "us_universities.csv")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
