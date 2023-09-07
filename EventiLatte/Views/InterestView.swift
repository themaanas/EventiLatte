//
//  InterestView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 9/7/23.
//

import SwiftUI

struct InterestView: View {
    
    let items = [ Item(title: "Test", image: "spooggbob")]
    let spacing: CGFloat = 10
    
    var body: some View {
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: spacing), count: 3)
        
        ScrollView{
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(items) { item in
                    ItemView(item: item)
                        .frame(height: 100)
                        
                }
            }.padding(.horizontal)
            
        }.background(Color.white)
    }
}

struct ItemView: View{
    
    let item: Item
    var body: some View{
        GeometryReader{ reader in
            VStack(spacing: 5){
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                Text(item.title)
            }.frame(width: reader.size.width, height: reader.size.height)
        }.frame(height: 150)
            .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
    
}

struct Item: Identifiable {
    let id = UUID()
    
    let title: String
    let image: String
    
    
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}
