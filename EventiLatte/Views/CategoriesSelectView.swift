//
//  CategoriesSelectView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 9/19/23.
//

import SwiftUI
import WrappingHStack

struct CategoriesSelectView: View {
    @Binding var categoriesToFilterBy: [String]
    @Binding var events: [Event]
    @State var allCategories: [String] = ["Athletics", "Welcome Week"]
    var body: some View {
        ZStack {
            
            ScrollView {
                HStack {
                    Text("Categories")
                        .font(.system(size: 26))
                        .padding(.leading, 10)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(alignment: .leading)
                        .padding(.top, 30)
                    Spacer()
                }
                
                WrappingHStack($allCategories.wrappedValue, id: \.self) { category in
                    Button(category) {
                        if categoriesToFilterBy.contains(category) {
                            categoriesToFilterBy.remove(at: categoriesToFilterBy.firstIndex(of: category) ?? 0)
                        } else {
                            categoriesToFilterBy.append(category)
                        }
                        print(categoriesToFilterBy)
                    }
                    .padding(5)
                    .font(Font.system(size:15))
                    .foregroundColor($categoriesToFilterBy.wrappedValue.contains(category) ? Color.white : Color.purple)
                    .background($categoriesToFilterBy.wrappedValue.contains(category) ? Color.purple : Color.clear)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 5)
                }
                .padding(.leading, 10)
                .onAppear() {
                    allCategories = []
                    for event in events {
                        for cat in event.categories {
                            if !allCategories.contains(cat) {
                                allCategories.append(cat)
                            }
                        }
                    }
                    allCategories.sort()
                    
                }
            }
            
            
        }
        .background(Color("colorBackground"))
    }
}

//struct CategoriesSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesSelectView()
//    }
//}
