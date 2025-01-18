import Foundation
import UIKit

final class Item: Identifiable, Hashable {
    var id = UUID() // 唯一標識符
    var name: String
    var color: UIColor
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id // 使用 id 來比較實例
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // 使用 id 進行哈希計算
    }
}
