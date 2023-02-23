import Foundation
import SwiftUI
import Combine
import RealmSwift

extension Notification.Name{
    static let beverageUpdated = Notification.Name(rawValue: "beverageUpdated")
}

class BeverageInputViewModel : ObservableObject {
    
    @Published var isPresented : Binding<Bool>
    
    //BEVERAGE LIST
    @Published var beverages : [Beverage] = Beverage.beverageList
    
    
    //USER SELECTED BEVERAGE
    @Published var selectedBeverages : Binding<[SelectedBeverage]>
    @Published var selectedBeverage : SelectedBeverage = SelectedBeverage()
    
    
    @Published var name : String = ""
    @Published var imageName : String = ""
    @Published var numberOfShots : Double = 0.5
    @Published var size : String = ""
    @Published var registerDate : Date = Date()
    @Published var selectedSize: String?
    @Published var caffeine : Double = 0.0
    
    //STATIC VALUE
    let caffeinePerShot : Double = 63 // ex) 63mg -> static 카페인 1shot 당 함량
    @Published var totalCaffeine : Double = 0 // NumberOfShots * caffeinePerShot = totalCaffeine
    
    
    //COMBINE
    var subscriptions = Set<AnyCancellable>()
    
    
    //MARK: - INIT
    init(isPresented: Binding<Bool>, selectedBeverages: Binding<[SelectedBeverage]>) {
        
        self.isPresented = isPresented
        self.selectedBeverages = selectedBeverages
        
        
        $name.sink { name in
            print(">>> Selected name : \(name)")
            self.updateBeverageName(name: name)
        }.store(in: &subscriptions)
        
        $imageName.sink { imageName in
            print(">>> Selected imageName : \(imageName)")
            self.updateBeverageImageName(imageName: imageName)
        }.store(in: &subscriptions)
        
        $numberOfShots.sink { numberOfShots in
            print(">>> Selected numberOfShots : \(numberOfShots)")
            self.updateBeverageShots(numberOfShots: numberOfShots)
        }.store(in: &subscriptions)
        
        $size.sink { size in
            print(">>> Selected size : \(size)")
            self.updateBeverageSize(size: size)
        }.store(in: &subscriptions)
        
        $registerDate.sink { registerDate in
            print(">>> Selected registerDate : \(registerDate)")
            self.updateBeverageRegisterDate(registerDate: registerDate)
        }.store(in: &subscriptions)
        
        $caffeine.sink { caffeine in
            self.updateCaffeine(caffeine: caffeine)
        }.store(in: &subscriptions)
        
    }
    
    func updateCaffeine(caffeine : Double) {
        self.selectedBeverage.caffeine = totalCaffeine // observeCaffeine 메서드를 호출하여 totalCaffeine 값을 계산 및 업데이트합니다.
    }
    
    func updateBeverageName(name: String) {
        self.selectedBeverage.name = name
    }
    
    func updateBeverageImageName(imageName: String){
        self.selectedBeverage.imageName = imageName
    }
    
    func updateBeverageShots(numberOfShots: Double) {
        self.selectedBeverage.numberOfShots = numberOfShots
        updateTotalCaffeine() // totalCaffeine 값을 다시 계산합니다.
    }
    
    func updateBeverageSize(size: String) {
        self.selectedBeverage.size = size
        self.selectedSize = size
    }
    
    func updateBeverageRegisterDate(registerDate: Date) {
        self.selectedBeverage.registerDate = registerDate
    }
    
    func updateTotalCaffeine() {
        self.totalCaffeine = self.selectedBeverage.numberOfShots * self.caffeinePerShot
        updateCaffeine(caffeine: self.totalCaffeine) // caffeine 값을 다시 업데이트합니다.
    }
    
    

    
    //DATA TO Realm
    func saveData() {
        guard let realm = try? Realm() else { return }

        selectedBeverage.registerDate = Date()
        print("---> current time: \(selectedBeverage.registerDate)")
        selectedBeverages.wrappedValue.append(selectedBeverage)
        
        do {
            try realm.write {
                realm.add(selectedBeverage)
                //노티 쏘기
        
            }
            NotificationCenter.default.post(name: .beverageUpdated, object: nil)
        } catch let error {
            print("!!!! BeverageInputView realm error : \(error)")
        }
        
        // Navigate to HomeView
        isPresented.wrappedValue = false
    }

    
    private func eraseForm(){
        name = ""
        imageName = ""
        numberOfShots = 0.5
        size = "regular"
        caffeine = 0.0
        
    }
    
}
