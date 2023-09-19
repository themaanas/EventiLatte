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
import SwiftyJSON
import CachedAsyncImage

struct EventPageView: View {
    @Binding var article: Event
    @State var startDate: String = ""
    @State var endDate: String = ""
    @EnvironmentObject private var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var events: [Event] = []
    var body: some View {
        
        ScrollView {
            GeometryReader { geometry in
                VStack {
                    
                    CachedAsyncImage(url: URL(string: "\(article.imageURL)")){ image in
                        //                                                        Color.clear
                        ZStack {
                            image.resizable().scaledToFill()
                            
                        }.frame(width: geometry.size.width, height: 150)
                        
                    } placeholder: {
                        ProgressView()
                    }.frame(width: geometry.size.width, height: 150).padding(.top, 10).padding(.bottom, 30)
                        
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
                        .padding(.bottom, 30)
                    
                    Text("\(article.summary)".replacingOccurrences(of: "*n", with: "\n"))
                        .frame(width: geometry.size.width)
                        .frame(maxHeight: .infinity)
                        .padding(.top, 10)
                    
                }
            }
            
        }.navigationTitle(article.title)
            .toolbar {
                
                Button(action: {
                    let uid = Auth.auth().currentUser?.uid
                    let university = userSettings.university
                    
                    let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference().child("users").child(uid!).child("savedEvents")
                    
                    var refHandle = ref.observeSingleEvent(of: .value, with: { snapshot in
                        var data = JSON(snapshot.value as Any).arrayValue.map { $0.stringValue}
                        data.append(article.id)
                        ref.setValue(data)
                        
                        
                        self.presentationMode.wrappedValue.dismiss()
                    })
                })  {
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(Color.purple)
                }
            }
                    
    }
    
    //struct EventPageView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        EventPageView()
    //    }
    //}
}
