import SwiftUI
import UIKit

struct EditItemView: View {
    @Binding var item: Item
    var onUpdate: () -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: Binding(
                    get: { item.name },
                    set: { item.name = $0 }
                ))
                
                ColorPicker("Select Color", selection: Binding(
                    get: { Color(item.color) },
                    set: { item.color = UIColor($0) }
                ))
                
                Button("Update Item") {
                    onUpdate()
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarItems(trailing: Button("Done") {
                onUpdate() // 完成時更新項目
            })
        }
    }
}
