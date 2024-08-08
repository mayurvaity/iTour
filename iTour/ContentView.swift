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
    //sort - to sort by one of the properties of Destination obj, this way we can sort only on 1 column at a time,
//    @Query(sort: \Destination.priority, order: .reverse) var destinations: [Destination]
    //for sorting on multiple columns use sortdescriptors (check below example)
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name, order: .forward)]) var destinations: [Destination]
    
    //note: all swiftdata models automatically conform to identifiable protocol, we can directly use them in the lists
    
    //var array to keep destination obj while creating a new one
    @State private var path = [Destination]()
    
    
    var body: some View {
        //path - when value of "path" variable is changed, navigationstack moves to vw stated in navigationDestination by passing obj in "path" variable for use
        //note: make sure path array has only 1 element in it
        NavigationStack(path: $path) {
            List {
                ForEach(destinations) { destination in
                    //NavigationLink - helps with navigating to edit destination vw, it also helps with passing destination obj data
                    NavigationLink(value: destination) {
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
                //to delete selected destination obj when swiped left
                .onDelete(perform: deleteDestinations)
            }
            .navigationTitle("iTour") //for navigation title
            //to set destination vw when tapped on one of the rows in abv created list
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                //button to create a new destination
                Button("Add Destination", systemImage: "plus", action: addDestination)
            }
        }
    }
    
    
    //to create a blank destination obj
    func addDestination() {
        //creating a blank destination obj
        let destination = Destination()
        
        //adding that obj to model context
        modelContext.insert(destination)
        
        //forming a path array with this obj
        path = [destination]
    }
    
    //fn to delete destinations
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            //getting destination obj to be deleted
            let destination = destinations[index]
            //deleting selected destination from modelcontext
            modelContext.delete(destination)
        }
    }
}

#Preview {
    ContentView()
}
