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
        NavigationView {
            ZStack{
    //            Color(hex: 0x211f24)
                //Color(hex: 0xebdefa)
                Color("colorBackground")
                        .ignoresSafeArea()
                
                    
                    
                    VStack(alignment: .center){
                        
                        List{
                            HStack{
                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width:32, height: 32)
                                    .clipShape(Circle())
                                Text("Edit Profile")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("colorFont"))
                            }.listRowBackground(Color("colorBackground"))
                                .listRowSeparator(.hidden)
                            HStack{
                                Image(systemName: "door.right.hand.open")
                                    .resizable()
                                    .frame(width:32, height: 32)
                                    .clipShape(Circle())
                                Button(action: {
                                    try? Auth.auth().signOut()
                                }) {
                                    Text("Sign Out")
                                        .foregroundColor(Color("colorFont"))
                                        .font(.system(size: 20))
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color("colorBackground"))
                        }
                        .background(Color("colorBackground"))
                        .scrollContentBackground(.hidden)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                VStack {
                                    Text("\(userSettings.name)").font(.largeTitle).bold()
                                    Text("\(userSettings.university)").font(.subheadline)
                                }
                            }
                        }
                    }

                    
                    //.background(.red)
                
                
                    
                    
                        
                                        
                        
                        

                    
                    
                    
                    /* Code to later uncomment
                     Pulls users name and school from firebase*/
                    //Text(userSettings.name)
                    //Text(userSettings.university)

            }
        }
        
        
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
