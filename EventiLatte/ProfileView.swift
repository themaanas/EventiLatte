//
//  ProfileView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    var body: some View {
        VStack{
            Image("spooggbob")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            Text("Sauceboy69")
            Text("BigBois University")
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
