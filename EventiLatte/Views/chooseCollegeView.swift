//
//  chooseCollegeView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 9/1/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

struct chooseCollegeView: View {
    @State private var searchingFor = ""
    var body: some View {
        VStack{
            Text("Choose Your School")
            TextField("", text: $searchingFor)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .foregroundColor(.black)
                .textFieldStyle(.plain)
                .placeholder(when: searchingFor.isEmpty) {
                    Text("University/College")
                        .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                        .bold()
                }
                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                .cornerRadius(7)
                .frame(width: 200.0, height: 100.0)
            
            
            List {
                ForEach(results, id: \.self) { uni in
                    Button(uni) {
                        searchingFor = uni
                    }
                }
            }
            .background(Color.black)
            Button("Sign Up") {
                print("hi")
                register()
            }
        }
    }
    var results: [String] {
        if searchingFor.isEmpty {
            return []
        } else {
            
            return Array(unis.filter{ $0.lowercased().contains(searchingFor.lowercased())})
        }
    }
    func register() {
                let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
                let uid = Auth.auth().currentUser?.uid
                
                ref.child("users").child(uid!).setValue(["university": searchingFor])
        
    }
}



struct chooseCollegeView_Previews: PreviewProvider {
    static var previews: some View {
        chooseCollegeView()
    }
}
