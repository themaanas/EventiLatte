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
import SwiftyJSON

var unis: [String] = []
class UserSettings: ObservableObject {

    @Published var name: String
    @Published var email: String
    @Published var university: String
    @Published var interests: [String]
    @Published var savedEvents: [String]
    @Published var parsedSavedEvents: [Date: [String]]

    init() {
        
        let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
        let uid = Auth.auth().currentUser?.uid
        self.name = ""
        self.email = ""
        self.university = ""
        self.interests = []
        self.savedEvents = []
        self.parsedSavedEvents = [:]
        var tempEvents: [Date: [String]] = [:]
        
        ref.child("users").child(uid!).observe(DataEventType.value, with:  { snapshot in
            
            if let value = snapshot.value as? [String: Any] {
                self.name = value["name"] as? String ?? ""
                self.email = value["email"] as? String ?? ""
                self.university = value["university"] as? String ?? ""
                self.interests = JSON(value)["interests"].arrayValue.map { $0.stringValue}
                ref.child("unis").child(self.university).child("events").getData { error, snapshot1 in
                    
                    self.savedEvents = JSON(value)["savedEvents"].arrayValue.map { $0.stringValue}
                    var eventData = JSON(snapshot1?.value)
//                    print(eventData["-NdDHvH9lA_BdjF95QNx"])
                    for event in self.savedEvents {
                        let string1 = "\(eventData[event]["startDate"].stringValue)"
                        let formatter4 = DateFormatter()
                        formatter4.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let date1 = formatter4.date(from: string1)
                        let cal = Calendar(identifier: .gregorian)
                        print(cal.startOfDay(for: date1 ?? Date()))
                        var eventsForDay = tempEvents[cal.startOfDay(for: date1 ?? Date())] ?? []
                        eventsForDay.append(event)
                        tempEvents[cal.startOfDay(for: date1 ?? Date())] = Array(Set(eventsForDay))
                        print(eventsForDay)
                        print(event)
                    }
                    self.parsedSavedEvents = tempEvents.sorted(by: {$0.0 < $1.0}).reduce(into: [:]) { $0[$1.0] = $1.1 }
//                    print(parsedSavedEvents)
                }
                
                
            }
//            print(name, email, university)
//            return UserSettings(name: name, email: email, university: university)
            
        });
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
    @StateObject var userSettings = UserSettings()
    
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
//        userSettings = initUserVars()
        FirebaseApp.configure()
        unis = readCSV(inputFile: "us_universities.csv")
        print(unis.count)
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
                    .environmentObject(userSettings)
            }
                
            
            
        }
    }
//    func initUserVars() -> UserSettings {
//
//
//        var name = ""
//        var email = ""
//        var university = ""
//        var interests: [String] = []
//        var savedEvents: [String] = []
//        var parsedSavedEvents: [Date: [String]] = [:]
//
//
////        print(parsedSavedEvents.sorted(by: {$0.0 < $1.0}))
////        print(name, email, university)
//        return UserSettings(name: name, email: email, university: university, interests: interests, savedEvents: savedEvents, parsedSavedEvents: parsedSavedEvents)
//    }
}
