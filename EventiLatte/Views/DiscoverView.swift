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
import CachedAsyncImage
import Combine

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
//            Color("colorBackground")
//                                    .ignoresSafeArea()
//            Stack {
//
//                Color("colorBackground")
//                        .ignoresSafeArea()
//
//
//
//
//
//
//
//            }.background( Color("colorBackground"))
            DiscoverContentView(events: $events)
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
    @State private var timerIndex: Int = 0
    @State private var tagIndex: Int = 0
    @State private var stringIndex: String = ""
    var gallery = [""]
    @State var connectedTimer: Cancellable? = nil
    
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    
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
            
            GeometryReader { screenSize in
                ScrollView {
                    ZStack {
                        Color("colorBackground")
                                .ignoresSafeArea()
                        
                        VStack {
                            
                            TabView(selection: $stringIndex) {
                                
                                ForEach($events.filter{$0.categories.wrappedValue.contains("Welcome Week") && $0.imageURL.wrappedValue != "nil"}) { $event in
                                             //3
//                                    ExecuteCode{
//                                        print(event.imageURL)
//                                    }
                                    
                                    
                                    NavigationLink(destination: EventPageView(article: $event)) {
                                        
                                        GeometryReader {geometry in
                                            CachedAsyncImage(url: URL(string: "\(event.imageURL)")){ image in
                                                ZStack {
                                                    
                                                    image.resizable().scaledToFit()
                                                    VStack {
                                                        Text("\(event.title)")
                                                            .padding(0)
                                                            .foregroundColor(.white)
                                                            .frame(width: geometry.size.width, height: 200, alignment: .bottomLeading)
                                                            .padding(.leading, 40)
                                                            .padding(.bottom, 20)
                                                            .background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black.opacity(1)]), startPoint: .top, endPoint: .bottom))
//                                                            .padding(.bottom, 30)
                                                    }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
    //                                                    .background(.red)
//                                                    ExecuteCode {
//                                                        tagIndex += 1
//                                                    }
                                                        
                                                }
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        }
                                        
                                        
                                        
                                        
                                    }.tag(event.id)
                                }
                                    }
//                            .tabViewStyle(.page(indexDisplayMode: .never))
//                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .frame(width: screenSize.size.width, height: 250)
                                    .navigationTitle("Discover")
    //                                .navigationBarTitleDisplayMode(.inline)
                                    .toolbar {
                                        
                                        Button(action: {
                                                shouldPresentSheet.toggle()
                                            })  {
                                                Image(systemName: "magnifyingglass")
        //                                            .resizable()
        //                                            .frame(width:40, height:40)
                                                    .foregroundColor(Color.purple)
        //                                            .font(.title)
        //                                            .fontWeight(.bold)
        //                                            .padding(.trailing, 30)
                                            }
    //                                        .frame(width: 40, height: 40)
    //                                        .padding(.top, 90)
                                        
                                            .sheet(isPresented: $shouldPresentSheet) {
                                                                print("Sheet dismissed!")
                                                            } content: {
                                                                SearchView(events: $events)
                                                            }
                                        
                                        
    //                                    .frame(width: 40, alignment : .trailing)

                                                    }
//                                    .toolbarBackground(.visible, for: .navigationBar)
//                                    .toolbarBackground(.yellow, for: .navigationBar)
                                    .tabViewStyle(PageTabViewStyle())
                                    .onReceive(timer, perform: { _ in
                                                    withAnimation {
                                                        print("\(timerIndex) tag")
                                                        timerIndex = ($timerIndex.wrappedValue + 1) % $events.filter{$0.categories.wrappedValue.contains("Welcome Week") && $0.imageURL.wrappedValue != "nil"}.count
                                                        stringIndex = $events.filter{$0.categories.wrappedValue.contains("Welcome Week") && $0.imageURL.wrappedValue != "nil"}[timerIndex].id
                                                    }
                                                })
                                    .onChange(of: stringIndex) { newValue in
                                                    debugPrint("[a]: new value \(newValue)")
                                        connectedTimer?.cancel()
                                                }
                            
                            
                            
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
                            HStack {
                                Text("Outdoor Events").fontWeight(.bold)
                                    
//                                    .frame(alignment: .leading)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal) {
                                
                                LazyHStack {
                                    if $events.filter{$0.categories.wrappedValue.contains("Outdoor Event") && $0.imageURL.wrappedValue != "nil"}.count > 0 {
                                        ForEach(0...$events.filter{$0.categories.wrappedValue.contains("Outdoor Event") && $0.imageURL.wrappedValue != "nil"}.count - 1, id: \.self) { index in
//                                            let event = $events[index]
                                            
                                            ZStack {
                                                ZStack(alignment: .top){
                                                    Color.clear
                                                    CachedAsyncImage(url: URL(string: "\($events[index].imageURL.wrappedValue)")){ image in
//                                                        Color.clear
                                                        ZStack {
                                                            image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 20))
                                                            
                                                        }.frame(width: 240, height: 150)
                                                            .offset(y: 5)
//                                                            .clipShape(RoundedRectangle(cornerRadius: 20))
//                                                        .padding()
                                                        
//                                                            .offset(y: 5)
                                                            
                                                            
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                }
//                                                ZStack(alignment: .bottomLeading) {
//                                                    Color.clear
//                                                    Text(String($events[index].title.wrappedValue))
//                                                        .frame(width: 250)
//                                                        .padding(.bottom, 5)
//                                                }
                                                
                                                
                                                
                                            }
                                            .frame(width: 250, height: 200)
                                            .background(Color("colorBackground"))
                                            .cornerRadius(20)
                                            
                                            
                                        }
                                    }
                                }
                            }
                            .background(Color("colorBackground"))
                            .onAppear() {
                                print(events)
                                self.timer = Timer.publish(every: 5, on: .main, in: .common)
                                self.connectedTimer = self.timer.connect()
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
                                
                            }
                        }
                        
                    }
                }.background(Color("colorBackground"))
            }
            
                
            
            
        }.background(Color("colorBackground").ignoresSafeArea())
        
        
    }
}

//struct DiscoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverView()
//    }
//}
