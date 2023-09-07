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
        }.onAppear() {
            if let past = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {

                    let df = DateFormatter()
                    

                    df.dateStyle = .short
                df.dateFormat = "EEEE, MMM d"
//                    df.timeStyle = .short
                    df.doesRelativeDateFormatting = true
//                past.formatted(.relative(presentation: .numeric)) // "in 1 week"
                print(format(date: past)) // "next week"


                
            }
        }
    }
    
    func format(date: Date) -> String {
          let calendar = Calendar.current
      if calendar.isDateInToday(date){
              let df = DateFormatter()
              df.dateStyle = .short
              df.timeStyle = .none
              df.doesRelativeDateFormatting = true
          return df.string(from: date)
          
          }
    else if calendar.isDateInYesterday(date){
          let df = DateFormatter()
              df.dateStyle = .short
              df.timeStyle = .none
              df.doesRelativeDateFormatting = true
          return df.string(from: date)
      }
      else if calendar.isDateInTomorrow(date){
          let df = DateFormatter()
              df.dateStyle = .short
              df.timeStyle = .none
              df.doesRelativeDateFormatting = true
          return df.string(from: date)
          } else {
              let df = DateFormatter()
              df.dateFormat = "EEEE, MMM d"
          return df.string(from: date)
      }
      
      }
}
//struct BoatingVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        BoatingVIew()
//    }
//}
