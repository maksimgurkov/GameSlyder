//
//  ContentView.swift
//  GameSlyder
//
//  Created by Максим Гурков on 02.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = 50.0
    @State private var alert = false
    @State private var section = 0
    var settingsColor = ["red", "green", "yellow"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Picker(selection: $section,
                               label: Text("Настройка цвета бегунка")) {
                            // Алексей подскажите как решить эту проблему с ворнингом заранее спасибо :)
                            ForEach(0..<settingsColor.count) {
                                Text(settingsColor[$0])
                            }
                        }
                    }
                }
                .padding(.bottom, 200)
                VStack {
                    Text("Пододвинь слайдер как можно ближе к: \(targetValue)")
                    
                    HStack {
                        Text("0")
                        UISliderRepresentation(value: $currentValue, color: colorRunner(), alpha: computeScore())
                        Text("100")
                    }
                    Button("Проверь меня") {
                        alert.toggle()
                    }
                    .alert( "Твой счет", isPresented: $alert, actions: {}) {
                        Text("\(computeScore())")
                    }
                    
                    .padding()
                    Button("Начать заново") {
                        targetValue = Int.random(in: 0...100)
                        currentValue = 50.0
                    }
                    .padding(.bottom, 200)
                }
                .padding()
            }
            .navigationTitle("GameSlider")
        }
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func colorRunner() -> UIColor {
        var color: UIColor = .black
        if section == 0 {
            color = .red
        } else if section == 1 {
            color = .green
        } else if section == 2 {
            color = .yellow
        }
        return color
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
