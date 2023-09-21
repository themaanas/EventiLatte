//
//  HomeScreenView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import SwiftyJSON


struct HomeScreenView: View {
    @State var events: [Event] = []
    @EnvironmentObject private var userSettings: UserSettings
    var body: some View {
    
        TabView {
            
            BoatingVIew(events: $events)
             .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
             }.environmentObject(userSettings)
            
            DiscoverView()
                 .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                  }
            
            InterestView()
                 .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                  }
            
            ProfileView(events: $events)
                 .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                  }
            
        }
        .onAppear() {
            var ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
            let uid = Auth.auth().currentUser?.uid
            
            var university = ""
            if uid != nil {
                ref.child("users").child(uid!).getData(completion: { error, snapshot1 in
                    events = []
                    university = JSON(snapshot1?.value)["university"].stringValue
                    ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference(withPath: "/unis/" + university + "/events/")
                    var refHandle = ref.getData(completion: { error, snapshot in
                        let data = JSON(snapshot?.value as Any)
                        
                        //                        print(data)
                        for (key,subJson):(String, JSON) in data {
                            let string1 = "\(subJson["startDate"].stringValue)"
                            let string2 = "\(subJson["endDate"].stringValue)"
                            let formatter4 = DateFormatter()
                            formatter4.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let date1 = formatter4.date(from: string1)
                            let date2 = formatter4.date(from: string2)
                            formatter4.dateFormat = "M/d h:mma"
                            var outputString = "\(formatter4.string(from: date1 ?? Date())) - \(formatter4.string(from: date2 ?? Date()))"
                            if (Calendar.current.isDate(date1 ?? Date(), inSameDayAs:date2 ?? Date())) {
                                
                                outputString = "\(formatter4.string(from: date1 ?? Date())) - "
                                formatter4.dateFormat = "h:mma"
                                outputString = outputString + "\(formatter4.string(from: date2 ?? Date()))"
                            }
                            events.append(Event(title: subJson["title"].stringValue,
                                                summary: subJson["summary"].stringValue,
                                                id: key,
                                                startDate: subJson["startDate"].stringValue,
                                                endDate: subJson["endDate"].stringValue,
                                                imageURL: subJson["imageURL"].stringValue,
                                                shortDateString: outputString,
                                                categories: subJson["categories"].arrayValue.map { $0.stringValue},
                                                location: subJson["location"].stringValue))
                        }
                        events = events.sorted {$0.startDate < $1.startDate}
                    })
                    
                });
            }
        }
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
