import SwiftUI
import Contacts
import CoreData
import AddressBook

struct ContentView: View {
    static let dateSortDescriptor = NSSortDescriptor(key: "day", ascending: false)
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var date = Date()
    @State var selected = 0
    @State var addingBirthday = false
    
    @FetchRequest(
        entity: Birthday.entity(),
        sortDescriptors: [dateSortDescriptor]
    )
    var birthdays: FetchedResults<Birthday>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Picker(selection: $selected, label: Text("Picker")) {
                        Text("Upcoming").tag(0)
                        Text("All").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    List {
                        ForEach(birthdays, id: \.self) { birthday in
                            if let contact = birthday.contact() {
                                Text(contact.getFullName())
                            }
                        }
                    }
                }
                
                
            }
            .navigationTitle("Birthdays")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: About()) {
                        Text("About")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addingBirthday.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $addingBirthday) {
                        AddBirthday()
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
