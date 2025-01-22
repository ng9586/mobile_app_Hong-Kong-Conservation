import SwiftUI
import UIKit

struct EditItemView: View {
    @Binding var item: Item
    var onUpdate: () -> Void
    
    // State variables for validation and user feedback
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item Name", text: Binding(
                        get: { item.name },
                        set: { item.name = $0 }
                    ))
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    
                    ColorPicker("Select Color", selection: Binding(
                        get: { Color(item.color) },
                        set: { item.color = UIColor($0) }
                    ))
                    
                    // Preview of the selected color
                    HStack {
                        Text("Selected Color:")
                        Circle()
                            .fill(Color(item.color))
                            .frame(width: 30, height: 30)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    }
                }

                Button("Update Item") {
                    if item.name.isEmpty {
                        alertMessage = "Please enter a valid item name."
                        showAlert = true
                    } else {
                        onUpdate() // Call to update the item when done
                        // Optionally dismiss the view here if you have a dismissal mechanism
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarItems(trailing: Button("Done") {
                if !item.name.isEmpty {
                    onUpdate() // Call to update the item when done
                } else {
                    alertMessage = "Please enter a valid item name."
                    showAlert = true
                }
            })
        }
    }
}
