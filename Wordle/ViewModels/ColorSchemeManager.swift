//
//  ColorSchemeManager.swift
//  WordleQuest Watch Watch App
//
//  Created by ikbal erdal on 2024-01-18.
//
import SwiftUI

enum ColorScheme: Int {
    case unspecified, light, dark
}

class ColorSchemeManager: ObservableObject {
    @AppStorage("colorScheme") var colorScheme: ColorScheme = .unspecified {
        didSet {
            applyColorScheme()
        }
    }
    
    func applyColorScheme() {
        UIWindow.key?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: colorScheme.rawValue)!
    }
}



