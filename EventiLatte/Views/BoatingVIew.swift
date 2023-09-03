//
//  BoatingVIew.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/30/23.
//

import SwiftUI

struct BoatingVIew: View {
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
                Text("Today")
                    .font(.custom("ArchivoBlack-Regular", size: 32))
                    .padding(.leading, 10)
                List{
                    HStack(){
                        Text("Events")
                            .font(.custom("ArchivoBlack-Regular", size: 46))
                        
                        
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
