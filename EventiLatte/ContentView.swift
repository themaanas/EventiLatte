//
//  ContentView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SignInView()) {
                    Text("Sign In")
                }
                .padding(10)
                .frame(width:150)
                .background(Color(red: 235/255, green: 136/255, blue: 66/255))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(20)
                .padding(.top, 200)
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
