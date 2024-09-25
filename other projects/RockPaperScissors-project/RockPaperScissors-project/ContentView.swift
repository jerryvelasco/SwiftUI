////
////  ContentView.swift
////  RockPaperScissors-project
////
////  Created by jerry on 9/24/24.
////

import SwiftUI

enum SheetActions {
    case dismissed, swipedDown
}
enum PossibleWinners {
    case computer, user, tie
}

struct ResultScreen: View {
    let usersChoice: String
    let computersChoice: String
    @Binding var isActive: Bool
    @Binding var action: SheetActions
    @Binding var winner: PossibleWinners
    
    var winnerIs: String {
        
        if computersChoice == usersChoice {
            winner = .tie
            return "it's a tie!"
        }
        
        else if usersChoice == "rock" && computersChoice == "scissors" || usersChoice == "scissors" && computersChoice == "paper" || usersChoice == "paper" && computersChoice == "rock" {
            winner = .user
            return "you win!"
        }
        
        else {
            winner = .computer
            return "computer wins!"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text(winnerIs)
                    .font(.title2)
                
                Spacer()
                VStack {
                    Text("your choice:")
                    
                    Image(usersChoice)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color("colorSchemes"))
                        .frame(maxWidth: 30, maxHeight: 30)
                    
                    Text(usersChoice)
                        .font(.title3)
                        .foregroundStyle(.blue)
                }
                Spacer()
                VStack {
                    Text("computers choice:")
                    
                    Image(computersChoice)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color("colorSchemes"))
                        .frame(maxWidth: 30, maxHeight: 30)
                    
                    Text(computersChoice)
                        .font(.title3)
                        .foregroundStyle(.blue)
                }
                Spacer()
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(action: {
                        isActive = false
                        action = .dismissed
                        
                    }, label: {
                        Text("Dismiss")
                    })
                }
            }
        }
    }
}

struct ContentView: View {
    
    let possibleMoves: [String] = ["rock", "paper", "scissors"]
    
    @State private var computersChoice: String = ""
    @State private var usersChoice: String = ""
    @State private var score: Int = 0
    @State private var gameAttempts: Int = 0
    @State private var gamesLoss: Int = 0
    @State private var randomMove: Int = Int.random(in: 0...2)
    @State private var isGameOver: Bool = false
    
    @State private var showResultScreen: Bool = false
    @State private var moveSelected: Bool = false
    @State var sheetAction: SheetActions = SheetActions.swipedDown
    @State var players: PossibleWinners = PossibleWinners.tie
    
    var body: some View {
        NavigationStack {
            HStack {
                
                Text("says...shoot")
                    .font(.title3)
                    .padding(.leading, 20)
                
                Spacer()
            }
            VStack {
                Spacer()
                Spacer()
                Text(moveSelected ? "you selected: \(usersChoice)" : "pick your choice:")
                
                Spacer()
                HStack(spacing: 50) {
                    
                    //button tracks what and when the user selected a move
                    ForEach(possibleMoves, id: \.self) { move in
                        
                        Button {
                            usersChoice = move
                            moveSelected.toggle()
                            generateNumber()
                            computersChoice = possibleMoves[randomMove]
                            
                        } label: {
                            VStack {
                                
                                Image(move)
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundStyle(Color("colorSchemes"))
                                    .frame(maxWidth: 30, maxHeight: 30)
                                
                                Text(move)
                                    .font(.title3)
                            }
                        }
                    }
                }
                Spacer()
                
                //button appears when a move is selected by the user
                Button(action: {
                    
                    showResultScreen.toggle()
                }, label: {
                    
                    Text("start game")
                        .frame(width: 100, height: 50)
                        .foregroundStyle(Color("colorSchemes"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .background(Color("startButton"))
                        .border(.white)
                        .shadow(color: Color("colorSchemes").opacity(0.5), radius: 15, x: 0.0, y: 0.0)
                        .disabled(!moveSelected)
                        .opacity(moveSelected ? 1.0 : 0.0)
                })
                
                //shows sheet when the button is clicked
                .sheet(isPresented: $showResultScreen, onDismiss: {
                    calculateScore()
                    checkNumberOfGames()
                    
                    if sheetAction == .swipedDown {
                        moveSelected = false
                    }
                    else if sheetAction == .dismissed {
                        moveSelected = false
                    }
                }, content: {
                    ResultScreen(usersChoice: usersChoice, computersChoice: computersChoice, isActive: $showResultScreen, action: $sheetAction, winner: $players)
                })
                
                //alert shows when the game limit is reached
                .alert("game over!", isPresented: $isGameOver) {
                    Button(action: {
                        restartGame()
                    }, label: {
                        Text("restart")
                    })
                } message: {
                    Text("win: \(score) loss: \(gamesLoss) tie: \(gameAttempts - score - gamesLoss)")
                }
                
                Spacer()
                Text("score: \(score)")
                Spacer()
            }
            .navigationTitle(Text("rock, paper, scissors"))
        }
    }
    
    //starts new game
    func restartGame() {
        gamesLoss = 0
        gameAttempts = 0
        score = 0
        isGameOver = false
    }
    
    //controls the game limit
    func checkNumberOfGames() {
        if gameAttempts == 5 {
            isGameOver = true
        }
    }
    
    //generates random number used for computers move selection
    func generateNumber() {
        randomMove = Int.random(in: 0...2)
    }
    
    //keeps track of score based on result of game
    func calculateScore() {
        gameAttempts += 1
        if players == .user {
            score += 1
        } else if players == .computer {
            gamesLoss += 1
        }
    }
}

#Preview {
    ContentView()
}
