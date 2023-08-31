//
//  DiscoverView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/29/23.
//

import SwiftUI
import FeedKit

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct DiscoverView: View {
    @State var events: [[String]] = []
    @State private var searchText = ""
    
    @Environment(\.isSearching) var isSearching
    @State var articles: [String] = []
    var body: some View {
        
        ZStack {
            Color("colorBackground")
                    .ignoresSafeArea()
            VStack {
                
                
                    
                
                DiscoverContentView(events: $events, articles: $articles)
                    .searchable(text: $searchText)
                    .onChange(of: searchText) { searchText in
                    if !searchText.isEmpty {
                        articles = events.compactMap { $0.first }.filter { $0.lowercased().contains(searchText.lowercased()) }
                        
                    } else {
                        articles = []
                    }
                    }.searchable(text: $searchText)
                
                
                
            }
        }
        
    }
}
struct DiscoverContentView: View {
    @Environment(\.isSearching) private var isSearching
    @Binding var events: [[String]]
    @Binding var articles: [String]
    @State private var searchIsActive = false
    var body: some View {
        NavigationView {
            EmptyView()
            if $searchIsActive.wrappedValue {
                List {
                    ForEach($articles.wrappedValue, id: \.self) { article in
                        Text(article)
                    }
                    
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
            }
        }
        .padding(10)
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
            if $events.count < 1 {
                let feedURL = URL(string: "https://rutgers.campuslabs.com/engage/events.rss")!
                let parser = FeedParser(URL: feedURL)
                let result = parser.parse()
                switch result {
                case .success(let feed):
                    
                    // Grab the parsed feed directly as an optional rss, atom or json feed object
                    print(feed.rssFeed?.title)
                    print(feed.rssFeed?.items?.count)
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
            
        }.isHidden($searchIsActive.wrappedValue)
        .onChange(of: isSearching) { newValue in
            searchIsActive = newValue
                print(searchIsActive)
            }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
