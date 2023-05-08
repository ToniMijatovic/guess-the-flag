//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Toni Mijatovic on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showingEnd = false
    
    @State private var countries = ["Estonia", "France", "Germany","Ireland", "Italy","Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionCount = 0
    
    var body: some View {
       
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                          flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
 
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("You have reached the end of the game.", isPresented: $showingEnd) {
            Button("Restart", action: restart)
        } message: {
            Text("Your final score is \(score)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score+=1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number]) "
        }
        questionCount+=1
        
        showingScore = true
        
        if questionCount == 8 {
            showingEnd = true
        }
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart () {
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
