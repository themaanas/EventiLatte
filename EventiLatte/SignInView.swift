//
//  SignInView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/28/23.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            Text("Signin@")
            
        }
        

//        SignInWithAppleButton(.signIn) { request in
//            request.reqestedScopes = [.fullName, .email]
//        } onCompletion: { result in
//            switch result {
//                case .success(let authResults):
//                    print("Authorisation successful")
//                case .error(let error):
//                    print("Authorisation failed: \(error.localizedDescription)")
//            }
//        }
        // black button
        
        // white button
//        .signInWithAppleButtonStyle(.white)
//        // white with border
//        .signInWithAppleButtonStyle(.whiteOutline)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
