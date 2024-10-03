//
//  ContentView.swift
//  WordScramble-project
//
//  Created by jerry on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    
    //properties
    @State private var usedWords: [String] = []
    @State private var startingWord: String = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorMessage = ""
    @State private var errorTitle: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        NavigationStack {
            List {
                
                Section {
                    TextField("enter your word", text: $newWord)
                        //turns off auto caps in text field
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    //using self would cause issues if there duplicates
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                Section {
                    VStack(alignment:.leading) {
                        Text("score: \(score)")
                        
                        VStack(alignment:.leading) {
                            Text("points")
                            Text("any word = +1")
                            Text("4 letter word = +3")
                            Text("5 letter word = +5")
                            Text("6 letter word = +7")
                        }
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .navigationTitle(startingWord)
            
            //calls method when return key is pressed
            .onSubmit() {
                addNewWord()
            }
            .onAppear(perform: {
                startGame()
            })
            .alert(errorTitle, isPresented: $showAlert) {
                Button("Ok") {}
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("restart") {
                        resetGame()
                    }
                }
            }
        }
    }
    
    
    //handles score
    func trackScore(word: String) {
        
        if word.count >= 6 {
            score = score + 8
        }
        else if word.count >= 5 {
            score = score + 6
        }
        else if word.count >= 4 {
            score = score + 4
        }
        else {
            score = score + 1
        }
    }
    
    
    //checks if word is same as starting word
    func isWordSameAsRoot(word: String) -> Bool {
        
        if word == startingWord {
            return false
        }
        return true
    }
    
    
    //holds alert messages
    func wordError(message: String, title: String) {
        errorTitle = title
        errorMessage = message
        showAlert = true
    }
    
    
    //checks if word exists in uitextchecker built-in dictionary
    func isWordReal(word: String) -> Bool {
        
        let spellChecker = UITextChecker()
        
        //creates a nsrange to scan the entire length of the word
        let wordRange = NSRange(location: 0, length: word.utf16.count)
        
        //if it finds words spelled worng it'll provide the nsrange location
        //if everythings ok it'll provide nsnotfound
        let checkForWrongWords = spellChecker.rangeOfMisspelledWord(in: word, range: wordRange, startingAt: 0, wrap: false, language: "en")
        
        return checkForWrongWords.location == NSNotFound
    }
    
    
    //checks if you can spell the word using the starting word
    func isWordPossible(word: String) -> Bool {
        
        var startingWordCopy = startingWord
        
        for letter in word {
            
            //unwraps startingWordCopy
            //checks if the letter from the word being looped through exists in the startingWordCopy and removes it at that index
            if let letterPosition = startingWordCopy.firstIndex(of: letter) {
                startingWordCopy.remove(at: letterPosition)
            }
            else {
                return false
            }
        }
        return true
    }
    
    
    //if the used words array contains the inputed word return false
    func isWordOrignial(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    
    //resets game back to default and generates new word
    func resetGame() {
        startGame()
        usedWords = []
        score = 0
    }
    
    
    //generates a word from list provided
    func startGame() {
        
        //tries to open the start.txt file
        if let openFile = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            //if the file exists, get the content from file
            if let getContent = try? String(contentsOf: openFile) {
                
                //splits the content into a array of strings at each new line found
                let stringSplit = getContent.components(separatedBy: "\n")
                
                //assigns the starting word to one of the random strings that were split up into an array
                startingWord = stringSplit.randomElement() ?? "gotcha"
                
                return
            }
        }
        
        //generates crash report if we end up here
        fatalError("could not load start.txt from bundle!")
    }
    
    
    //adds the accepted word to list
    func addNewWord() {
        
        let formattedWord = newWord.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        //checks used for word validity
        guard isWordSameAsRoot(word: formattedWord) else {
            wordError(message: "try something other than our start word", title: "same as our start word")
            return
        }
        
        guard formattedWord.count >= 3 else {
            wordError(message: "make sure it's at least 3 letters", title: "word is too short!")
            return
        }
        
        guard isWordOrignial(word: formattedWord) else {
            wordError(message: "be more original", title: "word used already!")
            return
        }
        
        guard isWordPossible(word: formattedWord) else {
            wordError(message: "you can't spell that word from \(startingWord)", title: "word not possible!")
            return
        }
        
        guard isWordReal(word: formattedWord) else {
            wordError(message: "you can't just make them up, you know.", title: "word not recognized!")
            return
        }
        
        //default animation slides the new words appended to the list into UI
        withAnimation {
            usedWords.insert(formattedWord, at: 0)
            trackScore(word: formattedWord)
        }
        self.newWord = ""
    }
}

#Preview {
    ContentView()
}
