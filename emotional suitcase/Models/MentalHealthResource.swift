// ===== 1. MentalHealthResource.swift =====
import Foundation

enum ResourceAction {
    case hotline
    case guide
    case techniques
    case map
}

struct MentalHealthResource: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let buttonText: String
    let action: ResourceAction
}
