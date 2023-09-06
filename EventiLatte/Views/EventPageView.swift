//
//  EventPageView.swift
//  EventiLatte
//
//  Created by Zachary Asis on 8/30/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift


struct EventPageView: View {
    @Binding var article: Event
    @State var startDate: String = ""
    @State var endDate: String = ""
    @EnvironmentObject private var userSettings: UserSettings
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                VStack {
                    Spacer()
                    HStack {
                        VStack {
                            Text("\(article.title)")
                                .padding(.leading)
                                .font(.title)
                                .fontWeight(.black)
                            Text("\($startDate.wrappedValue) - \($endDate.wrappedValue)")
                                .foregroundColor(Color.gray)
                                .onAppear {
                                    //                                    print(article[3])
                                    let string1 = "\(article.startDate)"
                                    let string2 = "\(article.endDate)"
                                    let formatter4 = DateFormatter()
                                    formatter4.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                    let date1 = formatter4.date(from: string1)
                                    let date2 = formatter4.date(from: string2)
                                    formatter4.dateFormat = "M/d h:mma"
                                    startDate = formatter4.string(from: date1!)
                                    endDate = formatter4.string(from: date2!)
                                }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let uid = Auth.auth().currentUser?.uid
                            let university = userSettings.university
                            
                            let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
                            
                            var refHandle = ref.observe(DataEventType.value, with: { snapshot in
                                
                                
                                ref.child("users").child(uid!).setValue(["savedEvents": [article.id]])
                                
                                
                                print("Button Pressed")
                            })
                        })  {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .frame(width:40, height:40)
                                .foregroundColor(Color.purple)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.trailing, 30)
                        }
                    }
                    
                    
                    
                    Spacer()
                    
                    AsyncImage(url: URL(string: "\(article.imageURL)"))
                    
                    Spacer()
                    
                    HStack {
                        Text("\(article.summary)".replacingOccurrences(of: "*n", with: "\n"))
                            .padding()
                        Spacer()
                    }
                }
            }
        }
    }
    
    //struct EventPageView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        EventPageView()
    //    }
    //}
}
