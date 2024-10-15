//
//  ContentView.swift
//  Edutainment-project
//
//  Created by jerry on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var userAnswer = 0
    @State private var score = 0
    
    //track which question were on
    @State private var questionNumber = 0
    
    //allows user time to adjust settings
    @State private var startGame = false
    @State private var gameOverAlert = false
    @State private var showScoreAlert = false
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    //holds questions
    @State private var questionsAvailable: [DifferentQuestion] = [].shuffled()
    
    //tracks when numpad is shown
    @FocusState private var numpadActive: Bool
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section("select multiplication table") {
                    Stepper("\(multiplicationTable)", value: $multiplicationTable, in: 2...12)
                        .padding(.horizontal,20)
                }
                .disabled(startGame)
                
                Section("select number of questions") {
                    Stepper("\(numberOfQuestions)", value: $numberOfQuestions, in: 5...20, step: 5)
                        .padding(.horizontal,20)
                }
                .disabled(startGame)
                
                Section {
                    //starts game
                    Button {
                        startGame.toggle()
                        
                        //generates question when button is pressed
                        generateQuestions()
                        
                    } label: {
                        Text("start")
                    }
                    .buttonStyle(.borderless)
                    .opacity(startGame ? 0.0 : 1.0)
                    .disabled(startGame)
                    .listRowBackground(Color.clear)
                }
                
                //shows questions after start button is pressed
                if startGame {
                    
                    //title shows the question number were on
                    Section("question \(questionNumber + 1)") {
                        VStack {
                            
                            //submit button
                            HStack {
                                Spacer()
                                Button {
                                    showScoreAlert.toggle()
                                    checkAnswer()
                                } label: {
                                    Text("check answer")
                                }
                                .buttonStyle(.borderless)
                            }
                            
                            //background image
                            Image("chalkboard")
                                .resizable()
                                .renderingMode(.original)
                                .frame(maxWidth: 300, maxHeight: 300)
                                .border(Color.yellow, width: 5)
                                .overlay {
                                    
                                    //shows question
                                    HStack {
                                        questionsAvailable[questionNumber]
                                            .foregroundStyle(.white)
                                            .font(.title)
                                        
                                        //user answer input
                                        TextField("answer", value: $userAnswer, format: .number)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .frame(maxWidth: 100)
                                            .keyboardType(.numberPad)
                                            .padding(5)
                                            .focused($numpadActive)
                                    }
                                }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .navigationTitle("multiplication table")
            .toolbar {
                
                //restarts game anytime
                ToolbarItem(placement: .topBarTrailing) {
                    Button("restart") {
                        restartGame()
                    }
                }
                
                //allows for numpad to be toggled off when active
                ToolbarItemGroup(placement: .keyboard) {
                    if numpadActive {
                        Spacer()
                        
                        Button("done") {
                            numpadActive = false
                        }
                    }
                }
            }
            
            //next question alert
            .alert(alertTitle, isPresented: $showScoreAlert, actions: {
                Button("continue") {
                    nextQuestion()
                }
            }, message: {
                Text(alertMessage)
            })
            
            //game over alert
            .alert(alertTitle, isPresented: $gameOverAlert) {
                Button("play again") {
                    restartGame()
                }
            } message: {
                Text(alertMessage)
            }
        }
    }

    //creates 25 questions
    func generateQuestions() {
        for _ in 1...25 {
            
            //random number used to multiply against the multiplication table value
            let randomValue = Int.random(in: 1...50)
            
            //struct instance
            let question = DifferentQuestion(multiplicationTable: multiplicationTable, randomNumber: randomValue)
            
            //adds to array
            questionsAvailable.append(question)
        }
    }
    
    //reverts values back to default
    func restartGame() {
        questionNumber = 0
        
        score = 0
        multiplicationTable = 2
        numberOfQuestions = 5
        questionsAvailable = []
        startGame = false
    }
    
    //compares user answer to the correct answer
    func checkAnswer() {

        //gets value from the question array depending on the question number were on
        let randomNumber = questionsAvailable[questionNumber].randomNumber
        let correctAnswer = multiplicationTable * randomNumber
        
        if userAnswer == correctAnswer {
            alertTitle = "correct!"
            alertMessage = "good job!"
            score += 1
        }
        else {
            alertTitle = "wrong!"
            alertMessage = "\(multiplicationTable) x \(randomNumber) = \(correctAnswer)"
        }
    }
    
    //tracks questions status
    func nextQuestion() {
        userAnswer = 0
        
        //goes to the next index position in array
        questionNumber += 1
        
        //ends game if number of  question setting limit is reached
        if questionNumber >= numberOfQuestions {
            gameOverAlert = true
            alertTitle = "game over"
            alertMessage = "correct: \(score) wrong: \(questionNumber - score)"
        }
    }
    
}


//question
struct DifferentQuestion: View {
    let multiplicationTable: Int
    let randomNumber: Int
    
    var body: some View {
        HStack {
            Text("\(multiplicationTable) x \(randomNumber) = ")
        }
    }
}


#Preview {
    ContentView()
}
