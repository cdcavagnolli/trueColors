import Foundation

struct UserSettings {
    static var sessionlastColor = String()
    static var sessionRed = Int()
    static var sessionGreen = Int()
    static var sessionBlue = Int()
    
    enum Keys: String {
        case red
        case green
        case blue
        case lastColor
    }
    
    static var red: Int {
        get { return UserDefaults.standard.object(forKey: Keys.red.rawValue) as? Int ?? 255 }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.red.rawValue) }
    }
    
    static var green: Int {
        get { return UserDefaults.standard.object(forKey: Keys.green.rawValue) as? Int ?? 255 }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.green.rawValue) }
    }
    
    static var blue: Int {
        get { return UserDefaults.standard.object(forKey: Keys.blue.rawValue) as? Int ?? 255 }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.blue.rawValue) }
    }
    
    static var lastColor: String {
        get { return UserDefaults.standard.object(forKey: Keys.lastColor.rawValue) as? String ?? "#FFFFFF" }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.lastColor.rawValue) }
    }
    
    static func setDefaults() {
        UserSettings.lastColor = UserSettings.sessionlastColor
        UserSettings.red = UserSettings.sessionRed
        UserSettings.green = UserSettings.sessionGreen
        UserSettings.blue = UserSettings.sessionBlue
    }
}
