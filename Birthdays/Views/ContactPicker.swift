import SwiftUI
import ContactsUI

class WrapperViewController: UIViewController {}

class ViewModel {
    var wrapper: WrapperViewController!
    var controller: CNContactPickerViewController?
}

struct ContactPicker: UIViewControllerRepresentable {
    @Binding var show: Bool
    @State var model = ViewModel()
    
    var onSelect: ((_: CNContact) -> Void)?
    var onCancel: (() -> Void)?
    
    init(show: Binding<Bool>, onSelect: ((_: CNContact) -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self._show = show
        self.onSelect = onSelect
        self.onCancel = onCancel
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ContactPicker>) -> some UIViewController {
        let wrapper = WrapperViewController()
        model.wrapper = wrapper
        
        return wrapper
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ContactPicker>) {
        guard model.wrapper != nil else { return }
        
        let canShow = model.wrapper.presentedViewController == nil || self.model.wrapper.presentedViewController?.isBeingDismissed == true
        let canClose = model.controller != nil
        
        if show && canShow && model.controller == nil {
            let picker = CNContactPickerViewController()
            picker.delegate = context.coordinator
            model.controller = picker
            model.wrapper.present(picker, animated: true)
        } else if !show && canClose {
            model.controller = nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker
        
        init(_ parent: ContactPicker){
            self.parent = parent
        }
        
        public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.show = false
            parent.onCancel?()
        }
        
        public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.show = false
            parent.onSelect?(contact)
        }
    }
}
