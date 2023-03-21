import SwiftUI

@main
struct BirthdaysApp: App {
    let managedObjectContext = PersistenceManager().managedObjectContext
    
    init() {
        Notifications.requestPermissions()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
