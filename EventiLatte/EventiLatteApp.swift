//
//  EventiLatteApp.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/27/23.
//

import SwiftUI
import Firebase
import FirebaseCore

var unis: [String] = []
@main
struct EventiLatteApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State var handle: Any!
    @State var isLoggedIn: Bool = false
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
            if !isLoggedIn {
                ContentView()
                    .onChange(of: scenePhase) { newPhase in
                                    if newPhase == .active {
                                        handle = Auth.auth().addStateDidChangeListener({ auth, user in
                                            if let user = user {
                                              // The user's ID, unique to the Firebase project.
                                              // Do NOT use this value to authenticate with your backend server,
                                              // if you have one. Use getTokenWithCompletion:completion: instead.
                                              let uid = user.uid
                                              let email = user.email
                                                print("\(uid) + \(email)")
                                                isLoggedIn = true
                                            } else {
                                                isLoggedIn = false
                                            }
                                        })
                                    } else if newPhase == .inactive {
                                        print("Inactive")
                                    } else if newPhase == .background {
                                        Auth.auth().removeStateDidChangeListener(handle as! NSObjectProtocol)
                                    }
                                }
            } else {
                HomeScreenView()
            }
                
            
            
        }
    }
}
