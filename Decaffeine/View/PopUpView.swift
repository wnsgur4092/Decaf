//
//  PopUpView.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 6/10/2023.
//


import SwiftUI
import MijickPopupView
import Foundation

@available(iOS 15.0, *)
struct PopUpView: CentrePopup {
    //MARK: - PROPERTIES
    @State var name : String = ""
    @ObservedObject var viewModel = BeverageViewModel()
    @State private var selectedBeverageType: String = "coffee"
    @State private var sliderValue: Double = 63
    @State private var textFieldValue: String = "63"
    @FocusState private var isTextFieldFocused: Bool
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
    }
    
    func createContent() -> some View {
        VStack(spacing: 0) {
            Spacer.height(20)
            
            createHeader()
            
            Spacer.height(20)
            
            createTypeSelection()
            
            createTextField()
                .padding(.vertical, 32)
            
            CreateDetailField()
            
            Spacer.height(32)
            
            HStack(spacing: 24){
                createCancelButton()
                createSaveButton()
            }
            
            Spacer.height(24)
        }
        .padding(.horizontal, 20)
        //        .onAppear(perform: onAppear)
    }
}

private extension PopUpView {
    func createIllustration() -> some View {
        Image("boomerang")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
    }
    func createHeader() -> some View {
        HStack{
            Text("Customise your\nBeverage")
                .font(.title)
            
            Spacer()
        }
    }
    
    func createTypeSelection() -> some View {
        let types = ["coffee", "tea", "drink"]
        
        return VStack(alignment: .leading) {
            Text("Select type of Beverage")
            HStack {
                ForEach(types, id: \.self) { type in
                    Button(action: {
                        withAnimation {
                            selectedBeverageType = type
                        }
                    }) {
                        Text(type)
                            .foregroundColor(selectedBeverageType == type ? .white : .black) // 선택된 타입에 따른 텍스트 색상 변경
                            .padding()
                            .padding(.horizontal, 10)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(selectedBeverageType == type ? Color.black : Color.clear)) // 선택된 타입에 따른 배경색 변경
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5,5]))
                                    .foregroundColor(selectedBeverageType == type ? .clear : .black)
                            )
                    }
                    if type != types.last {
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func placeholderText() -> String {
        switch selectedBeverageType {
        case "Coffee":
            return "e.g. Long black"
        case "Tea":
            return "e.g. Green tea"
        case "Drink":
            return "e.g. Coke"
        default:
            return "e.g. Beverage name"
        }
    }
    
    func createTextField() -> some View {
        VStack(alignment:.leading){
            Text("Enter the \(selectedBeverageType) name")
            
            TextField(placeholderText(), text: $name)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8) // 적절한 각도를 선택합니다.
                        .stroke(Color.gray, lineWidth: 1) // 이것은 placeholder와 동일한 색상을 사용합니다.
                )
        }
    }
    
    func CreateDetailField() -> some View {
        VStack(alignment: .leading) {
            Text("Enter the \(selectedBeverageType.lowercased()) caffeine content")
            
            if selectedBeverageType == "Coffee" {
                Text("Generally, 1 Espresso : 63 mg / 1 oz")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            } else if selectedBeverageType == "Tea" {
                Text("Generally, Black: 47mg / 8oz & Green: 28mg / 8oz")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            } else {
                Text("Generally, Coke: 36.4mg / 375 ml")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            
            Slider(value: $sliderValue, in: 0...400, step: 1)
                .accentColor(.black)
                .onChange(of: sliderValue) { newValue in
                    textFieldValue = String(format: "%.0f", newValue)
                }
            
            
            HStack {
                Text("Caffeine: ")
                
                TextField("Caffeine", text: $textFieldValue, onCommit: {
                    if let validValue = Double(textFieldValue), validValue >= 0 && validValue <= 400 {
                        sliderValue = validValue
                    } else {
                        textFieldValue = String(format: "%.0f", sliderValue)
                    }
                })
                .padding(.trailing, 20)
                .padding(.vertical, 8)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .onTapGesture {
                    isTextFieldFocused = true
                }
                .onChange(of: textFieldValue) { newValue in
                    if let validValue = Double(newValue), validValue >= 0 && validValue <= 400 {
                        sliderValue = validValue
                    }
                }
                Text("mg")
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isTextFieldFocused = true
                }
            }
        }
    }
    
    func createCancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel".uppercased())
            //                .font(.boldFont(size: 16))
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
            
                .background(Color.gray)
                .cornerRadius(8)
            
        }
    }
    
    func createSaveButton() -> some View {
        Button(action: addItem) {
            Text("Submit".uppercased())
            //                .font(.boldFont(size: 16))
            //                .foregroundColor(task.isEmpty ? Color.onMainColor : Color.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
        }
        //        .background(task.isEmpty ? Color.clear : Color.onMainColor)
        //        .overlay(RoundedRectangle(cornerRadius: 8)
        //            .stroke(task.isEmpty ? Color.onMainColor : Color.clear, lineWidth: 2))
        .cornerRadius(8)
        .disabled(name.isEmpty)
    }
    
    
    func addItem() {
        viewModel.addItem(name: name, type: selectedBeverageType, caffeine: sliderValue)
    }
}

//private extension PopUpView {
//    func onAppear() {
//        textFieldFocused = true
//    }
//}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


#Preview {
    PopUpView()
}
