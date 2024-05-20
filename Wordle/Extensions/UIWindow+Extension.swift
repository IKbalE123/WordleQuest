//
//  UIWindow+Extension.swift
//  WordleQuest Watch Watch App
//
//  Created by ikbal erdal on 2024-01-18.
//
import UIKit

extension UIWindow {
    static var key: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
                  return nil
              }
        return window
    }
}



