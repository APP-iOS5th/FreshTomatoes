//
//  UserDefaultsManager.swift
//  FreshTomato
//
//  Created by 임재현 on 5/3/24.
//

import Foundation


struct Item: Codable {
    var id:Int
    var images: String
    var name: String
    var description: String
}

class StorageManager {
    // UserDefaults key
    private let userDefaultsKey = "items"
    
    static let shared = StorageManager()
    
    // MARK: - CRUD
    // 데이터 저장
    func addItem(_ item: Item) {
        var items = getAllItems()
        items.append(item)
        saveItems(items)
        print("저장 성공 \(items)")
    }
    
    // 데이터 읽기
    func getAllItems() -> [Item] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return []
        }
        do {
            let items = try JSONDecoder().decode([Item].self, from: data)
            return items
        } catch {
            print("Error decoding items: \(error.localizedDescription)")
            return []
        }
    }
    
    // 데이터 업데이트
    func updateItem(_ updatedItem: Item) {
        var items = getAllItems()
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
            saveItems(items)
        }
    }

    // 데이터 삭제
    func deleteItem(withID id: Int) {
        var items = getAllItems()
        items.removeAll(where: { $0.id == id })
        saveItems(items)
    }
    
    // MARK: - 인코딩, 디코딩
    
    private func saveItems(_ items: [Item]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Error encoding items: \(error.localizedDescription)")
        }
    }
}
