import Foundation
import Combine

class TrackingDataManager: ObservableObject {
    @Published var moodEntries: [MoodEntry] = []
    @Published var healthMetrics: [HealthMetric] = []
    @Published var scaleRecords: [ScaleRecord] = []
    @Published var currentMood: MoodType = .neutral
    @Published var selectedDate = Date()
    
    init() {
        loadSampleData()
    }
    
    // MARK: - 心情相關
    func addMoodEntry(_ mood: MoodType, note: String = "") {
        let entry = MoodEntry(
            date: selectedDate,
            mood: mood,
            note: note
        )
        moodEntries.append(entry)
        currentMood = mood
    }
    
    func getMoodEntries(for month: Int, year: Int) -> [MoodEntry] {
        return moodEntries.filter { entry in
            let calendar = Calendar.current
            let entryMonth = calendar.component(.month, from: entry.date)
            let entryYear = calendar.component(.year, from: entry.date)
            return entryMonth == month && entryYear == year
        }
    }
    
    // MARK: - 健康數據相關
    func updateHealthMetric(_ type: HealthMetricType, value: Double) {
        if let index = healthMetrics.firstIndex(where: { $0.type == type }) {
            healthMetrics[index].value = value
            healthMetrics[index].lastUpdated = Date()
        } else {
            let metric = HealthMetric(type: type, value: value)
            healthMetrics.append(metric)
        }
    }
    
    func getHealthMetric(_ type: HealthMetricType) -> HealthMetric? {
        return healthMetrics.first { $0.type == type }
    }
    
    // MARK: - 量表記錄相關
    func addScaleRecord(_ type: ScaleType, score: Int, answers: [Int]) {
        let record = ScaleRecord(
            type: type,
            score: score,
            answers: answers,
            date: Date()
        )
        scaleRecords.append(record)
    }
    
    func getScaleRecords(for type: ScaleType) -> [ScaleRecord] {
        return scaleRecords.filter { $0.type == type }
    }
    
    // MARK: - 範例數據
    private func loadSampleData() {
        // 載入範例心情記錄
        let calendar = Calendar.current
        for i in 1...30 {
            if let date = calendar.date(byAdding: .day, value: -i, to: Date()) {
                let mood = MoodType.allCases.randomElement() ?? .neutral
                let entry = MoodEntry(date: date, mood: mood, note: "")
                moodEntries.append(entry)
            }
        }
        
        // 載入範例健康數據
        healthMetrics = [
            HealthMetric(type: .heartRateVariability, value: 48),
            HealthMetric(type: .sleepQuality, value: 2.4),
            HealthMetric(type: .activityLevel, value: 7200),
            HealthMetric(type: .weight, value: 53.2)
        ]
        
        // 載入範例量表記錄
        for _ in 1...10 {
            let phq9Record = ScaleRecord(
                type: .phq9,
                score: Int.random(in: 0...27),
                answers: Array(repeating: Int.random(in: 0...3), count: 9),
                date: Date().addingTimeInterval(-Double.random(in: 0...2592000)) // 隨機過去30天
            )
            scaleRecords.append(phq9Record)
        }
    }
}
