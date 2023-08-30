//
//  ProfileView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/29/23.
//

import SwiftUI
import Firebase

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ProfileView: View {
    @EnvironmentObject private var userSettings: UserSettings
    var body: some View {
        ZStack{
//            Color(hex: 0x211f24)
            //Color(hex: 0xebdefa)
            Color("colorBackground")
                    .ignoresSafeArea()
            
            VStack{
                
                Image("spooggbob")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Text("BigCheezer")
                    .font(.custom("ArchivoBlack-Regular", size: 46))
                    .foregroundColor(Color(hex: 0x5F11B7))
//                    .opacity(0.87)
                Text("Cheezeton University")
                    .font(.custom("ArchivoBlack-Regular", size: 23))
                    .foregroundColor(Color(hex: 0x5F11B7))
//                    .opacity(0.87)
                
                
                /* Code to later uncomment
                 Pulls users name and school from firebase*/
                //Text(userSettings.name)
                //Text(userSettings.university)
                HStack{
                    Text("1028")
                        .font(.custom("ArchivoBlack-Regular", size: 18))
                        .foregroundColor(.white)
                    Text("Following")
                        .font(.custom("ArchivoBlack-Regular", size: 18))
                        .foregroundColor(.white)
                    Text("820")
                        .font(.custom("ArchivoBlack-Regular", size: 18))
                        .foregroundColor(.white)
                    Text("Followers")
                        .font(.custom("ArchivoBlack-Regular", size: 18))
                        .foregroundColor(.white)
                }
                Button(action: {
                    try? Auth.auth().signOut()
                }) {
                    Text("sign out")
                }
            }
        }
        
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
