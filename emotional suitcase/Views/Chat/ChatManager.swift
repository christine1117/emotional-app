import SwiftUI
import Foundation

// MARK: - 聊天管理器
class ChatManager: ObservableObject {
    static let shared = ChatManager()
    
    @Published var chatSessions: [ChatSession] = []
    @Published var messages: [UUID: [ChatMessage]] = [:]
    
    private let userDefaults = UserDefaults.standard
    private let sessionsKey = "chatSessions"
    private let messagesKey = "chatMessages"
    
    init() {
        loadData()
        createSampleDataIfNeeded()
    }
    
    // MARK: - 會話管理
    func createNewSession(mode: TherapyMode) -> ChatSession {
        let session = ChatSession(
            title: generateSessionTitle(for: mode),
            therapyMode: mode,
            tags: [mode.shortName]
        )
        
        chatSessions.insert(session, at: 0)
        messages[session.id] = []
        
        // 添加歡迎訊息
        addWelcomeMessage(to: session.id, mode: mode)
        
        saveData()
        return session
    }
    
    func updateSessionMode(_ sessionId: UUID, mode: TherapyMode) {
        if let index = chatSessions.firstIndex(where: { $0.id == sessionId }) {
            chatSessions[index].therapyMode = mode
            chatSessions[index].lastUpdated = Date()
            
            // 添加模式切換訊息
            addMessage(
                to: sessionId,
                content: mode.welcomeMessage,
                isFromUser: false
            )
            
            saveData()
        }
    }
    
    func deleteSession(_ sessionId: UUID) {
        chatSessions.removeAll { $0.id == sessionId }
        messages.removeValue(forKey: sessionId)
        saveData()
    }
    
    // MARK: - 歡迎訊息
    func addWelcomeMessage(to sessionId: UUID, mode: TherapyMode) {
        let welcomeMessage = mode.welcomeMessage
        addMessage(to: sessionId, content: welcomeMessage, isFromUser: false)
    }
    
    // MARK: - 清除訊息
    func clearMessages(for sessionId: UUID) {
        messages[sessionId] = []
        
        // 更新會話信息
        if let index = chatSessions.firstIndex(where: { $0.id == sessionId }) {
            chatSessions[index].lastMessage = ""
            chatSessions[index].lastUpdated = Date()
            chatSessions[index].messageCount = 0
        }
        
        saveData()
    }
    
    // MARK: - 訊息管理
    func addMessage(to sessionId: UUID, content: String, isFromUser: Bool) {
        guard let sessionIndex = chatSessions.firstIndex(where: { $0.id == sessionId }) else { return }
        
        let session = chatSessions[sessionIndex]
        let message = ChatMessage(
            content: content,
            isFromUser: isFromUser,
            mode: session.therapyMode
        )
        
        if messages[sessionId] == nil {
            messages[sessionId] = []
        }
        messages[sessionId]?.append(message)
        
        // 更新會話信息
        chatSessions[sessionIndex].lastMessage = content
        chatSessions[sessionIndex].lastUpdated = Date()
        chatSessions[sessionIndex].messageCount = messages[sessionId]?.count ?? 0
        
        // 如果是用戶的第一條訊息，更新標題
        if isFromUser && messages[sessionId]?.filter({ $0.isFromUser }).count == 1 {
            let title = String(content.prefix(20)) + (content.count > 20 ? "..." : "")
            chatSessions[sessionIndex].title = title
        }
        
        // 將最新會話移到最前面
        let updatedSession = chatSessions[sessionIndex]
        chatSessions.remove(at: sessionIndex)
        chatSessions.insert(updatedSession, at: 0)
        
        saveData()
    }
    
    func getMessages(for sessionId: UUID) -> [ChatMessage] {
        return messages[sessionId] ?? []
    }
    
    // MARK: - AI 回覆生成
    func generateAIResponse(for message: String, mode: TherapyMode) -> String {
        // 簡單的關鍵字回覆系統
        let lowercaseMessage = message.lowercased()
        
        switch mode {
        case .chatMode:
            if lowercaseMessage.contains("壓力") {
                return "聽起來您最近壓力不小。能告訴我是什麼讓您感到有壓力嗎？"
            } else if lowercaseMessage.contains("開心") || lowercaseMessage.contains("高興") {
                return "很高興聽到您心情不錯！是有什麼特別的事情讓您開心嗎？"
            } else if lowercaseMessage.contains("累") || lowercaseMessage.contains("疲憊") {
                return "感覺您很疲憊。最近工作或生活節奏是不是比較緊張？"
            } else if lowercaseMessage.contains("週末") || lowercaseMessage.contains("休息") {
                return "聽起來您需要好好休息一下！有什麼特別想做的嗎？戶外活動、看電影，還是其他的興趣愛好？"
            } else if lowercaseMessage.contains("感受不明") {
                return "感受是很重要的信息。能告訴我這種感受在您身體的哪個部位最明顯嗎？"
            } else {
                return "我理解您的感受。能告訴我更多關於這個情況的細節嗎？"
            }
            
        case .cbtMode:
            if lowercaseMessage.contains("總是") || lowercaseMessage.contains("永遠") {
                return "我注意到您用了「總是」這個詞。讓我們檢視一下這個想法是否準確。能給我一些具體的例子嗎？"
            } else if lowercaseMessage.contains("失敗") || lowercaseMessage.contains("做不好") {
                return "失敗的感受很難受。讓我們分析一下這個想法背後的證據。什麼讓您覺得是失敗？"
            } else if lowercaseMessage.contains("焦慮") || lowercaseMessage.contains("擔心") {
                return "焦慮和擔心是很常見的情緒。讓我們用CBT的方式來分析這些想法，看看哪些是基於事實的。"
            } else {
                return "讓我們用認知行為療法的方式來分析這個問題。首先，我們可以識別一些可能影響您情緒的想法模式。"
            }
            
        case .mbtMode:
            if lowercaseMessage.contains("不理解") || lowercaseMessage.contains("不懂") {
                return "理解他人的想法確實不容易。讓我們試著從心智化的角度來看，您覺得對方可能在想什麼？"
            } else if lowercaseMessage.contains("感受") || lowercaseMessage.contains("情緒") {
                return "感受是很重要的信息。能告訴我這種感受在您身體的哪個部位最明顯嗎？"
            } else if lowercaseMessage.contains("關係") || lowercaseMessage.contains("人際") {
                return "人際關係是複雜的。讓我們一起探索在這個關係中，您和對方各自的感受和需求。"
            } else if lowercaseMessage.contains("感受不明") {
                return "感受混亂時很正常的。讓我們慢慢來，先試著感受一下您現在身體的狀態，有什麼地方特別緊繃或放鬆嗎？"
            } else {
                return "在正念為基礎的療法中，我們關注當下的感受和體驗。讓我們花一點時間覺察您現在的感受。"
            }
        }
    }
    
