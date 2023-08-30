//
//  SignUpView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/28/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

struct SignUpView: View {
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var searchingFor = ""
//    @State var unis: [String] = []
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                TextField("", text: $name)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: name.isEmpty) {
                        Text("Name")
                            .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                            .bold()
                    }
                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                    .cornerRadius(7)
                    .frame(width: 200.0, height: 100.0)
                    .padding(.bottom, -50)
                TextField("", text: $email)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                            .bold()
                    }
                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                    .cornerRadius(7)
                    .frame(width: 200.0, height: 100.0)
                    .padding(.bottom, -50)
                    
                    
                SecureField("", text: $password)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(Color(red: 200/255, green: 200/255, blue: 200/255))
                            .bold()
                    }
                    .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                    .cornerRadius(7)
                    .frame(width: 200.0, height: 100.0)
                    .padding(.bottom, -20)
                
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
                .background(Color.white)
                .frame(width: 400, height: 200)
                
                Button("Sign Up") {
                    print("hi")
                    register()
                }
                .padding(10)
                .frame(width:150)
                .background(Color(red: 235/255, green: 136/255, blue: 66/255))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(20)
                
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
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
                let uid = Auth.auth().currentUser?.uid
                
                ref.child("users").child(uid!).setValue(["email": email, "name": name, "university": searchingFor])
            }
        }
    }
    
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0).padding(10)
            self
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
