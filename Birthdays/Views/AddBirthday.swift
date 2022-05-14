import SwiftUI
import Contacts

struct AddBirthday: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var showPicker = false
    
    @State var contact: CNContact? = nil
    @State var fullName: String? = nil
    @State var date = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                ContactPicker(show: $showPicker, onSelect: {
                    contact = $0
                    fullName = CNContactFormatter.string(from: $0, style: .fullName)
                })
                
                Form {
                    Section("Name", content: {
                        Button(action: {
                            showPicker.toggle()
                        }) {
                            Text(fullName ?? "Select Contact")
                        }
                    })
                    
                    Section("Date", content: {
                        DatePicker("Birthday", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(WheelDatePickerStyle())
                    })
                }
            }
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
                        BirthdayActions.create(for: contact!, on: date, using: managedObjectContext)
                        
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
