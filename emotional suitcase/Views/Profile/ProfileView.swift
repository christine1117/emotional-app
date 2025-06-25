import SwiftUI

struct ProfileView: View {
    @State private var selectedMood: String = "平靜"
    @StateObject private var emergencyManager = EmergencyDataManager()
    @StateObject private var profileManager = ProfileDataManager()
    @State private var showingEmergencySheet = false
    @State private var showingSafeBox = false
    @State private var showingSupportPlan = false
    @State private var showingMoodSelector = false
    @State private var showingSafetyPlan = false
    
    let moodOptions = ["平靜", "開心", "難過", "生氣", "焦慮"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 個人資訊卡片
                PersonalInfoCard(
                    profileData: profileManager.profileData,
                    selectedMood: $selectedMood,
                    onMoodTap: { showingMoodSelector = true }
                )
                
                // 情緒行李箱區塊
                EmotionalToolboxSection(
                    showingSafeBox: $showingSafeBox,
                    showingSupportPlan: $showingSupportPlan,
                    showingSafetyPlan: $showingSafetyPlan
                )
                
                // 今日提醒卡片
                DailyReminderCard(
                    quote: profileManager.profileData.todayQuote,
                    onRefresh: { profileManager.updateQuote() }
                )
                
                // 緊急聯絡卡片
                EmergencyContactSection()
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .background(AppColors.lightYellow)
        .sheet(isPresented: $showingSafeBox) {
            SafeBoxView()
        }
        .sheet(isPresented: $showingSupportPlan) {
            SupportPlanView()
        }
        .sheet(isPresented: $showingSafetyPlan) {
            SafetyPlanView()
        }
        .sheet(isPresented: $showingMoodSelector) {
            MoodSelectorView(selectedMood: $selectedMood)
        }
        .onAppear {
            // 載入範例數據的邏輯可以在這裡處理
        }
    }
}

struct MoodSelectorView: View {
    @Binding var selectedMood: String
    @Environment(\.dismiss) private var dismiss
    
    let moods = [
        ("😌", "平靜", Color(red: 0.95, green: 0.75, blue: 0.30)),
        ("😊", "開心", Color(red: 1.0, green: 0.6, blue: 0.3)),
        ("😢", "難過", Color(red: 0.5, green: 0.7, blue: 1.0)),
        ("😠", "生氣", Color(red: 1.0, green: 0.5, blue: 0.5)),
        ("😰", "焦慮", Color(red: 0.8, green: 0.6, blue: 1.0))
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("今天的心情如何？")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.darkBrown)
                    .padding(.top)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    ForEach(moods, id: \.1) { emoji, mood, color in
                        Button(action: {
                            selectedMood = mood
                            dismiss()
                        }) {
                            VStack(spacing: 8) {
                                Text(emoji)
                                    .font(.largeTitle)
                                
                                Text(mood)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 80, height: 80)
                            .background(selectedMood == mood ? color : color.opacity(0.3))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .background(AppColors.lightYellow)
            .navigationTitle("記錄心情")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                    .foregroundColor(AppColors.darkBrown)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
