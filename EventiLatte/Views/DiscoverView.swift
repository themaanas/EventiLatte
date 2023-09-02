//
//  DiscoverView.swift
//  EventiLatte
//
//  Created by Maanas Manoj on 8/29/23.
//

import SwiftUI
import FeedKit
import Firebase
import FirebaseDatabase
import SwiftyJSON

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

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

struct Event: Identifiable {
    
    @State var title: String
    @State var summary: String
    @State var id: String
    @State var startDate: String
    @State var endDate: String
    @State var imageURL: String
    @State var categories: [String]
}

struct DiscoverView: View {
    @State var events: [Event] = []
    
    
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        
        ZStack {
            Color("colorBackground")
                    .ignoresSafeArea()
            VStack {
                
                
                    
                
                DiscoverContentView(events: $events)
                    
                
                
                
            }
        }
        
    }
}
struct DiscoverContentView: View {
    @Environment(\.isSearching) private var isSearching
    @Binding var events: [Event]
    @State var articles: [Event] = []
    @State private var searchIsActive = false
    @State private var searchText = ""
    @State var shouldPresentSheet = false
    var gallery = [""]
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Discover")
                            .font(.custom("ArchivoBlack-Regular", size: 46))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                        Button(action: {
                            shouldPresentSheet.toggle()
                        })  {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width:40, height:40)
                                .foregroundColor(Color.purple)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.trailing, 30)
                        }
                        .sheet(isPresented: $shouldPresentSheet) {
                                            print("Sheet dismissed!")
                                        } content: {
                                            SearchView(events: $events)
                                        }
                        .frame(width: 40, alignment: .trailing)
                    }
                    
                    TabView {
                        ForEach($events.filter{$0.wrappedValue.$categories.wrappedValue.contains("Welcome Week") || $0.wrappedValue.$imageURL.wrappedValue != "nil"}) { $event in
                                     //3
                            NavigationLink(destination: EventPageView(article: $event)) {
                                AsyncImage(url: URL(string: "\(event.imageURL)"))
                                Text("\(event.title)")
                            }
                            
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                    
                    
                    
    //                NavigationView {
    //        //            EmptyView()
    //                    List {
    //                        ForEach($articles.wrappedValue, id: \.self) { article in
    //                            Text(article)
    //                        }
    //
    //        //                .listRowSeparator(.hidden)
    //
    //                    }
    ////                    .isHidden(!$searchIsActive.wrappedValue)
    //                    .frame(height: 500)
    //                    .listStyle(.plain)
    //                    .background(.red)
    //    //                .frame(maxHeight: .infinity)
    //
    //                }
    //                .frame(height: 500)
    //                .searchable(text: $searchText)
    //                .onChange(of: searchText) { searchText in
    //                    if !searchText.isEmpty {
    //                        articles = events.compactMap { $0.first }.filter { $0.lowercased().contains(searchText.lowercased()) }
    //
    //                    } else {
    //                        articles = []
    //                    }
    //                }
    ////
    //                .padding(10)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            if $events.count > 0 {
                                ForEach(0...$events.count - 1, id: \.self) { index in
                                    Text(String($events[index].title.wrappedValue))
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
                        var ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
                        let uid = Auth.auth().currentUser?.uid
                        
                        var university = ""
                        ref.child("users").child(uid!).getData(completion:  { error, snapshot in
                            guard error == nil else {
                            print(error!.localizedDescription)
                            return;
                            }
                            
                            if let value = snapshot?.value as? [String: Any] {
                                university = value["university"] as? String ?? ""
                                print("/unis/" + university + "/events/")
                                ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference(withPath: "/unis/" + university + "/events/")
                                var refHandle = ref.observe(DataEventType.value, with: { snapshot in
                                    let data = JSON(snapshot.value as Any)
            //                        print(data)
                                    for (key,subJson):(String, JSON) in data {
                                        events.append(Event(title: subJson["title"].stringValue,
                                                            summary: subJson["summary"].stringValue,
                                                            id: key,
                                                            startDate: subJson["startDate"].stringValue,
                                                            endDate: subJson["endDate"].stringValue,
                                                            imageURL: subJson["imageURL"].stringValue,
                                                            categories: subJson["categories"].arrayValue.map { $0.stringValue}))
                                    }
            //                        dictionaries.forEach({ (key, value) in
            //                            print(value)
            //                            let convertValue = value as! [String: Any]
            ////                            let output = convertToDictionary(text: "\(value)")
            ////                            print(output)
            //                            events.append([convertValue["title"] as? String ?? "", convertValue["summary"] as? String ?? ""])
            //                        })
            //                        let first = (dictionaries?.first?.value)! as! [String: Any]
            //                        print(first["categories"])
                    //                if let value = snapshot?.value as? [String: Any] {
                    //                  university = value["university"] as? String ?? ""
                    //                }
                                })
                            }
                        });
                        
                        
                        //                    events.removeLast()
            //            if $events.count < 1 {
            //                let feedURL = URL(string: "https://rutgers.campuslabs.com/engage/events.rss")!
            //                let parser = FeedParser(URL: feedURL)
            //                let result = parser.parse()
            //                switch result {
            //                case .success(let feed):
            //
            //                    // Grab the parsed feed directly as an optional rss, atom or json feed object
            //                    print(feed.rssFeed?.title)
            //                    print(feed.rssFeed?.items?.count)
            //                    if let items = feed.rssFeed?.items {
            //                        for item in items.prefix(10) {
            //                            events.append([(item.title)!, (item.description)!])
            //                            print(item)
            //                        }
            //                    }
            //
            //
            //
            //
            //                case .failure(let error):
            //                    print(error)
            //                }
            //            }
                        
                    }.isHidden($searchIsActive.wrappedValue)
                    .onChange(of: isSearching) { newValue in
                        searchIsActive = newValue
                            print(searchIsActive)
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
