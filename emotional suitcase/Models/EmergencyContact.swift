import SwiftUI
import Foundation

// ===== 數據模型定義 =====

struct EmergencyContact: Identifiable, Codable {
    let id: UUID
    var name: String
    var phone: String
    var relationship: String
    
    init(id: UUID = UUID(), name: String, phone: String, relationship: String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.relationship = relationship
    }
}

struct SupportEntry: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var icon: String
    var date: Date
    
    init(id: UUID = UUID(), title: String, content: String, icon: String = "heart.fill", date: Date = Date()) {
        self.id = id
        self.title = title
        self.content = content
        self.icon = icon
        self.date = date
    }
}

// ===== 數據管理器 =====

class EmergencyDataManager: ObservableObject {
    @Published var emergencyContacts: [EmergencyContact] = []
    @Published var supportEntries: [SupportEntry] = []
    @Published var friendContacts: [EmergencyContact] = []
    @Published var professionalContacts: [EmergencyContact] = []
    
    init() {
        loadSampleData()
    }
    
    // MARK: - Emergency Contacts (舊版兼容)
    func addContact(name: String, phone: String, relationship: String) {
        let contact = EmergencyContact(name: name, phone: phone, relationship: relationship)
        emergencyContacts.append(contact)
    }
    
    func deleteContact(_ contact: EmergencyContact) {
        emergencyContacts.removeAll { $0.id == contact.id }
    }
    
    // MARK: - Friend Contacts (親友聯絡人)
    func addFriendContact(name: String, phone: String, relationship: String) {
        let contact = EmergencyContact(name: name, phone: phone, relationship: relationship)
        friendContacts.append(contact)
    }
    
    func deleteFriendContact(_ contact: EmergencyContact) {
        friendContacts.removeAll { $0.id == contact.id }
    }
    
    // MARK: - Professional Contacts (專業聯絡人)
    func addProfessionalContact(name: String, phone: String, relationship: String) {
        let contact = EmergencyContact(name: name, phone: phone, relationship: relationship)
        professionalContacts.append(contact)
    }
    
    func deleteProfessionalContact(_ contact: EmergencyContact) {
        professionalContacts.removeAll { $0.id == contact.id }
    }
    
    // MARK: - Support Entries
    func addSupportEntry(title: String, content: String, icon: String = "heart.fill") {
        let entry = SupportEntry(title: title, content: content, icon: icon)
        supportEntries.append(entry)
    }
    
    func deleteSupportEntry(_ entry: SupportEntry) {
        supportEntries.removeAll { $0.id == entry.id }
    }
    
    // MARK: - Sample Data
    private func loadSampleData() {
        // 載入範例緊急聯絡人 (舊版兼容)
        if emergencyContacts.isEmpty {
            emergencyContacts = [
                EmergencyContact(name: "家人", phone: "0912-345-678", relationship: "家人"),
                EmergencyContact(name: "好友小王", phone: "0987-654-321", relationship: "朋友")
            ]
        }
        
        // 載入範例親友聯絡人
        if friendContacts.isEmpty {
            friendContacts = [
                EmergencyContact(name: "小華", phone: "0987-654-321", relationship: "好友"),
                EmergencyContact(name: "媽媽", phone: "0923-456-789", relationship: "家人")
            ]
        }
        
        // 載入範例專業聯絡人
        if professionalContacts.isEmpty {
            professionalContacts = [
                EmergencyContact(name: "李醫師", phone: "0987-654-321", relationship: "心理師")
            ]
        }
        
        // 載入範例支援項目
        if supportEntries.isEmpty {
            supportEntries = [
                SupportEntry(title: "家人的愛", content: "記住家人總是支持我的", icon: "heart.fill"),
                SupportEntry(title: "美好回憶", content: "那些讓我微笑的時刻", icon: "star.fill"),
                SupportEntry(title: "未來的夢想", content: "我想要實現的目標", icon: "sparkles")
            ]
        }
    }
}
