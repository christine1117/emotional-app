import SwiftUI

struct WeekNavigator: View {
    @Binding var selectedWeek: Date
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: previousWeek) {
                Image(systemName: "chevron.left")
                    .font(.caption)
                    .foregroundColor(AppColors.orange)
            }
            
            Text("本週")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(AppColors.darkBrown)
            
            Button(action: nextWeek) {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(AppColors.orange)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(AppColors.orange.opacity(0.1))
        .cornerRadius(8)
    }
    
    private func previousWeek() {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedWeek) ?? selectedWeek
        }
    }
    
    private func nextWeek() {
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedWeek) ?? selectedWeek
        }
    }
}

#Preview {
    WeekNavigator(selectedWeek: .constant(Date()))
        .padding()
}
