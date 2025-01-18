import SwiftUI
import UIKit // Import UIKit for UIColor

struct AddItemView: View {
    @Binding var addItemName: String
    @Binding var colorSelection: UIColor
    var onAddItem: () -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $addItemName)
                
                ColorPicker("Select Color", selection: Binding(
                    get: { Color(colorSelection) },
                    set: { colorSelection = UIColor($0) }
                ))
                
                Button("Add Item") {
                    onAddItem()
                }
            }
            .navigationTitle("Add New Item")
            .navigationBarItems(trailing: Button("Done") {
                onAddItem() // Call to add item when done
            })
        }
    }
}
