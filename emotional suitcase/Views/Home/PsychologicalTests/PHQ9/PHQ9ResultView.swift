import SwiftUI

struct PHQ9ResultView: View {
    let score: Int
    @Binding var isPresented: Bool
    
    var depressionLevel: String {
        switch score {
        case 0...4: return "無憂鬱"
        case 5...9: return "輕度憂鬱"
        case 10...14: return "中度憂鬱"
        case 15...19: return "中重度憂鬱"
        case 20...27: return "重度憂鬱"
        default: return "重度憂鬱"
        }
    }
    
    var recommendation: String {
        switch score {
        case 0...4: return "您擁有良好的生活習慣和心理健康，請繼續保持"
        case 5...9: return "您有輕度憂鬱症狀，建議多關注自己的情緒狀態，適當放鬆。"
        case 10...14: return "您有中度憂鬱症狀，建議尋求專業心理諮詢或治療。"
        case 15...19: return "您有中重度憂鬱症狀，強烈建議尋求專業醫療協助。"
        case 20...27: return "您有重度憂鬱症狀，請立即尋求專業醫療協助。"
        default: return "請尋求專業醫療協助。"
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            
            Text("PHQ-9 測試完成")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            
            VStack(spacing: 12) {
                Text("您的憂鬱指數")
                    .font(.headline)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                
                Text("\(score)/27")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(Color(red: 0.8, green: 0.4, blue: 0.1))
                
                Text(depressionLevel)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4)
            
            Text(recommendation)
                .font(.body)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 2)
            
            if score >= 15 {
                VStack(spacing: 8) {
                    Text("⚠️ 重要提醒")
                        .font(.headline)
                        .foregroundColor(.red)
                    Text("您的測試結果顯示可能有較嚴重的憂鬱症狀，建議盡快尋求專業醫療協助。")
                        .font(.body)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
            }
            
            Button(action: { isPresented = false }) {
                Text("完成")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.4, green: 0.2, blue: 0.1))
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(red: 0.996, green: 0.953, blue: 0.780))
        .navigationTitle("測試結果")
        .navigationBarTitleDisplayMode(.inline)
    }
}