    // MARK: - 數據持久化
    private func saveData() {
        // 保存會話
        if let sessionsData = try? JSONEncoder().encode(chatSessions) {
            userDefaults.set(sessionsData, forKey: sessionsKey)
        }
        
        // 保存訊息
        if let messagesData = try? JSONEncoder().encode(messages) {
            userDefaults.set(messagesData, forKey: messagesKey)
        }
    }
    
    private func loadData() {
        // 載入會話
        if let sessionsData = userDefaults.data(forKey: sessionsKey),
           let sessions = try? JSONDecoder().decode([ChatSession].self, from: sessionsData) {
            chatSessions = sessions
        }
        
        // 載入訊息
        if let messagesData = userDefaults.data(forKey: messagesKey),
           let loadedMessages = try? JSONDecoder().decode([UUID: [ChatMessage]].self, from: messagesData) {
            messages = loadedMessages
        }
    }
    
    // MARK: - 輔助方法
    private func generateSessionTitle(for mode: TherapyMode) -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日"
        formatter.locale = Locale(identifier: "zh_Hant_TW")
        
        return "\(mode.shortName) - \(formatter.string(from: now))"
    }
    
    // MARK: - 示例數據
    private func createSampleDataIfNeeded() {
        guard chatSessions.isEmpty else { return }
        
        // 創建示例會話
        let sampleSessions = [
            ChatSession(
                title: "工作壓力",
                therapyMode: .cbtMode,
                lastMessage: "讓我們分析一下這些想法",
                lastUpdated: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(),
                tags: ["CBT", "工作"],
                messageCount: 5
            ),
            ChatSession(
                title: "人際關係困擾",
                therapyMode: .mbtMode,
                lastMessage: "我們一起探索這個關係",
                lastUpdated: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
                tags: ["MBT", "人際"],
                messageCount: 3
            ),
            ChatSession(
                title: "週末計畫",
                therapyMode: .chatMode,
                lastMessage: "聽起來很不錯！",
                lastUpdated: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
                tags: ["聊天", "生活"],
                messageCount: 7
            )
        ]
        
        chatSessions = sampleSessions
        
        // 為每個會話創建示例訊息
        for session in sampleSessions {
            let sampleMessages = createSampleMessages(for: session)
            messages[session.id] = sampleMessages
        }
        
        saveData()
    }
    
    private func createSampleMessages(for session: ChatSession) -> [ChatMessage] {
        switch session.therapyMode {
        case .cbtMode:
            return [
                ChatMessage(content: session.therapyMode.welcomeMessage, isFromUser: false, mode: .cbtMode),
                ChatMessage(content: "我最近工作壓力很大，總是擔心做不好", isFromUser: true, mode: .cbtMode),
                ChatMessage(content: "我理解您的擔憂。讓我們用CBT的方式來分析這個問題。當您說「總是擔心做不好」時，這是一個怎樣的想法模式？", isFromUser: false, mode: .cbtMode),
                ChatMessage(content: "就是覺得自己能力不夠，可能會犯錯", isFromUser: true, mode: .cbtMode)
            ]
        case .mbtMode:
            return [
                ChatMessage(content: session.therapyMode.welcomeMessage, isFromUser: false, mode: .mbtMode),
                ChatMessage(content: "和同事相處有些困難，不知道他們在想什麼", isFromUser: true, mode: .mbtMode),
                ChatMessage(content: "人際關係確實複雜。讓我們用心智化的角度來看，您能具體描述一下是什麼樣的互動讓您感到困惑嗎？", isFromUser: false, mode: .mbtMode)
            ]
        case .chatMode:
            return [
                ChatMessage(content: session.therapyMode.welcomeMessage, isFromUser: false, mode: .chatMode),
                ChatMessage(content: "這個週末想做點什麼放鬆的事情", isFromUser: true, mode: .chatMode),
                ChatMessage(content: "聽起來您需要好好休息一下！有什麼特別想做的嗎？戶外活動、看電影，還是其他的興趣愛好？", isFromUser: false, mode: .chatMode)
            ]
        }
    }
    
    // MARK: - 清理數據（測試用）
    func clearAllData() {
        chatSessions.removeAll()
        messages.removeAll()
        userDefaults.removeObject(forKey: sessionsKey)
        userDefaults.removeObject(forKey: messagesKey)
    }
}
