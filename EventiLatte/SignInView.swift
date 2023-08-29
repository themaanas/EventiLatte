//
//  SignInView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/28/23.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginSuccess = false
    var body: some View {
        VStack {
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
            Button("Log In") {
                print("hi")
                register()
            }
            .alert("Message from SwiftUI", isPresented: $loginSuccess) {
                        Button("Success") { }
                    }
            .padding(10)
            .frame(width:150)
            .background(Color(red: 235/255, green: 136/255, blue: 66/255))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding(20)
            
        }
    }
    func register() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                loginSuccess = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
