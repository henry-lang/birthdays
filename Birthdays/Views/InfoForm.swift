import SwiftUI
import Contacts

struct InfoForm: View {
    @State var showPicker = false
    
    @Binding var contact: CNContact?
    @Binding var day: Date
    
    var body: some View {
        ZStack {
            ContactPicker(show: $showPicker, onSelect: {
                contact = $0
            })
            
            Form {
                Section("Name", content: {
                    Button(action: {
                        showPicker.toggle()
                    }) {
                        Text(contact?.getFullName() ?? "Select Contact")
                    }
                })
                
                Section("Date", content: {
                    DatePicker("Birthday", selection: $day, displayedComponents: [.date])
                        .datePickerStyle(WheelDatePickerStyle())
                })
            }
        }
    }
}
