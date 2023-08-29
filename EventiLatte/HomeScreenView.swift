//
//  HomeScreenView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        TabView {
            Text("Home screeen stuff here")
             .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
              }
            Text("FOR SEARCH SCREEN STUFF")
                 .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Search")
                  }
            Text("NOTIFS stuff ")
                 .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                  }
            Text("profilescreen")
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
