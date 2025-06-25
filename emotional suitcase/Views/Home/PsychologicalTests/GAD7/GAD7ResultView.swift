import SwiftUI

struct GAD7ResultView: View {
    let score: Int
    @Binding var isPresented: Bool
    
    var anxietyLevel: String {
        switch score {
        case 0...4: return "輕微焦慮"
        case 5...9: return "輕度焦慮"
        case 10...14: return "中度焦慮"
        case 15...21: return "重度焦慮"
        default: return "重度焦慮"
        }
    }
    
    var recommendation: String {
        switch score {
        case 0...4: return "您的焦慮程度很低，請保持良好的生活習慣。"
        case 5...9: return "您有輕度焦慮，建議學習放鬆技巧和壓力管理。"
        case 10...14: return "您有中度焦慮，建議尋求專業心理諮詢。"
        case 15...21: return "您有重度焦慮，強烈建議尋求專業醫療協助。"
        default: return "請尋求專業醫療協助。"
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 60))
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            
            Text("GAD-7 測試完成")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            
            VStack(spacing: 12) {
                Text("您的焦慮指數")
                    .font(.headline)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                
                Text("\(score)/21")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(Color(red: 0.8, green: 0.4, blue: 0.1))
                
                Text(anxietyLevel)
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
            
            if score >= 10 {
                VStack(spacing: 8) {
                    Text("⚠️ 重要提醒")
                        .font(.headline)
                        .foregroundColor(.red)
                    Text("您的測試結果顯示可能有較嚴重的焦慮症狀，建議尋求專業醫療協助。")
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
