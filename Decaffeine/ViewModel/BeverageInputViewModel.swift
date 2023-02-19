import Foundation
import SwiftUI
import RealmSwift
import Combine


class BeverageInputViewModel : ObservableObject {
 
    @Published var isPresented : Binding<Bool>
    
    @Published var selectedBeverages : Binding<[SelectedBeverage]>
    @Published var selectedBeverage : SelectedBeverage = SelectedBeverage()
    
    @Published var beverages : [Beverage] = Beverage.beverageList
    
    @Published var name : String = "Latte"
    @Published var imageName : String = "latte"
    @Published var numberOfShots : Double = 1.0
    @Published var size : String = "Regular"
    @Published var registerDate : Date = Date()
    
    @Published var selectedSize: String?
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, selectedBeverages: Binding<[SelectedBeverage]>) {
        self.isPresented = isPresented
        self.selectedBeverages = selectedBeverages
        
        // observe selectedBeverage changes and update name, imageName, numberOfShots, size, and registerDate
        $selectedBeverage.sink { [weak self] selectedBeverage in
            self?.name = selectedBeverage.name
            self?.imageName = selectedBeverage.imageName
            self?.numberOfShots = selectedBeverage.numberOfShots
            self?.size = selectedBeverage.size
            self?.registerDate = selectedBeverage.registerDate
        }.store(in: &subscriptions)
    }

    func updateBeverage(name: String, imageName: String) {
        self.selectedBeverage.name = name
        self.selectedBeverage.imageName = imageName
    }

    func updateBeverageShots(numberOfShots: Double) {
        self.selectedBeverage.numberOfShots = numberOfShots
    }

    func updateBeverageSize(size: String) {
        self.selectedBeverage.size = size
        self.selectedSize = size
    }

    func updateBeverageRegisterDate(registerDate: Date) {
        self.selectedBeverage.registerDate = registerDate
    }
    
    
    //REALM DB
    func saveSelectedBeverage() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(selectedBeverage)
            }
        } catch let error {
            print("Failed to save selectedBeverage: \(error.localizedDescription)")
        }
    }
}

