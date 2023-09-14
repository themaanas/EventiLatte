//
//  EventLinkView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 9/12/23.
//

import SwiftUI
import CachedAsyncImage

struct HomeEventLinkView: View {
    @Binding var event: Event
    var body: some View {
        NavigationLink(destination: EventPageView(article: $event)) {
            GeometryReader {geometry in
                HStack(spacing:0) {
                    VStack(alignment: .leading){
//                        Color.clear
                        CachedAsyncImage(url: URL(string: "\(event.imageURL)")){ image in
                            //                                                        Color.clear
                            ZStack {
                                image.resizable().scaledToFill()
                                
                            }.frame(width: geometry.size.width * 0.27, height: geometry.size.width * 0.27).clipShape(RoundedRectangle(cornerRadius: 6))
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }.frame(width: geometry.size.width * 0.3, height: 130).padding(.leading, 5)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Color.clear
                        Text(String(event.shortDateString))
                            .padding(.leading, 5)
                            .frame(width: geometry.size.width * 0.6, height: 10, alignment: .leading)
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: 0xd0c3eb))
                            .padding(.bottom, 10)
                        Text(String(event.title))
                            .padding(.leading, 5)
                            .frame(width: geometry.size.width * 0.6, height: 20, alignment: .leading)
//                            .background(.red)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        Text(String(event.summary))
                            .padding(.leading, 5)
                            .frame(width: geometry.size.width * 0.6, height: 10, alignment: .leading)
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: 0xd0c3eb))
//                            .padding(.bottom, 10)
                        
                        Color.clear
                    }.frame(width: geometry.size.width * 0.7, height: 130)
                    
                    
                    
                }
                .frame(width: geometry.size.width, height: 130)
                .background(Color("colorBackgroundSecondary"))
            }
        }.frame(height: 130)
    }
}
//
//struct HomeEventLinkView_Previews: PreviewProvider {
//    @State var event: Event = Event(title: "Hi", summary: "Hi", id: "hi", startDate: "hi", endDate: "hi", imageURL: "nil", shortDateString: "hi", categories: ["hi"])
//    static var previews: some View {
//        HomeEventLinkView(event: $event)
//    }
//}
