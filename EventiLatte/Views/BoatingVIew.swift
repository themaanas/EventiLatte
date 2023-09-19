//
//  BoatingVIew.swift
//  EventiLatte
//
//  Created by Kevin Tran on 8/30/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import SwiftyJSON

//struct Event: Identifiable {
//
//    @State var title: String
//    @State var summary: String
//    @State var id: String
//    @State var startDate: String
//    @State var endDate: String
//    @State var imageURL: String
//    @State var shortDateString: String
//    @State var categories: [String]
//
//}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}


struct BoatingVIew: View {
    @State var events: [Event] = []
    @EnvironmentObject var userSettings: UserSettings
    @State var interests: [String] = []
    @State var DateString = Date.now.formatted(.dateTime.month().day().year())
    @State var shouldPresentSheet = false
    let notify = NotificationHandler()
    var body: some View {
        NavigationView{
            GeometryReader { screenSize in
                Color("colorBackground")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading){
                        ForEach(Array($userSettings.parsedSavedEvents.wrappedValue.keys).sorted(by: {$0 < $1}), id: \.self) { day in
                            
                            Text("\(format(date:day))")
                                .font(.system(size: 22))
                                .padding(.leading, 10)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: screenSize.size.width, height: 30, alignment: .leading)
                                .padding(.top, 30)
                            ScrollView() {
                                VStack {
                                    if let eventIDList = $userSettings.parsedSavedEvents.wrappedValue[day] {
                                        if $events.filter{eventIDList.contains($0.id.wrappedValue)}.unique{$0.id}.count > 0 {
                                            
                                            ForEach($events.filter{eventIDList.contains($0.id.wrappedValue)}.unique{$0.id}) { $event in
                                                
                //                                    Text("\(String(describing: $events.wrappedValue.filter{$0.id == event}[0]))")
                //                                        .font(.system(size: 16))
                //                                        .padding(.leading, 10)
                //    //                                    .fontWeight(.black)
                //                                        .foregroundColor(.white)
                //                                        .frame(width: screenSize.size.width, height: 30, alignment: .leading)
                //                                        .padding(.top, 30)
                                                    HomeEventLinkView(event: $event)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            //                List{
                            //                    VStack(){
                            //                        Text("Today")
                            //                        //Image(imageurl)
                            //                        Text("Title")
                            //
                            //
                            //
                            //
                            //                    }.listRowSeparator(.hidden)
                            //                        .listRowBackground(Color("colorBackground"))
                            //
                            //                }.background(Color("colorBackground"))
                            //                    .scrollContentBackground(.hidden)
                        }
                    }
                }
                
                
            }
            .navigationTitle("Home")
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
        }
        
//        .onChange(of: userSettings.parsedSavedEvents, perform: { newValue in
//
//            print("hiiii \(newValue)")
//        })
//        .onChange(of: events) { newValue in
//            print(events.filter({$0.id == ($userSettings.parsedSavedEvents.wrappedValue[Array($userSettings.parsedSavedEvents.wrappedValue.keys)[0]] as! [String])[0]}))
//        }
        .onAppear() {
            
            //            let events = userSettings.savedEvents
            //         print("Print: \($userSettings.parsedSavedEvents.wrappedValue)")
            //            let ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
            //            let uid = Auth.auth().currentUser?.uid
            
            //            ref.child("users").child(uid!).observe(DataEventType.value, with:  { snapshot in
            //            if let past = Calendar.current.date(byAdding: .day, value:                -3, to: Date()) {
            //
            //                DateString = format(date: past)
            //                print(format(date: past)) // "next week"
            //
            //
            //
            //            }
            //
            var ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference()
            let uid = Auth.auth().currentUser?.uid
            
            var university = ""
            ref.child("users").child(uid!).getData(completion: { error, snapshot1 in
                university = JSON(snapshot1?.value)["university"].stringValue
                ref = Database.database(url: "https://eventplanner-e12a0-default-rtdb.firebaseio.com").reference(withPath: "/unis/" + university + "/events/")
                var refHandle = ref.getData(completion: { error, snapshot in
                    let data = JSON(snapshot?.value as Any)
                    
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
                
            });
        }
        
    
    }
    
    func format(date: Date) -> String {
          let calendar = Calendar.current
      if calendar.isDateInToday(date){
              let df = DateFormatter()
              df.dateStyle = .short
              df.timeStyle = .none
              df.doesRelativeDateFormatting = true
          return df.string(from: date)
          
          }
    else if calendar.isDateInYesterday(date){
          let df = DateFormatter()
              df.dateStyle = .short
              df.timeStyle = .none
              df.doesRelativeDateFormatting = true
          return df.string(from: date)
      }
      else if calendar.isDateInTomorrow(date){
          let df = DateFormatter()
              df.dateStyle = .short
              df.timeStyle = .none
              df.doesRelativeDateFormatting = true
          return df.string(from: date)
          } else {
              let df = DateFormatter()
              df.dateFormat = "EEEE, MMM d"
          return df.string(from: date)
      }
      
      }
}
//struct BoatingVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        BoatingVIew()
//    }
//}
