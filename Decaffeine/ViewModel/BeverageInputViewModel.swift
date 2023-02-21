import Foundation
import SwiftUI
import RealmSwift
import Combine

class BeverageInputViewModel : ObservableObject {
 
    @Published var isPresented : Binding<Bool>
    
    @Published var selectedBeverages : Binding<[SelectedBeverage]>
    @Published var selectedBeverage : SelectedBeverage = SelectedBeverage()
    
    @Published var beverages : [Beverage] = Beverage.beverageList
    
    @Published var name : String = ""
    @Published var imageName : String = ""
    @Published var numberOfShots : Double = 1.0
    @Published var size : String = "Regular"
    @Published var registerDate : Date = Date()
    @Published var selectedSize: String?
    
    let caffeinePerShot : Double = 63 // ex) 63mg -> static 카페인 1shot 당 함량
    @Published var totalCaffeine : Double = 0 // NumberOfShots * caffeinePerShot = totalCaffeine
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, selectedBeverages: Binding<[SelectedBeverage]>) {
        
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        self.isPresented = isPresented
        self.selectedBeverages = selectedBeverages
        
        observeCaffeine() // observeCaffeine 메서드를 호출하여 totalCaffeine 값을 계산 및 업데이트합니다.
    }

    func updateBeverageName(name: String) {
        self.selectedBeverage.name = name
    }
    
    func updateBeverageImageName(imageName: String){
        self.selectedBeverage.imageName = imageName
    }

    func updateBeverageShots(numberOfShots: Double) {
        self.selectedBeverage.numberOfShots = numberOfShots
        updateTotalCaffeine()
    }

    func updateBeverageSize(size: String) {
        self.selectedBeverage.size = size
        self.selectedSize = size
    }

    func updateBeverageRegisterDate(registerDate: Date) {
        self.selectedBeverage.registerDate = registerDate
    }
    
    func updateTotalCaffeine() {
        self.totalCaffeine = self.numberOfShots * self.caffeinePerShot
    }

    func observeCaffeine() {
        $totalCaffeine
            .sink { [weak self] totalCaffeine in
                self?.selectedBeverage.caffeine = Int(totalCaffeine)
            }
            .store(in: &subscriptions)
    }

    //REALM DB
    func saveSelectedBeverage() {
            
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(selectedBeverage)
            }
            // 데이터 저장이 완료된 후, UI를 갱신합니다.
            selectedBeverages.wrappedValue.append(selectedBeverage)
        } catch let error {
            print("Failed to save selectedBeverage: \(error.localizedDescription)")
        }
            
        selectedBeverage = SelectedBeverage()
        eraseForm()
        isPresented.wrappedValue = false
    }

    
    private func eraseForm(){
        name = ""
        imageName = ""
        numberOfShots = 1.0
        size = "Regular"
        registerDate = Date()
    }
    
    
}
