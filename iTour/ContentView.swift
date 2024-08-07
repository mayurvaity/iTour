//
//  ContentView.swift
//  iTour
//
//  Created by Mayur Vaity on 07/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    //accessing that "main" modelcontext
    @Environment(\.modelContext) var modelContext
    
    //this macro will read out all Destination data from swiftdata in the below array obj
    //it also watches for changes made in below vws, and updates them in the swiftdata
    @Query var destinations: [Destination]
    
    //note: all swiftdata models automatically conform to identifiable protocol, we can directly use them in the lists
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(destinations) { destination in
                    //for each row in this list
                    VStack(alignment: .leading) {
                        //name of the destination
                        Text(destination.name)
                            .font(.headline)
                        
                        //date
                        //formatted - to format this date value as necessary
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .navigationTitle("iTour") //for navigation title
            .toolbar {
                Button("Add Samples", action: addSamples)
            }
        }
    }
    
    func addSamples() {
        //creating sample Destination objs
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        
        //adding these objs to swiftdata storage
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
}

#Preview {
    ContentView()
}
