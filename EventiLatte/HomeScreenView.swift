//
//  HomeScreenView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        ExecuteCode {
            print(userSettings.university)
        }
        TabView {
            Text("Home screeen stuff here")
             .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
              }
            DiscoverView()
                 .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                  }
            Text("NOTIFS stuff ")
                 .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                  }
            ProfileView()
                 .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                  }
            
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
