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
    @Binding var events: [Event]
    @EnvironmentObject private var userSettings: UserSettings
    @State var shouldPresentSheet = false
    var body: some View {
        NavigationView {
            ZStack{
    //            Color(hex: 0x211f24)
                //Color(hex: 0xebdefa)
                Color("colorBackground")
                        .ignoresSafeArea()
                
                GeometryReader { geometry in
                    VStack(alignment: .center){
                        
                        List{
                            
                            HStack(spacing: 0) {
                                Text("\(userSettings.university)")
                                    .foregroundColor(Color("colorFontSecondary"))
                                    .padding(.leading, 15)
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .multilineTextAlignment(.leading)
//                                    .padding(.leading, 20)
//                                    .background(.blue)
                                
                            }
//                            .padding(0)
                            .padding(.bottom, 30)
                            .listRowBackground(Color("colorBackground"))
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
//                            .background(.blue)
                            HStack{
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 25))
                                    .frame(width: 50, height: 50)
                                    .background(Color("colorBackgroundSecondary"))
                                    .foregroundColor(Color("colorFont"))
                                    .cornerRadius(10)
                                Text("Edit profile")
                                    .foregroundColor(Color("colorFontSecondary"))
                                    .fontWeight(.medium)
                                    .padding(.leading, 5)
                            }.listRowBackground(Color("colorBackground"))
                                .listRowSeparator(.hidden)
                            HStack{
                                Image(systemName: "star.circle.fill")
                                    .font(.system(size: 25))
                                    .frame(width: 50, height: 50)
                                    .background(Color("colorBackgroundSecondary"))
                                    .foregroundColor(Color("colorFont"))
                                    .cornerRadius(10)
                                Button(action: {
                                    shouldPresentSheet.toggle()
                                    
                                }) {
                                    Text("Change interests")
                                        .foregroundColor(Color("colorFontSecondary"))
                                        .fontWeight(.medium)
                                        .padding(.leading, 5)
                                }
                                .sheet(isPresented: $shouldPresentSheet) {
                                    print("Sheet dismissed!")
                                } content: {
                                    CategoriesSelectView(categoriesToFilterBy: $userSettings.interests, events: $events)
                                        .presentationDetents([.medium])
                                }
                                .onChange(of: $userSettings.interests.wrappedValue) { newValue in
                                    let uid = Auth.auth().currentUser?.uid
                                    
                                    let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference().child("users").child(uid!).child("interests")
                                    ref.setValue($userSettings.interests.wrappedValue)
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color("colorBackground"))
                            HStack{
                                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                    .font(.system(size: 20))
                                    .frame(width: 50, height: 50)
                                    .background(Color("colorBackgroundSecondary"))
                                    .foregroundColor(Color("colorFont"))
                                    .cornerRadius(10)
                                Button(action: {
                                    try? Auth.auth().signOut()
                                }) {
                                    Text("Sign Out")
                                        .foregroundColor(Color("colorFontSecondary"))
                                        .fontWeight(.medium)
                                        .padding(.leading, 5)
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color("colorBackground"))
                        }
                        .listStyle(PlainListStyle())
//                        .background(.red)
//                        .background(Color("colorBackground"))
                        .scrollContentBackground(.hidden)
                        
                    }
                    .navigationTitle("\(userSettings.name)")
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


//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
