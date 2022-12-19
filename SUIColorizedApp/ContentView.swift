//
//  ContentView.swift
//  SUIColorizedApp
//
//  Created by Руслан Шигапов on 13.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            Color(.systemIndigo)
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            
            VStack(spacing: 30) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(
                        Color(
                            red: red / 255,
                            green: green / 255,
                            blue: blue / 255
                        )
                    )
                    .frame(height: 170)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2))
                
                VStack {
                    ColorSliderView(value: $red, color: .red)
                        .focused($focusedField, equals: .red)
                    ColorSliderView(value: $green, color: .green)
                        .focused($focusedField, equals: .green)
                    ColorSliderView(value: $blue, color: .blue)
                        .focused($focusedField, equals: .blue)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

extension ContentView {
    private enum Field {
        case red, green, blue
    }
    
    private func nextField() {
        switch focusedField {
        case .red:
            focusedField = .green
        case .green:
            focusedField = .blue
        case .blue:
            focusedField = .red
        case .none:
            focusedField = nil
        }
    }
    
    private func previousField() {
        switch focusedField {
        case .red:
            focusedField = .blue
        case .green:
            focusedField = .red
        case .blue:
            focusedField = .green
        case .none:
            focusedField = nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
