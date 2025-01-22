import SwiftUI
import UIKit // Import UIKit for UIColor

struct AddItemView: View {
    @Binding var addItemName: String
    @Binding var colorSelection: UIColor
    var onAddItem: () -> Void
    
    // State variables for validation and user feedback
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item Name", text: $addItemName)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    ColorPicker("Select Color", selection: Binding(
                        get: { Color(colorSelection) },
                        set: { colorSelection = UIColor($0) }
                    ))
                    
                    // Preview of the selected color
                    HStack {
                        Text("Selected Color:")
                        Circle()
                            .fill(Color(colorSelection))
                            .frame(width: 30, height: 30)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    }
                }

                Button("Add Item") {
                    if addItemName.isEmpty {
                        alertMessage = "Please enter a valid item name."
                        showAlert = true
                    } else {
                        onAddItem() // Call to add item when done
                        addItemName = "" // Clear the input field after adding
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationTitle("Add New Item")
            .navigationBarItems(trailing: Button("Done") {
                if !addItemName.isEmpty {
                    onAddItem() // Call to add item when done
                    addItemName = "" // Clear the input field after adding
                } else {
                    alertMessage = "Please enter a valid item name."
                    showAlert = true
                }
            })
        }
    }
}
