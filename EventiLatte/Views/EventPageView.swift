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

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct EventPageView: View {
    @Binding var article: Event
    @State var startDate: String = ""
    @State var endDate: String = ""
    @EnvironmentObject private var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var events: [Event] = []
    @State var scrollOffset: CGFloat = .zero
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Color("colorBackground").ignoresSafeArea()
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 0) {
//                        HStack {
//                            Spacer()
//
//                        }
                        VStack(alignment: .leading, spacing: 0){
    //                        Color.clear
                            CachedAsyncImage(url: URL(string: "\(article.imageURL)")){ image in
                                //                                                        Color.clear
                                ZStack {
                                    image.resizable().scaledToFill()
                                    
                                }.frame(width: geometry.size.width - 30, height: 180).clipShape(RoundedRectangle(cornerRadius: 20))
                                
                            } placeholder: {
                                ProgressView()
                            }
                            .padding(.leading, 0)
                            
                            
                        }.frame(width: geometry.size.width, height: 180)
                            .padding(.top, 20)
                        
                        
                        Text("\(article.title)")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width - 30, height: 100, alignment: .leading)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                            .allowsTightening(true)
                        HStack {
                            Image(systemName: "calendar.circle.fill")
                                .font(.system(size: 25))
                                .frame(width: 50, height: 50)
                                .background(Color("colorBackgroundSecondary"))
                                .foregroundColor(Color("colorFont"))
                                .cornerRadius(10)
                                .padding(.leading, 15)
                            Text("\(article.shortDateString)")
                                .foregroundColor(Color("colorFontSecondary"))
                                .fontWeight(.medium)
                                .padding(.leading, 5)
//                                .padding(.bottom, 30)
                            Spacer()
                        }
                        .frame(width: geometry.size.width)
                        .padding(.bottom, 10)
                        HStack {
                            Image(systemName: "location.circle.fill")
                                .font(.system(size: 25))
                                .frame(width: 50, height: 50)
                                .background(Color("colorBackgroundSecondary"))
                                .foregroundColor(Color("colorFont"))
                                .cornerRadius(10)
                                .padding(.leading, 15)
                            Text("\(article.location)")
                                .foregroundColor(Color(hex: 0xd0c3eb))
                                .fontWeight(.medium)
                                .padding(.leading, 5)
//                                .padding(.bottom, 30)
                            Spacer()
                        }
                        .frame(width: geometry.size.width)
                        .padding(.bottom, 30)
//                        CachedAsyncImage(url: URL(string: "\(article.imageURL)")){ image in
//                            //                                                        Color.clear
//                            image.resizable().scaledToFill()
////                            ZStack {
////
////
////                            }.frame(width: geometry.size.width, height: 150)
//
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(width: geometry.size.width, height: 150)
//                        .padding(.top, 10)
//                        .padding(.bottom, 30)
                        
                        Divider()
                            .frame(width: geometry.size.width - 30, height: 3)
                            .padding(.leading, 15)
                        
                        Text("About this")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width - 15, height: 80, alignment: .leading)
                            .padding(.leading, 15)
                        
                        Text("\(article.summary)".replacingOccurrences(of: "*n", with: "\n"))
                            .frame(width: geometry.size.width - 30)
                            .frame(maxHeight: .infinity)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                            .foregroundColor(Color("colorFontSecondary"))
//                            .padding([.top, .leading, .trailing], 15)
                            
//                            .padding(.trailing, 15)
                         
                    }
                    .padding(.top, 1)
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                            value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { scrollOffset = $0 }
                    
//                    GeometryReader { proxy in
//                                    let offset = proxy.frame(in: .named("scroll")).minY
//                                    Color.clear.preference(key: ViewOffsetKey.self, value: offset)
//                                }
                }
                .coordinateSpace(name: "scroll")
//                .onPreferenceChange(ViewOffsetKey.self) { value in
//                    scrollOffset = value
//                }
                .padding(.top, 1)
                .frame(width: geometry.size.width)
                
                
//                .background {
//                    Color.red
//                }
            }
//            .navigationTitle(article.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) { // <3>
                    VStack {
                        Text($scrollOffset.wrappedValue > 10 ? "\(article.title)": "").frame(alignment: .center).multilineTextAlignment(.center)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) { // <3>
                    Button(action: {
                        if $userSettings.savedEvents.wrappedValue.contains(article.id) {
                            print("remvoing")
                            let uid = Auth.auth().currentUser?.uid
                            
                            let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference().child("users").child(uid!).child("savedEvents")
                            var refHandle = ref.observeSingleEvent(of: .value, with: { snapshot in
                                var data = JSON(snapshot.value as Any).arrayValue.map { $0.stringValue}
                                data = data.filter { $0 != article.id }
                                ref.setValue(data)
//                                self.presentationMode.wrappedValue.dismiss()
                            })
                        } else {
                            let uid = Auth.auth().currentUser?.uid
                            
                            let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference().child("users").child(uid!).child("savedEvents")
                            
                            var refHandle = ref.observeSingleEvent(of: .value, with: { snapshot in
                                var data = JSON(snapshot.value as Any).arrayValue.map { $0.stringValue}
                                data.append(article.id)
                                ref.setValue(data)
//                                self.presentationMode.wrappedValue.dismiss()
                            })
                        }
                        
                    })  {
                        if $userSettings.savedEvents.wrappedValue.contains(article.id) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.purple)
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(Color.purple)
                        }
                        
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
