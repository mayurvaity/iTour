//
//  DestinationListingView.swift
//  iTour
//
//  Created by Mayur Vaity on 08/08/24.
//
import SwiftData
import SwiftUI

struct DestinationListingView: View {
    
    //accessing that "main" modelcontext
    @Environment(\.modelContext) var modelContext
    
    //this macro will read out all Destination data from swiftdata in the below array obj
    //it also watches for changes made in below vws, and updates them in the swiftdata
    //sort - to sort by one of the properties of Destination obj, this way we can sort only on 1 column at a time,
//    @Query(sort: \Destination.priority, order: .reverse) var destinations: [Destination]
    //for sorting on multiple columns use sortdescriptors (check below example)
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name, order: .forward)]) var destinations: [Destination]
    
    
    var body: some View {
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
    }
    
    //to get sortdescriptor from contentvw and sort query data using it
    //searchString - to implement searching based on received searchString
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            //if search string is empty then to showw all the objs
            if searchString.isEmpty {
                return true
            } else {
                //else search using searchstring in name of the destinaton
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    
    //example 2 filtering with date
//    init(sort: SortDescriptor<Destination>) {
//        let now = Date.now
//        
//        _destinations = Query(filter: #Predicate {
//            $0.date > now
//        }, sort: [sort])
//    }
    
    //example 1 filtering with priority >= 2
//    init(sort: SortDescriptor<Destination>) {
//        _destinations = Query(filter: #Predicate {
//            $0.priority >= 2
//        }, sort: [sort])
//    }
    
    
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
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
