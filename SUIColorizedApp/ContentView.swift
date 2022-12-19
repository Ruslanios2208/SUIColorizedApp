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
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        ZStack {
            Color(.systemIndigo)
                .ignoresSafeArea()
                .onTapGesture {
                    isInputActive = false
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
                    ColorSliderView(value: $green, color: .green)
                    ColorSliderView(value: $blue, color: .blue)
                }
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
