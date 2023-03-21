import CoreData

class PersistenceManager {
    lazy var managedObjectContext = { self.persistentContainer.viewContext }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        
        let container = NSPersistentContainer(name: "Model")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("\(error)")
            }
        }
        
        return container
    }()
}
