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
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, selectedBeverages: Binding<[SelectedBeverage]>) {
        
        print("---> Realm Data File Location :\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        self.isPresented = isPresented
        self.selectedBeverages = selectedBeverages
        
        
        $name.sink { name in
            self.updateBeverageName(name: name)
        }.store(in: &subscriptions)
        
        $imageName.sink { imageName in
            self.updateBeverageImageName(imageName: imageName)
        }.store(in: &subscriptions)
        
        $numberOfShots.sink { numberOfShots in
            self.updateBeverageShots(numberOfShots: numberOfShots)
        }.store(in: &subscriptions)
        
        $size.sink{ size in
            self.updateBeverageSize(size: size)
        }.store(in: &subscriptions)
        
        $registerDate.sink { date in
            self.updateBeverageRegisterDate(registerDate: date)
        }.store(in: &subscriptions)
    }

    func updateBeverageName(name: String) {
        self.selectedBeverage.name = name
    }
    
    func updateBeverageImageName(imageName: String){
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

