//
//  CustomTextField.swift
//  Decaffeine
//
//  Created by JunHyuk Lim on 14/2/2023.
//

import SwiftUI
import UIKit

struct CustomTextField: View {
    var placeholder : String = "Enter Your Name"
    
    @State var name : String
    @State var isFocusing : Bool
    
    var body: some View {
        ZStack {
            FirstResponderTextField(text: $name, placeholder: placeholder, font: UIFont.systemFont(ofSize: 18), isFocused: $isFocusing)
                .foregroundColor(isFocusing ? Color.black : Color("gray"))
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
            
            RoundedRectangle(cornerRadius: 8)
                .stroke(isFocusing ? Color("mainColor") : Color("gray"), lineWidth: 1)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        
    }
}

//MARK: - FOCUS STATE in iOS 14
struct FirstResponderTextField : UIViewRepresentable {
    @Binding var text : String
    let placeholder : String
    let font: UIFont?
    @Binding var isFocused: Bool
    
    
    class Coordinator : NSObject, UITextFieldDelegate {
        @Binding var text : String
        @Binding var isFocused : Bool
        var becameFirstResponder = false
        
        init(text: Binding<String>, isFocused : Binding<Bool>){
            self._text = text
            self._isFocused = isFocused
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFocused = true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            isFocused = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocused : $isFocused)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        if let font = font {
            textField.font = font
        }
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = false
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(name: "", isFocusing: false)
    }
}
