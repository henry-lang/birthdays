import CoreData

public class EventItems: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var day: Date
    @NSManaged public var identifier: String
}
