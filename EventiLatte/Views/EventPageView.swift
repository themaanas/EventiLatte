//
//  EventPageView.swift
//  EventiLatte
//
//  Created by Zachary Asis on 8/30/23.
//

import SwiftUI

struct EventPageView: View {
    var body: some View {
        
        ScrollView {
            LazyVStack {
                
                VStack {
                    Spacer()
                    HStack {
                        VStack {
                            Text("Event Name Here")
                                .padding(.leading)
                                .font(.title)
                                .fontWeight(.black)
                            Text("Dates and Times Here")
                                .foregroundColor(Color.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("Button Pressed")
                        })  {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .frame(width:40, height:40)
                                .foregroundColor(Color.purple)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.trailing, 30)
                        }
                    }
                }
                
                Spacer()
                
                Text("Image Goes Here")
                
                Spacer()
                
                HStack {
                    Text("Event Description Goes Here")
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

struct EventPageView_Previews: PreviewProvider {
    static var previews: some View {
        EventPageView()
    }
}
