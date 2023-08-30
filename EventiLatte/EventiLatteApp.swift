//
//  EventiLatteApp.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/27/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseDatabase

var unis: [String] = []
class UserSettings: ObservableObject {

    @Published var name: String
    @Published var email: String
    @Published var university: String

    init(name: String, email: String, university: String) {
        self.name = name
        self.email = email
        self.university = university
    }
}
struct ExecuteCode : View {
    init( _ codeToExec: () -> () ) {
        codeToExec()
    }
    
    var body: some View {
        EmptyView()
    }
}
@main
struct EventiLatteApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State var handle: Any!
    @State var isLoggedIn: Bool = false
    @State var name = ""
    @State var email = ""
    @State var university = ""
    
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
            if !$isLoggedIn.wrappedValue {
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
                    .environmentObject(initUserVars())
            }
                
            
            
        }
    }
    func initUserVars() -> UserSettings {
        let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
        let uid = Auth.auth().currentUser?.uid
        
        
        ref.child("users").child(uid!).getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            
            if let value = snapshot?.value as? [String: Any] {
                name = value["name"] as? String ?? ""
                email = value["email"] as? String ?? ""
                university = value["university"] as? String ?? ""
            }
//            print(name, email, university)
//            return UserSettings(name: name, email: email, university: university)
            
        });
//        print(name, email, university)
        return UserSettings(name: name, email: email, university: university)
    }
}
