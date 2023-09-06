//
//  BoatingVIew.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/30/23.
//

import SwiftUI

struct BoatingVIew: View {
    @EnvironmentObject private var userSettings: UserSettings
    @State var DateString = Date.now.formatted(.dateTime.month().day().year())
    let notify = NotificationHandler()
    var body: some View {
        ZStack{
            Color("colorBackground")
                .ignoresSafeArea()
            VStack(alignment: .leading){
                Text("\(DateString)")
                    .font(.custom("ArchivoBlack-Regular", size: 24))
                    .padding(.leading, 10)
                    .foregroundColor(Color("colorFont"))
                Text("Today")
                    .font(.custom("ArchivoBlack-Regular", size: 32))
                    .padding(.leading, 10)
                    .foregroundColor(Color("colorFont"))
                List{
                    VStack(){
                        Text("Saved Events")
                            .font(.custom("ArchivoBlack-Regular", size: 40))
                        
                        
                        
                        
                    }.listRowSeparator(.hidden)
                        .listRowBackground(Color("colorBackground"))
                    
                }.background(Color("colorBackground"))
                    .scrollContentBackground(.hidden)
            }
        }
    }
}
struct BoatingVIew_Previews: PreviewProvider {
    static var previews: some View {
        BoatingVIew()
    }
}
