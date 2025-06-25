import SwiftUI

struct PsychologicalTestCard: View {
    let test: PsychologicalTest
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: test.icon)
                    .font(.title2)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(test.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    .multilineTextAlignment(.leading)
                
                Text(test.subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1).opacity(0.7))
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(test.duration)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                        Text(test.questions)
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("上次測驗")
                            .font(.system(size: 9))
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1).opacity(0.6))
                        Text(test.lastTaken)
                            .font(.system(size: 9))
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1).opacity(0.6))
                    }
                }
                .padding(.top, 2)
                
                Button(action: onTap) {
                    Text("開始測驗")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color(red: 0.8, green: 0.4, blue: 0.1))
                        .cornerRadius(8)
                }
                .padding(.top, 4)
            }
        }
        .padding(16)
        .frame(width: 160, height: 160)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 1.0, blue: 0.8),
                    Color(red: 1.0, green: 0.9, blue: 0.5),
                    Color(red: 1.0, green: 0.8, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2)
    }
}
