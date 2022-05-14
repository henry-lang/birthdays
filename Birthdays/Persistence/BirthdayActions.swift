import CoreData
import Contacts

extension Birthday {
    func contact() -> CNContact? {
        do {
            let contact = try CNContactStore().unifiedContact(withIdentifier: self.identifier!, keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)] as [CNKeyDescriptor])
            
            return contact
        } catch {
            self.managedObjectContext?.delete(self) // Contact is invalid
            
            return nil
        }
    }
}

class BirthdayActions {
    public static func create(
        for contact: CNContact,
        on day: Date,
        using managedObjectContext: NSManagedObjectContext
    ) {
        let newBirthday = Birthday(context: managedObjectContext)
        newBirthday.id = UUID()
        newBirthday.identifier = contact.identifier
        newBirthday.day = day
        
        saveChanges(using: managedObjectContext)
    }
    
    public static func edit(
        birthday: Birthday,
        contact: CNContact,
        day: Date,
        using managedObjectContext: NSManagedObjectContext
    ) {
        birthday.identifier = contact.identifier
        birthday.day = day
        
        saveChanges(using: managedObjectContext)
    }
    
    public static func delete(_ birthday: Birthday, using managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.delete(birthday)
        
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
