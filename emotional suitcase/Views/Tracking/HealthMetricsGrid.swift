import SwiftUI

struct HealthMetricsGrid: View {
    let healthMetrics: [HealthMetric]
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 15) {
            ForEach(healthMetrics) { metric in
                MetricDisplayView(
                    title: metric.type.rawValue,
                    value: metric.formattedValue,
                    unit: metric.type.unit,
                    icon: metric.type.icon,
                    trendValue: metric.trend,
                    accentColor: metric.type.color
                )
            }
        }
    }
}

#Preview {
    HealthMetricsGrid(
        healthMetrics: [
            HealthMetric(type: .heartRateVariability, value: 48, trend: 2.3),
            HealthMetric(type: .sleepQuality, value: 2.4, trend: -1.2),
            HealthMetric(type: .activityLevel, value: 7200, trend: 5.7),
            HealthMetric(type: .weight, value: 53.2)
        ]
    )
    .padding()
}
