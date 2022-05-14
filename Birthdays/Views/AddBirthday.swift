import SwiftUI
import Contacts

struct AddBirthday: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var showPicker = false
    
    @State var contact: CNContact? = nil
    @State var day = Date()
    
    var body: some View {
        NavigationView {
            InfoForm(contact: $contact, day: $day)
                .navigationTitle("Add Birthday")
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
                            BirthdayActions.create(for: contact!, on: day, using: managedObjectContext)
                            
                            dismiss()
                        }) {
                            Text("Add")
                        }
                        .disabled(contact == nil)
                    }
                }
        }
    }
}
