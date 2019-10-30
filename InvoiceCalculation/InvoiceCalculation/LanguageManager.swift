//
//  LanguageManager.swift
//  InvoiceCalculation
//
//  Created by Hehuimin on 2019/10/8.
//  Copyright © 2019 Hehuimin. All rights reserved.
//

import Foundation

private let kLanguageManager: String = "kLanguageManager"
private let AppleLanguages: String = "AppleLanguages"

class LanguageManager: NSObject {
    public static var userLanguage: String {
        get {
            return UserDefaults.standard.value(forKey: kLanguageManager) as! String
        }
        
        set {
            if newValue.isEmpty {
                resetSystemLanguage()
                return
            }
            
            UserDefaults.standard.setValue(newValue, forKey: kLanguageManager)
            UserDefaults.standard.setValue([newValue], forKey: AppleLanguages)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static func resetSystemLanguage() {
        UserDefaults.standard.removeObject(forKey: kLanguageManager)
        UserDefaults.standard.setValue(nil, forKey: AppleLanguages)
        UserDefaults.standard.synchronize()
    }
}
