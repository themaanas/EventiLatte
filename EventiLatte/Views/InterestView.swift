//
//  InterestView.swift
//  EventiLatte
//
//  Created by Kevin Tran on 9/7/23.
//

import SwiftUI

struct InterestView: View {
    
    var body: some View{
        NavigationView(){
            VStack{
                Text("Choose Your Interests")
                Grid{
                    GridRow{
                        Button("Sports"){
                            
                        }
                        .background(Color(.white))
                        .foregroundColor(Color("colorFont"))
                        .cornerRadius(10)
                        .buttonStyle(.bordered)
                        
                        Button("Sports"){
                            
                        }
                        .cornerRadius(10)
                        .buttonStyle(.bordered)
                        
                        Button("Sports"){
                            
                        }
                        .cornerRadius(10)
                        .buttonStyle(.bordered)
                        
                    }
                    GridRow{
                        Button("Sports"){
                            
                        }
                        .cornerRadius(10)
                        .buttonStyle(.bordered)
                        Button("Sports"){
                            
                        }
                        .cornerRadius(10)
                        .buttonStyle(.bordered)
                        Button("Sports"){
                            
                        }
                        .cornerRadius(10)
                        .buttonStyle(.bordered)
                    }
                }
            }.navigationBarTitle(Text("Interests"))
        }
    }
}


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView()
    }
}
