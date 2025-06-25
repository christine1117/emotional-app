import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 首頁
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首頁")
                }
                .tag(0)
            
            // 聊天
            ChatListView()
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                    Text("聊天")
                }
                .tag(1)
            
            // 追蹤
            TrackingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("追蹤")
                }
                .tag(2)
            
            // 放鬆
            RelaxationView()
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("放鬆")
                }
                .tag(3)
            
            // 個人檔案
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("個人檔案")
                }
                .tag(4)
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
}
