//
//  SearchView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 9/2/23.
//

import SwiftUI

extension String {
    func contains(_ strings: [String]) -> Bool {
        strings.contains { contains($0) }
    }
}

struct SearchView: View {
    @Binding var events: [Event]
    @State var articles: [Event] = []
    @State var categoriesToFilterBy: [String] = []
    @State private var searchText = ""
    @State var shouldPresentSheet = false
    
    var body: some View {
        NavigationView {
//            EmptyView()
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.purple).font(Font.system(size: 16))
                        TextField("Search", text: $searchText)
//                            .font(Font.system(size: 21))
                            .foregroundColor(Color("colorFontSecondary"))
                    }
                .padding(15)
                    .background(Color("colorBackgroundSecondary"))
                    .cornerRadius(10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                ScrollView(.horizontal) {
                    LazyHStack {
                        Button("Categories") {
                            print("jhi")
                            shouldPresentSheet.toggle()
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .font(Font.system(size:12))
                        .foregroundColor(Color("colorFont"))
                        .frame(height:30)
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .sheet(isPresented: $shouldPresentSheet) {
                            print("Sheet dismissed!")
                        } content: {
                            CategoriesSelectView(categoriesToFilterBy: $categoriesToFilterBy, events: $events)
                                .presentationDetents([.medium])
                        }
                    }
                    .frame(height: 50)
                }
                .padding(15)
                .frame(height: 50)
                    .background(Color("colorBackgroundSecondary"))
                    .cornerRadius(10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    
                ScrollView {
                    LazyVStack {
                        ForEach($articles) { $article in
                            HomeEventLinkView(event: $article)
                        }
                    }
                }
            }
            .padding(.top, 20)
            .background(Color("colorBackground"))
            .onAppear() {
                articles = events
                print($articles.wrappedValue.count)
                print("HIIIIIII")
                if $categoriesToFilterBy.wrappedValue.count > 0 {
                    print("\(Array(["Athletics", "Goob", "Geeb"]))".contains($categoriesToFilterBy.wrappedValue))
                    
                    articles = $articles.wrappedValue.filter {"\(Array($0.categories))".contains($categoriesToFilterBy.wrappedValue)}
                    print($articles.wrappedValue.count)
                }
    //                articles = events.compactMap { $0.first }.filter { $0.lowercased().contains(searchText.lowercased()) }

                
                
            }
            
    //        .frame(height: 500)
            .onChange(of: [searchText, "\(categoriesToFilterBy)"]) { searchText in
                articles = events
                print($articles.wrappedValue.count)
                print("HIIIIIII")
                if $categoriesToFilterBy.wrappedValue.count > 0 {
                    print("\(Array(["Athletics", "Goob", "Geeb"]))".contains($categoriesToFilterBy.wrappedValue))
                    
                    articles = $articles.wrappedValue.filter {"\(Array($0.categories))".contains($categoriesToFilterBy.wrappedValue)}
                    print($articles.wrappedValue.count)
                }
                if !searchText[0].isEmpty {
                    print("oopt")
                    articles = $articles.wrappedValue.filter { $0.title.lowercased().contains(searchText[0].lowercased()) }
                    
    //                articles = events.compactMap { $0.first }.filter { $0.lowercased().contains(searchText.lowercased()) }

                }
                print($articles.wrappedValue.count)
                
            }
//            .onChange(of: categoriesToFilterBy) { categories in
//                if $categoriesToFilterBy.wrappedValue.count > 0 {
//                    print(articles.count)
//                    articles = $articles.wrappedValue.filter {$0.categories.contains($categoriesToFilterBy.wrappedValue)}
//                }
//            }
//            .padding(.top, 50)
//            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
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
        .background(Color("colorBackground"))
        
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
