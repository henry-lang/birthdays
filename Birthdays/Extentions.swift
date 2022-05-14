import Contacts

extension CNContact {
    func getFullName() -> String {
        CNContactFormatter.string(from: self, style: .fullName)!
    }
}
