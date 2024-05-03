//
//  FourthViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 5/3/24.
//

import Foundation

class FourthViewModel: ObservableObject {
    @Published var items: [Item] = []

    init() {
        loadItems()
    }

    func loadItems() {
        self.items = StorageManager.shared.getAllItems()
    }

    func addItem(_ item: Item) {
        StorageManager.shared.addItem(item)
        loadItems()  // 변경 후 데이터를 다시 로드
    }

    func updateItem(_ updatedItem: Item) {
        StorageManager.shared.updateItem(updatedItem)
        loadItems()  // 변경 후 데이터를 다시 로드
    }

    func deleteItem(withID id: Int) {
        StorageManager.shared.deleteItem(withID: id)
        loadItems()  // 변경 후 데이터를 다시 로드
    }
}
