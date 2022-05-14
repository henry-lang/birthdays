import SwiftUI
import Contacts

struct EditBirthday: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var birthday: Birthday
    @State var showPicker = false
    @State var contact: CNContact?
    @State var day: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                InfoForm(contact: $contact, day: $day)
                Form {
                    Button(role: .destructive, action: {
                        BirthdayActions.delete(birthday, using: managedObjectContext)
                    }) {
                        Text("Delete Birthday")
                    }
                }
            }
            .navigationTitle("Edit Birthday")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
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
