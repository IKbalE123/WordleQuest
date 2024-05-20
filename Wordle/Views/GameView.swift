//
//  GameView.swift
//  WordleQuest Watch Watch App
//
//  Created by ikbal erdal on 2024-01-18.
//
import SwiftUI
struct GameView: View {
    @EnvironmentObject var dm: WordleDataModel
    @State private var showSettings = false
    @State private var showHelp = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if Global.screenHeight < 600 {
                        Text("")
                    }
                    Spacer()
                    VStack(spacing: 3) {
                        ForEach(0...5, id: \.self) { index in
                            GuessView(guess: $dm.guesses[index])
                                .modifier(Shake(animatableData: CGFloat(dm.incorrectAttempts[index])))
                        }
                    }
                    .frame(width: Global.boardWidth, height: 6 * Global.boardWidth / 5)
                    Spacer()
                    Keyboard()
                        .scaleEffect(Global.keyboardScale)
                        .padding(.top)
                    Spacer()
                }
                .disabled(dm.showStats)
                .navigationBarTitleDisplayMode(.inline)
                .overlay(alignment: .top) {
                    if let toastText = dm.toastText {
                        ToastView(toastText: toastText)
                            .offset(y: 20)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            if !dm.inPlay {
                                Button {
                                    dm.newGame()
                                } label: {
                                    Text("New")
                                        .foregroundColor(.primary)
                                }
                            }
                            Button {
                                showHelp.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("WQ")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(dm.hardMode ? Color(.systemRed) : .primary)
                                .minimumScaleFactor(0.5)
                            // This Text view displays the remaining time
                            if dm.isLimitedTimeModeOn {
                                Text("\(dm.remainingTime) seconds left")
                                    .font(.system(size: 15)) // Increase the font size as needed
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                withAnimation {
                                    dm.currentStat = Statistic.loadStat()
                                    dm.showStats.toggle()
                                }
                            } label: {
                                Image(systemName: "chart.bar")
                            }
                            Button {
                                showSettings.toggle()
                            } label: {
                                Image(systemName: "gearshape.fill")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
            if dm.showStats {
                StatsView()
            }
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $showHelp) {
            HelpView()
        }
        .onReceive(dm.$timerExpired) { timerExpired in
            if timerExpired {
                // Display the correct word
                    


                
                // Show statistics after a delay (adjust the delay as needed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    // Wrap the state changes within the withAnimation block
                    withAnimation {
                        dm.currentStat = Statistic.loadStat()
                        dm.showStats.toggle()
                    }
                }
                
                
                struct GameView_Previews: PreviewProvider {
                    static var previews: some View {
                        GameView()
                            .environmentObject(WordleDataModel())
                    }
                }
                
            }
        }
    }
}



