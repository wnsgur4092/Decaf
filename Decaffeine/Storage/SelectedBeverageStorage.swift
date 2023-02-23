//
//  SelectedBeverageStorage.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 23/2/2023.
//

import Foundation


import Foundation

final class MoodDiaryStorage {
    
    func persist(_ items : [SelectedBeverage]) {
        Storage.store(items, to: .documents, as: "SelectedBeverage_list.json")
    }
    
    func fetch() -> [SelectedBeverage] {
        let list = Storage.retrive("SelectedBeverage_list.json", from: .documents, as: [SelectedBeverage].self) ?? []
        return list
    }
}
