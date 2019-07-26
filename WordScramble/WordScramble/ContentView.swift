//
//  ContentView.swift
//  WordScramble
//
//  Created by ioannis giannakidis on 26/7/19.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentWord = ""
    @State private var usedWords = [String]()
    @State private var newWord = ""
    
    var body: some View {
        NavigationView{
            VStack {
                TextField($newWord) {
                    UIApplication.shared.keyWindow?.endEditing(true)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                List(usedWords.identified(by:\.self )) { word in
                    Text(word)
                    
                }
            }
            .navigationBarTitle(Text(currentWord))
                .onAppear(){
                    self.startGame()
            }
        }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf:startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                currentWord = allWords.randomElement() ?? "Arxidia"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    func isOriginal(word:String)-> Bool {
        !usedWords.contains(word)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
