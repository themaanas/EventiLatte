//
//  DiscoverView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/29/23.
//

import SwiftUI
import FeedKit

struct DiscoverView: View {
    @State private var events: [[String]] = []
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State var articles: [String] = []
    var body: some View {
        ExecuteCode {
            
        }
        VStack {
            
            ZStack {
                NavigationView {
                    List {
                        ForEach(articles, id: \.self) { article in
                            Text(article)
                        }
                        
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(.plain)
                    
                }.searchable(text: $searchText)
                    .onChange(of: searchText) { searchText in
                        
                        if !searchText.isEmpty {
                            articles = events.compactMap { $0.first }.filter { $0.lowercased().contains(searchText.lowercased()) }
                            
                        } else {
                            articles = []
                        }
                    }
                    .padding(10)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        if $events.count > 0 {
                            ForEach(0...$events.count - 1, id: \.self) { index in
                                Text(String($events[index].first!.wrappedValue))
                                Text("hi")
                                    .onAppear {
                                        print(index)
                                    }
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))
                .onAppear() {
                    print(events)
                    //                    events.removeLast()
                    if events.count < 1 {
                        let feedURL = URL(string: "https://rutgers.campuslabs.com/engage/events.rss")!
                        let parser = FeedParser(URL: feedURL)
                        let result = parser.parse()
                        switch result {
                        case .success(let feed):
                            
                            // Grab the parsed feed directly as an optional rss, atom or json feed object
                            print(feed.rssFeed?.title)
                            if let items = feed.rssFeed?.items {
                                for item in items.prefix(10) {
                                    events.append([(item.title)!, (item.description)!])
                                    print(item)
                                }
                            }
                            
                            
                            
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                }
                
                
                
            }
        }
        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
