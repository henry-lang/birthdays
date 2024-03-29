import SwiftUI
import Contacts
import CoreData
import AddressBook

struct ContentView: View {
    static let dateSortDescriptor = NSSortDescriptor(keyPath: \Birthday.date, ascending: false)
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var date = Date()
    @State var selected = 0
    @State var addingBirthday = false
    @State var selectedBirthday: Birthday? = nil
    @State var editingBirthday = false
    
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
                            birthday.contact().map { contact in
                                Button(action: {
                                    selectedBirthday = birthday
                                    editingBirthday.toggle()
                                }) {
                                    HStack {
                                        Text(contact.getFullName())
                                        // SwiftUI Moment - If I don't include this line the state doesn't update!
                                        (selectedBirthday == nil) ? Text("").hidden() : Text("").hidden()
                                    }
                                }
                                .foregroundColor(.primary)
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
        .sheet(isPresented: $editingBirthday) {
            EditBirthday(selectedBirthday!)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
