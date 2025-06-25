import SwiftUI

struct AppColors {
    static let orange = Color(red: 0.89, green: 0.49, blue: 0.20) // #E37D33
    static let lightYellow = Color(red: 0.98, green: 0.94, blue: 0.87) // #FAF0DE
    static let darkBrown = Color(red: 0.40, green: 0.26, blue: 0.13) // #664321
    static let mediumBrown = Color(red: 0.55, green: 0.35, blue: 0.20) // #8C5932
    static let lightBrown = Color(red: 0.70, green: 0.55, blue: 0.40) // #B38C66
    
    // 向後兼容的顏色別名
    static let cardBackground = Color.white
    static let lightOrange = orange.opacity(0.3)
    static let reminderGradient = LinearGradient(
        gradient: Gradient(colors: [lightYellow, orange.opacity(0.3)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
