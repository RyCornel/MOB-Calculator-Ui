//
//  ActionView.swift
//  Calculator UI
//
//  Created by Ryan Cornel on 11/11/20.
//

import SwiftUI

struct ActionView: View {
    let  button: CalculatorButton
    @Binding var state: CalculationState
    
    var body: some View {
        Button(action: {
            self.tapped()
        }, label: {
            Text(button.rawValue)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                .background(button.backgroundColor)
                .cornerRadius(buttonHeight())
                
        })
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 4) / 4
    }
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 10 * 4) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 10 * 4) / 4
    }
    
    func tapped() {
        switch button {
        case .ac:
            state.currentNumber = 0
            state.storeNumber = nil
            state.storedAction = nil
        case .equals:
            guard let storedAction = state.storedAction else {return}
            guard let storedNumber = state.storeNumber else {return}
            guard let result = storedAction.calculate(storedNumber, state.currentNumber) else {
                return
            }
            state.currentNumber = result
            state.storeNumber = nil
            state.storedAction = nil
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
            if let number = Double(button.rawValue){
                state.appendNUmber(number)
            }
            
        case .dot:
            break

        case .percent:
            break
        default:
            state.storeNumber = state.currentNumber
            state.currentNumber = 0
            state.storedAction = button
            break 
        }
    }
}
