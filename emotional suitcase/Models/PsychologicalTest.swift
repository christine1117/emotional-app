import Foundation

enum TestAction {
    case phq9, gad7, bsrs5, rfq8
}

struct PsychologicalTest: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let duration: String
    let questions: String
    let lastTaken: String
    let action: TestAction
}
