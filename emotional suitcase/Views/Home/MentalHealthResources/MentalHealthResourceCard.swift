import SwiftUI

struct MentalHealthResourceCard: View {
    let resource: MentalHealthResource
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: resource.icon)
                    .font(.title2)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                Spacer()
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(resource.title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    .multilineTextAlignment(.leading)
                
                Text(resource.subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1).opacity(0.7))
                    .multilineTextAlignment(.leading)
                
                Button(action: onTap) {
                    Text(resource.buttonText)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(red: 0.4, green: 0.2, blue: 0.1))
                        .cornerRadius(8)
                }
                .padding(.top, 4)
            }
        }
        .padding(16)
        .frame(width: 160, height: 140)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.9, blue: 0.7),
                    Color(red: 1.0, green: 0.8, blue: 0.5),
                    Color(red: 1.0, green: 0.6, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2)
    }
}
