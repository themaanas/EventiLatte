//
//  SignUpView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/28/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
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
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
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
