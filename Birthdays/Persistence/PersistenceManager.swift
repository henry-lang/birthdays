import CoreData

class PersistenceManager {
    lazy var managedObjectContext = { self.persistentContainer.viewContext }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("\(error)")
            }
        }
        
        return container
    }()
}
