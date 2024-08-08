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
    
    //note: all swiftdata models automatically conform to identifiable protocol, we can directly use them in the lists
    
    //var array to keep destination obj while creating a new one
    @State private var path = [Destination]()
    
    //var to store sort order
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    //var to manage search text
    @State private var searchText = ""
    
    var body: some View {
        //path - when value of "path" variable is changed, navigationstack moves to vw stated in navigationDestination by passing obj in "path" variable for use
        //note: make sure path array has only 1 element in it
        NavigationStack(path: $path) {
            //sort - passing sort order selected by user to list vw
            //searchString - to apply filter of searchtext on the list 
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("iTour") //for navigation title
            //to set destination vw when tapped on one of the rows in abv created list
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                //to show searchbar abv this vw and to be able to search using var "searchText"
                .searchable(text: $searchText)
                .toolbar {
                    //button to create a new destination
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                    
                    //menu on nav bar for sorting options
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                            
                        }
                    }
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
    
    
}

#Preview {
    ContentView()
}
