import SwiftUI

struct About: View {
    var body: some View {
        VStack {
            Text("Made with ❤️ by Henry Langmack")
            
            Divider()
            
            Link("Github", destination: URL(string: "https://github.com/henry-lang")!)
            
            Spacer() // Push items to the top
        }
        .padding(.top, 30)
        .navigationBarTitle("About")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
