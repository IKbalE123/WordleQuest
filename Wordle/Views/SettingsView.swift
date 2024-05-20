//
//  SettingsView.swift
//  WordleQuest Watch Watch App
//
//  Created by ikbal erdal on 2024-01-18.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var csManager: ColorSchemeManager
    @EnvironmentObject var dm: WordleDataModel
    @Environment(\.dismiss) var dismiss
    @AppStorage("LimitedTimeMode") var isLimitedTimeModeOn: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Modes")) {
                    Toggle("Hard Mode", isOn: $dm.hardMode)
                    Text("Enables a more challenging version of the game where guesses must follow previous hints.")
                        .font(.caption)
                        .foregroundColor(.gray)

                    Toggle("Limited Time Mode", isOn: $isLimitedTimeModeOn)
                        .onChange(of: isLimitedTimeModeOn) { newValue in
                            dm.isLimitedTimeModeOn = newValue
                            if newValue {
                                dm.startTimer()
                            } else {
                                dm.stopTimer()
                            }
                        }
                    Text("Race against the clock to guess the hidden word!")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Section(header: Text("Appearance")) {
                    Text("Change Theme")
                    Picker("Display Mode", selection: $csManager.colorScheme) {
                        Text("Dark").tag(ColorScheme.dark)
                        Text("Light").tag(ColorScheme.light)
                        Text("System").tag(ColorScheme.unspecified)
                    }
                    .pickerStyle(.segmented)
                }
                // Additional settings can be added here
            }
            .navigationTitle("Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ColorSchemeManager())
            .environmentObject(WordleDataModel())
    }
}



