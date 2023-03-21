import SwiftUI
import Contacts

struct EditBirthday: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let birthday: Birthday
    @State var showPicker = false
    @State var contact: CNContact?
    @State var date: Date = Date()
    
    init(_ edit: Birthday) {
        self.birthday = edit
        _contact = State(initialValue: birthday.contact())
        _date = State(initialValue: birthday.date!)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                InfoForm(contact: $contact, day: $date)
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
                        BirthdayActions.edit(birthday: birthday, contact: contact!, date: date, using: managedObjectContext)
                        dismiss()
                    }) {
                        Text("Done")
                    }
                    .disabled(contact == nil)
                }
            }
        }
    }
}
