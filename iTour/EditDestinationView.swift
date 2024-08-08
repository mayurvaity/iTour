//
//  EditDestinationView.swift
//  iTour
//
//  Created by Mayur Vaity on 08/08/24.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    //@Bindable macro allows to keep in sync with source vw (which will keep it insync with swiftdata)
    //var to keep destination obj
    @Bindable var destination: Destination
    
    //var to accept newSightName data from UI
    @State private var newSightName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            //axis: .vertical - to allow this field to grow as more text is added
            TextField("Details", text: $destination.details, axis: .vertical)
            
            //date picker
            DatePicker("Date", selection: $destination.date)
            
            //to set priority
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented) //to show side by side 3
            }
            
            //sights section
            Section("Sights") {
                //to display list of sights related to this destination
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                
                //to accept new sight data 
                HStack {
                    //accepting new sight name here
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    //button to perform action of adding new sight to this destination, sight name taken from abv textfield
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline) //will help when we come to this vw using navigationLink from content vw 
    }
    
    func addSight() {
        //checking if supplied sight name is empty
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            //creating new sight obj using name provided
            let sight = Sight(name: newSightName)
            //adding abv obj to sights list for that destination
            destination.sights.append(sight)
            //then clearing newSightName var for next input
            newSightName = ""
        }
    }
}

#Preview {
    do {
        //config for sample model container
        //isStoredInMemoryOnly - to keep only in RAM and to not store it in swiftdata
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        //creating sample model container with abv configuration
        let container = try ModelContainer(for: Destination.self, configurations: config)
        
        //sample destination obj created
        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        
        //passing sample obj to preview
        return EditDestinationView(destination: example)
            .modelContainer(container) //passing sample model container to the preview
    } catch {
        fatalError("Failed to create model container.")
    }
}
