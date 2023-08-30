//
//  ProfileView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject private var userSettings: UserSettings
    var body: some View {
        VStack{
            Image("spooggbob")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            Text("BigCheezer")
            Text("Cheezeton University")
            
            
            /* Code to later uncomment
                Pulls users name and school from firebase*/
            //Text(userSettings.name)
            //Text(userSettings.university)
            HStack{
                Text("1028")
                Text("Following")
                Text("820")
                Text("Followers")
            }
            Button(action: {
                       try? Auth.auth().signOut()
                    }) {
                        Text("sign out")
                    }
        }
    
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
