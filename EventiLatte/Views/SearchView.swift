//
//  SearchView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 9/2/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var events: [[String]]
    @State var articles: [[String]] = []
    @State private var searchText = ""
    var body: some View {
        NavigationView {
//            EmptyView()
            List($articles, id: \.self) { article in
                NavigationLink(destination: EventPageView(article: article)) {
                    Text(article[0].wrappedValue)
                }
            }
//            List($articles.wrappedValue, id: \.self) { article in
//
//                NavigationLink(destination: EventPageView(article: article)) {
//                    Text(article)
//                }
////                .listRowSeparator(.hidden)
//
//            }
//            .navigationDestination(for: String.self, destination: EventPageView.init)
//                    .isHidden(!$searchIsActive.wrappedValue)
//            .frame(height: 500)
//            .listStyle(.plain)
//            .background(.red)
//                .frame(maxHeight: .infinity)

        }
//        .frame(height: 500)
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { searchText in
            if !searchText.isEmpty {
                articles = events.filter { (dataArray:[String]) -> Bool in
                    return dataArray.filter({ (string) -> Bool in
                        return string.contains(searchText.lowercased())
                    }).count > 0
                }
//                articles = events.compactMap { $0.first }.filter { $0.lowercased().contains(searchText.lowercased()) }

            } else {
                articles = []
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
