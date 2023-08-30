//
//  HomeScreenView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI


struct HomeScreenView: View {
    @EnvironmentObject private var userSettings: UserSettings
    @State var DateString = Date.now.formatted(.dateTime.month().day().year())
    var body: some View {
        TabView {
            VStack{
                Text("\(DateString)")
                    .font(.custom("ArchivoBlack-Regular", size: 46))
                Text("Today")
                    .font(.custom("ArchivoBlack-Regular", size: 46))
                
                List{
                    Section{
                        //text()
                    }
                }
                
                
            }
            
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
