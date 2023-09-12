//
//  EventLinkView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 9/12/23.
//

import SwiftUI
import CachedAsyncImage

struct EventLinkView: View {
    @Binding var event: Event
    var body: some View {
        NavigationLink(destination: EventPageView(article: $event)) {
            
            ZStack {
                ZStack(alignment: .top){
                    Color.clear
                    CachedAsyncImage(url: URL(string: "\(event.imageURL)")){ image in
                        //                                                        Color.clear
                        ZStack {
                            image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 20))
                            
                        }.frame(width: 250, height: 150)
                        
                    } placeholder: {
                        ProgressView()
                    }.shadow(color: Color.black.opacity(0.7), radius: 10, y: 0)
                }
                ZStack(alignment: .bottomLeading) {
                    Color.clear
                    VStack(spacing:0) {
                        Text(String(event.title))
                            .padding(.trailing, 50)
                            .frame(width: 250, height: 10, alignment: .leading)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        Text(String(event.shortDateString))
                            .frame(width: 250, height: 10, alignment: .leading)
                            .font(.system(size: 10))
                            .foregroundColor(Color(hex: 0xd0c3eb))
                            .padding(.bottom, 10)
                    }.frame(alignment: .leading).padding(.leading, 25)
                    
                }
                
                
                
            }
            .frame(width: 250, height: 200)
            .background(Color("colorBackgroundSecondary"))
            .cornerRadius(20)
        }
    }
}

//struct EventLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventLinkView()
//    }
//}
