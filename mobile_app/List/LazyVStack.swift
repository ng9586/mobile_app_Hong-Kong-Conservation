import SwiftUI
import UIKit

struct LazyVStackExample: View {
    @State private var listItems = [Item]() // Your list of items
    @State private var selectedItem: Item? // For editing purposes

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(listItems, id: \.id) { item in // Use id for unique identification
                    Text(item.name)
                        .foregroundColor(Color(item.color))
                        .onTapGesture {
                            selectedItem = item // Handle item selection for editing
                        }
                }
                .onDelete(perform: deleteItems) // Allow deletion of items
            }
        }
        .navigationTitle("LazyVStack Example")
        .navigationBarItems(trailing: Button(action: {
            // Action to add new item
        }) {
            Image(systemName: "plus")
        })
        .sheet(item: $selectedItem) { item in
            EditItemView(item: Binding(
                get: { item },
                set: { updated in
                    if let index = listItems.firstIndex(where: { $0.id == updated.id }) {
                        listItems[index] = updated // Update the item in the list
                    }
                })) {}
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        listItems.remove(atOffsets: offsets)
    }
}
