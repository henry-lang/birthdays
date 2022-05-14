import SwiftUI

@main
struct BirthdaysApp: App {
    let managedObjectContext = PersistenceManager().managedObjectContext
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
