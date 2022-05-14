import SwiftUI
import Contacts

struct EditBirthday: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let birthday: Birthday
    @State var showPicker = false
    @State var contact: CNContact?
    @State var day: Date = Date()
    
    init(_ edit: Birthday) {
        self.birthday = edit
        _contact = State(initialValue: birthday.contact())
        _day = State(initialValue: birthday.day!)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                InfoForm(contact: $contact, day: $day)
                Form {
                    Button(role: .destructive, action: {
                        BirthdayActions.delete(birthday, using: managedObjectContext)
                        
                        dismiss()
                    }) {
                        Text("Delete Birthday")
                    }
                }
            }
            .navigationTitle("Edit Birthday")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        BirthdayActions.edit(birthday: birthday, contact: contact!, day: day, using: managedObjectContext)
                        
                        dismiss()
                    }) {
                        Text("Edit")
                    }
                    .disabled(contact == nil)
                }
            }
        }
    }
}
