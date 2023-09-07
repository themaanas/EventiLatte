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
    @State var shortDateString: String
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
    @State var interests: [String] = []
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
                                    	
                                    NavigationLink(destination: EventPageView(article: $event)) {
                                        
                                        GeometryReader {geometry in
                                            CachedAsyncImage(url: URL(string: "\(event.imageURL)")){ image in
                                                ZStack{
                                                    ZStack(alignment: .bottom) {
                                                        
                                                        image.resizable().scaledToFill().frame(width: geometry.size.width, height: 250, alignment: .bottomLeading).padding(.top, 0)
                                                        
                                                        
                                                        ZStack(alignment: .bottomLeading) {
//                                                            Color.clear
                                                            Rectangle()
                                                                    .fill(.thinMaterial)
                                                                    .frame(height: 100)
                                                                    .mask {
                                                                        VStack(spacing: 0) {
                                                                            LinearGradient(colors: [Color.black.opacity(0),  // sin(x * pi / 2)
                                                                                                    Color.black.opacity(0.383),
                                                                                                    Color.black.opacity(0.707),
                                                                                                    Color.black.opacity(0.924),
                                                                                                    Color.black],
                                                                                           startPoint: .top,
                                                                                           endPoint: .bottom)
                                                                                .frame(height: 70)
                                                                            
                                                                            Rectangle()
                                                                        }
                                                                    }
                                                                    .frame(height:70)
                                                            VStack(alignment: .leading) {
                                                                Text("\(event.title)")
                                                                    .multilineTextAlignment(.leading)
                                                                    .font(.system(size: 26))
                                                                    .fontWeight(.bold)
                                                                    .padding(0)
                                                                    .foregroundColor(.white)
                                                                    .frame(width: geometry.size.width - 50, height: 20, alignment: .bottomLeading)
                                                                    .padding(.leading, 20)
                                                                    .padding(.bottom, 3)
    //                                                                .background(.red)
                                                                Text("\(event.shortDateString)")
                                                                    .multilineTextAlignment(.leading)
                                                                    .font(.system(size: 16))
    //                                                                .fontWeight(.bold)
                                                                    .padding(0)
                                                                    .foregroundColor(Color(hex: 0xe3e3e3))
                                                                    .frame(width: geometry.size.width - 120, height: 10, alignment: .bottomLeading)
                                                                    .padding(.leading, 20)
                                                                    .padding(.bottom, 10)
    //                                                                .background(.red)
                                                                
                                                            }
                                                            
                                                        }
                                                        
        //                                                    .background(.red)
    //                                                    ExecuteCode {
    //                                                        tagIndex += 1
    //                                                    }
                                                            
                                                    }.frame(width: geometry.size.width, height: 250, alignment: .bottom).clipShape(RoundedRectangle(cornerRadius: 20))
//                                                    ZStack(alignment: .top) {
//                                                        VStack(alignment: .trailing) {
//                                                            ForEach(event.categories, id: \.self) { category in
//                                                                Text(category.uppercased())
//                                                                    .foregroundColor(.white)
//                                                                    .fontWeight(.black)
//                                                                    .font(.system(size: 11))
//                                                                    .frame(height:15)
//                                                                    .padding(.leading, 5)
//                                                                    .padding(.trailing, 5)
//                                                                    .background(Color("colorBackgroundSecondary"))
//                                                                    .cornerRadius(5)
//                                                            }
//                                                        }
//                                                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topTrailing).padding(.trailing, 15).padding(.top, 15)
//                                                    }.frame(width: geometry.size.width, height: 250, alignment: .top).clipShape(RoundedRectangle(cornerRadius: 20))
                                                }
                                                
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        }
                                        
                                        
                                        
                                        
                                    }.tag(event.id).frame(width: screenSize.size.width - 20,height: 250)
                                }
                            }
//                            .frame(height:250)
//                            .tabViewStyle(.page(indexDisplayMode: .never))
//                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .frame(width: screenSize.size.width, height: 350)
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
                                                        if $events.count > 0 {
                                                            timerIndex = ($timerIndex.wrappedValue + 1) % $events.filter{$0.categories.wrappedValue.contains("Welcome Week") && $0.imageURL.wrappedValue != "nil"}.count
                                                            stringIndex = $events.filter{$0.categories.wrappedValue.contains("Welcome Week") && $0.imageURL.wrappedValue != "nil"}[timerIndex].id
                                                        }
                                                    }
                                                })
                                    .onChange(of: stringIndex) { newValue in
                                                    debugPrint("[a]: new value \(newValue)")
                                        connectedTimer?.cancel()
                                                }
                            
                            ForEach($interests, id: \.self) { interest in
                                InterestListView(events: $events, interest: interest)
                            }
                            
                            
                        }
                        
                    }
                }.background(Color("colorBackground"))
            }
            
                
            
            
        }.background(Color("colorBackground").ignoresSafeArea())
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
                        
                        interests = JSON(value)["interests"].arrayValue.map { $0.stringValue}
                        university = JSON(value)["university"] as? String ?? ""
                        print("/unis/" + university + "/events/")
                        ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference(withPath: "/unis/" + university + "/events/")
                        var refHandle = ref.observe(DataEventType.value, with: { snapshot in
                            let data = JSON(snapshot.value as Any)
                            
    //                        print(data)
                            for (key,subJson):(String, JSON) in data {
                                let string1 = "\(subJson["startDate"].stringValue)"
                                let string2 = "\(subJson["endDate"].stringValue)"
                                let formatter4 = DateFormatter()
                                formatter4.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                let date1 = formatter4.date(from: string1)
                                let date2 = formatter4.date(from: string2)
                                formatter4.dateFormat = "M/d h:mma"
                                var outputString = "\(formatter4.string(from: date1 ?? Date())) - \(formatter4.string(from: date2 ?? Date()))"
                                if (Calendar.current.isDate(date1 ?? Date(), inSameDayAs:date2 ?? Date())) {
                                    
                                    outputString = "\(formatter4.string(from: date1 ?? Date())) - "
                                    formatter4.dateFormat = "h:mma"
                                    outputString = outputString + "\(formatter4.string(from: date2 ?? Date()))"
                                }
                                events.append(Event(title: subJson["title"].stringValue,
                                                    summary: subJson["summary"].stringValue,
                                                    id: key,
                                                    startDate: subJson["startDate"].stringValue,
                                                    endDate: subJson["endDate"].stringValue,
                                                    imageURL: subJson["imageURL"].stringValue,
                                                    shortDateString: outputString,
                                                    categories: subJson["categories"].arrayValue.map { $0.stringValue}))
                            }
                        })
                    }
                });
                
            }
        
        
    }
}

struct InterestListView: View {
    
    @Binding var events: [Event]
    @Binding var interest: String
    
    var body: some View {
        HStack {
            Text($interest.wrappedValue).fontWeight(.bold).padding(.leading, 10)
            Spacer()
        }
        
        ScrollView(.horizontal) {
            
            LazyHStack {
                if $events.filter{$0.categories.wrappedValue.contains($interest.wrappedValue) && $0.imageURL.wrappedValue != "nil"}.count > 0 {
                    
                    ForEach($events.filter{$0.categories.wrappedValue.contains($interest.wrappedValue) && $0.imageURL.wrappedValue != "nil"}) { $event in
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
            }.padding(.leading, 10)
        }.padding(.bottom, 30)
    }
}

//struct DiscoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverView()
//    }
//}
