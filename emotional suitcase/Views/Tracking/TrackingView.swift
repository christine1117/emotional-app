// TrackingView.swift
import SwiftUI

struct TrackingView: View {
    @StateObject private var trackingManager = TrackingDataManager()
    @State private var selectedTab = 0
    @State private var showingMoodAnalysis = false
    @State private var showingHealthRecommendations = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 頂部標題 - 增加間距避免重疊
            HStack {
                Text("追蹤")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.darkBrown)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)  // 增加上方間距
            .padding(.bottom, 10)  // 增加下方間距
            
            // 自定義分頁控制器
            TrackingTabView(selectedTab: $selectedTab)
            
            // 分頁內容
            TabView(selection: $selectedTab) {
                MoodDiaryView(
                    trackingManager: trackingManager,
                    showingAnalysis: $showingMoodAnalysis
                )
                .tag(0)
                
                HealthDataView(
                    trackingManager: trackingManager,
                    showingRecommendations: $showingHealthRecommendations
                )
                .tag(1)
                
                ScaleTrackingView(trackingManager: trackingManager)
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: selectedTab)
        }
        .background(AppColors.lightYellow)
        .sheet(isPresented: $showingMoodAnalysis) {
            MonthlyMoodAnalysisView(trackingManager: trackingManager)
        }
        .sheet(isPresented: $showingHealthRecommendations) {
            HealthRecommendationView(trackingManager: trackingManager)
        }
    }
}

#Preview {
    TrackingView()
}
