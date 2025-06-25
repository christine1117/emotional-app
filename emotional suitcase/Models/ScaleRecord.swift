import Foundation
import SwiftUI

enum ScaleType: String, CaseIterable, Codable {
    case phq9 = "PHQ9"
    case gad7 = "GAD7"
    case bsrs5 = "BSRS5"
    case rfq8 = "RFQ8"
    
    var fullName: String {
        switch self {
        case .phq9: return "憂鬱症篩檢量表"
        case .gad7: return "廣泛性焦慮量表"
        case .bsrs5: return "簡式健康量表"
        case .rfq8: return "反思功能問卷"
        }
    }
    
    var color: Color {
        switch self {
        case .phq9: return Color(red: 0.7, green: 0.5, blue: 0.3)
        case .gad7: return AppColors.mediumBrown
        case .bsrs5: return AppColors.orange
        case .rfq8: return Color(red: 0.95, green: 0.75, blue: 0.30)
        }
    }
    
    var maxScore: Int {
        switch self {
        case .phq9: return 27
        case .gad7: return 21
        case .bsrs5: return 20
        case .rfq8: return 56
        }
    }
}

struct ScaleRecord: Identifiable, Codable {
    let id = UUID()
    let type: ScaleType
    var score: Int
    var answers: [Int]
    let date: Date
    
    var severityLevel: String {
        switch type {
        case .phq9:
            switch score {
            case 0...4: return "輕微"
            case 5...9: return "輕度"
            case 10...14: return "中度"
            case 15...19: return "中重度"
            default: return "重度"
            }
        case .gad7:
            switch score {
            case 0...4: return "輕微"
            case 5...9: return "輕度"
            case 10...14: return "中度"
            default: return "重度"
            }
        case .bsrs5:
            switch score {
            case 0...5: return "正常"
            case 6...9: return "輕度"
            case 10...14: return "中度"
            default: return "重度"
            }
        case .rfq8:
            return score > 28 ? "良好" : "需改善"
        }
    }
}
