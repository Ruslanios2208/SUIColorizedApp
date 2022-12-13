//
//  ContentView.swift
//  SUIColorizedApp
//
//  Created by Руслан Шигапов on 13.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redTextFieldValue = ""
    @State private var greenTextFieldValue = ""
    @State private var blueTextFieldValue = ""
    
    @State private var alertPresented = false
            
    var body: some View {
        ZStack {
            Color(.systemIndigo)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(
                        Color(
                            red: redSliderValue / 255,
                            green: greenSliderValue / 255,
                            blue: blueSliderValue / 255
                        )
                    )
                    .frame(height: 170)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2))
                
                VStack {
                    ColorSliderView(
                        value: $redSliderValue,
                        text: $redTextFieldValue,
                        minTrackColor: .red
                    )
                    ColorSliderView(
                        value: $greenSliderValue,
                        text: $greenTextFieldValue,
                        minTrackColor: .green
                    )
                    ColorSliderView(
                        value: $blueSliderValue,
                        text: $blueTextFieldValue,
                        minTrackColor: .blue
                    )
                }
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done", action: checkValue)
                        .alert("Wrong format", isPresented: $alertPresented, actions: {}) {
                            Text("Enter the number from 0 to 255")
                        }
                }
            }
        }
    }
    
    private func checkValue() {
        // Не смог разобраться в логике
        if let number = Double(redTextFieldValue) {
            if number >= 0, number <= 255 {
                redSliderValue = number
                return
            }
        }
        redTextFieldValue = ""
        alertPresented.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSliderView: View {
    @Binding var value: Double
    @Binding var text: String
    let minTrackColor: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(.white)
                .frame(width: 35)
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(minTrackColor)
            TextField("\(lround(value))", text: $text)
                .textFieldStyle(.roundedBorder)
                .frame(width: 50)
                .keyboardType(.numberPad)
        }
    }
}
