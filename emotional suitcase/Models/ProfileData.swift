import Foundation

struct ProfileData: Identifiable {
    let id = UUID()
    var name: String
    var todayMood: String
    var checkInDays: Int
    var todayQuote: String
}

class ProfileDataManager: ObservableObject {
    @Published var profileData = ProfileData(
        name: "小美",
        todayMood: "平靜",
        checkInDays: 7,
        todayQuote: "你的故事還沒有結束，最精彩的篇章還在後面"
    )
    
    func updateQuote() {
        let quotes = [
            "你的故事還沒有結束，最精彩的篇章還在後面",
            "每一天都是新的開始，充滿無限可能",
            "你比你想像的更堅強，更勇敢",
            "困難只是暫時的，但你的勇氣是永恆的",
            "相信自己，你已經走了這麼遠"
        ]
        profileData.todayQuote = quotes.randomElement() ?? profileData.todayQuote
    }
}
