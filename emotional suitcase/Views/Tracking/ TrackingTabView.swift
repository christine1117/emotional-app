// TrackingTabView.swift
import SwiftUI

struct TrackingTabView: View {
    @Binding var selectedTab: Int
    
    private let tabs = [
        ("心情日記", "heart.text.square"),
        ("健康數據", "chart.line.uptrend.xyaxis"),
        ("量表追蹤", "list.clipboard")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                TrackingTabButton(
                    title: tabs[index].0,
                    icon: tabs[index].1,
                    isSelected: selectedTab == index,
                    action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedTab = index
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)  // 調整垂直間距
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .padding(.bottom, 15)  // 增加底部間距
    }
}

struct TrackingTabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {  // 減少圖標和文字間距
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))  // 稍微縮小圖標
                    .foregroundColor(isSelected ? AppColors.orange : AppColors.darkBrown.opacity(0.6))
                
                Text(title)
                    .font(.system(size: 11, weight: .medium))  // 縮小文字
                    .foregroundColor(isSelected ? AppColors.orange : AppColors.darkBrown.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)  // 減少垂直內邊距
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? AppColors.orange.opacity(0.1) : Color.clear)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    TrackingTabView(selectedTab: .constant(0))
        .background(AppColors.lightYellow)
}
