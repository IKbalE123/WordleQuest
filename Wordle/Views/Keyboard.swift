//
//  Keyboard.swift
//  WordleQuest Watch Watch App
//
//  Created by ikbal erdal on 2024-01-18.
//
import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var dm: WordleDataModel
    var topRowArray = "QWERTYUIOP".map { String($0) }
    var secondRowArray = "ASDFGHJKL".map { String($0) }
    var thirdRowArray = "ZXCVBNM".map { String($0) }

    var body: some View {
        VStack {
            HStack(spacing: 2) {
                ForEach(topRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                        .onTapGesture {
                            dm.addToCurrentWord(letter)
                            if dm.isLimitedTimeModeOn {
                                dm.shouldStartTimer = true // Start the timer when a letter is clicked
                            }
                        }
                }

            }
            HStack(spacing: 2) {
                ForEach(secondRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                        .onTapGesture {
                            dm.addToCurrentWord(letter)
                            if dm.isLimitedTimeModeOn {
                                dm.startTimer()
                            }
                        }
                }
            }
            HStack(spacing: 2) {
                Button {
                    dm.enterWord()
                } label: {
                    Text("Enter")
                }
                .font(.system(size: 20))
                .frame(width: 60, height: 50)
                .foregroundColor(.primary)
                .background(Color.unused)
                .disabled(dm.currentWord.count < 5 || !dm.inPlay)
                .opacity((dm.currentWord.count < 5 || !dm.inPlay) ? 0.6 : 1)
                
                ForEach(thirdRowArray, id: \.self) { letter in
                    LetterButtonView(letter: letter)
                        .onTapGesture {
                            dm.addToCurrentWord(letter)
                            if dm.isLimitedTimeModeOn {
                                dm.startTimer()
                            }
                        }
                }
                
                Button {
                    dm.removeLetterFromCurrentWord()
                } label: {
                    Image(systemName: "delete.backward.fill")
                        .font(.system(size: 20, weight: .heavy))
                        .frame(width: 40, height: 50)
                        .foregroundColor(.primary)
                        .background(Color.unused)
                }
                .disabled(!dm.inPlay || dm.currentWord.count == 0)
                .opacity((!dm.inPlay || dm.currentWord.count == 0) ? 0.6 : 1)
            }
        }
    }
}



