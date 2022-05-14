import CoreData
import Contacts

extension Birthday {
    func name() -> String {
        do {
            let name = try CNContactStore().unifiedContact(withIdentifier: self.identifier!, keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor]).givenName
            
            return name
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

class BirthdayActions {
    public static func create(for contact: CNContact, on day: Date, using managedObjectContext: NSManagedObjectContext) {
        let newBirthday = Birthday(context: managedObjectContext)
        newBirthday.id = UUID()
        newBirthday.identifier = contact.identifier
        newBirthday.day = day
        
        saveChanges(using: managedObjectContext)
    }
    
    fileprivate static func saveChanges(using managedObjectContext: NSManagedObjectContext) {
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
