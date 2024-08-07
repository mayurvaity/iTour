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
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline) //will help when we come to this vw using navigationLink from content vw 
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
