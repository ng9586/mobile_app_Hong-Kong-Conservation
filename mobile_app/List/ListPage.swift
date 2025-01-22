import SwiftUI
import UIKit

struct ListPage: View {
    @State private var listItems = [Item]()
    @State private var addItemName: String = ""
    @State private var colorSelection: UIColor = UIColor.systemRed
    @State private var showAddItemSheet = false
    @State private var selectedItem: Item? // 用於編輯的選中項目

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(listItems, id: \.id) { item in // id識別
                        Text(item.name)
                            .foregroundColor(Color(item.color))
                            .onTapGesture {
                                selectedItem = item
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("Items")
                .navigationBarItems(trailing: Button(action: {
                    showAddItemSheet.toggle()
                }) {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $showAddItemSheet) {
                AddItemView(addItemName: $addItemName, colorSelection: $colorSelection) {
                    let newItem = Item(name: addItemName, color: colorSelection)
                    listItems.append(newItem)
                    addItemName = ""
                    colorSelection = UIColor.systemRed // 重置顏色
                }
            }
            .sheet(item: $selectedItem) { item in // 顯示編輯視圖
                EditItemView(item: Binding(
                    get: { item },
                    set: { updated in
                        if let index = listItems.firstIndex(where: { $0.id == updated.id }) {
                            listItems[index] = updated // 更新項目
                        }
                    })) {}
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        listItems.remove(atOffsets: offsets)
    }
}
