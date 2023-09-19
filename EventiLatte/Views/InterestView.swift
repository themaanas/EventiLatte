//
//  InterestView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 9/7/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import SwiftyJSON

struct InterestView: View {
    @State private var isButtonPressed = false
    @State private var buttonColor = Color.blue
    private let gridItemLayout = [GridItem(.adaptive(minimum: 130))]
    var body: some View{
        GeometryReader { geometry in
        //let uid = Auth.auth().currentUser?.uid
        //let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference().child("users").child(uid!).child("interests")
        //var interestArray: [String] = [""]
            NavigationView(){
                
                ZStack{
                    Color("colorBackground")
                        .ignoresSafeArea()
                    VStack{
                        Text("Choose 5 Interests")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .border(.blue)
                            .padding()

                        LazyVGrid(columns: gridItemLayout, spacing: 20) {
                            ForEach((0...11), id: \.self) {_ in
                                ZStack{
                                    Rectangle()
                                        .frame(width:130, height: 130)
                                        .foregroundColor(Color.blue)
                                        .cornerRadius(30)
                                    Button("Sports"){
                                        print("hi")
                                    }.foregroundColor(.black)
                                        .padding()
                                        .background(buttonColor)
                                        .frame(width:130, height:130)
                                        .animation(Animation.easeInOut(duration: 1.5), value: 50)
                                        .border(Color.red)
                                    
                                }
                            }
                        }
                                
                        

                                
//                                    .frame(width: geometry.size.width/3, height: 100)
//
//
//                                Button(action: {
//
//                                    self.isButtonPressed.toggle()
//                                    self.buttonColor =  self.isButtonPressed ? Color.white : Color.blue
//
//
//                                }) {
//                                    Text("Outdooor")
//                                        .foregroundColor(.black)
//                                        .padding()
//                                        .background(buttonColor)
//                                        .cornerRadius(10)
//                                }.animation(Animation.easeInOut(duration: 1.0), value: 50)
//
//                            }
//                        }
                                //                            Button(action: {
                                //                                var refHandle = ref.observeSingleEvent(of: .value, with: { snapshot in
                                //                                    var data = JSON(snapshot.value as Any).arrayValue.map { $0.stringValue}
                                //                                    data.append(contentsOf: interestArray)
                                //                                    ref.setValue(data)
                                //                                })
                                //
                                //                            })  {
                                //                                    Text("NextView")
                                //                                }
                                
                                
                          
                        
                        Spacer()
                    }
                    .navigationBarTitle(Text("Interests"))
                    .toolbar {
                        NavigationLink(destination: {

                                     HomeScreenView()

                                 }, label: {

                                     Text("Continue")

                                         .foregroundColor(.black)
                                         .padding(.vertical, 5)
                                         .padding(.horizontal, 10)
                                         
                                         .cornerRadius(10)

                                 })


                    }
                }
                
            }
        }
    }
}


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}
