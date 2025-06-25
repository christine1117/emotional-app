import SwiftUI
import Foundation
import Combine

// MARK: - 計時器管理器
class TimerManager: ObservableObject {
    @Published var timerState: TimerState = .stopped
    @Published var timeRemaining: TimeInterval = 0
    @Published var progress: Double = 0
    @Published var elapsedMinutes: Int = 0
    
    private var timer: Timer?
    internal var totalTime: TimeInterval = 0
    private var startTime: Date?
    
    var formattedTimeRemaining: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    func configure(totalTime: TimeInterval) {
        self.totalTime = totalTime
        self.timeRemaining = totalTime
        self.progress = 0
        self.elapsedMinutes = 0
    }
    
    func startTimer() {
        timerState = .running
        startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func pauseTimer() {
        timerState = .paused
        timer?.invalidate()
    }
    
    func resumeTimer() {
        timerState = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func stopTimer() {
        timerState = .stopped
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        configure(totalTime: totalTime)
    }
    
    private func updateTimer() {
        timeRemaining -= 1
        progress = (totalTime - timeRemaining) / totalTime
        elapsedMinutes = Int((totalTime - timeRemaining) / 60)
        
        if timeRemaining <= 0 {
            timerState = .completed
            timer?.invalidate()
            timer = nil
        }
    }
}

// MARK: - 呼吸管理器
class BreathingManager: ObservableObject {
    @Published var currentPhase: BreathingPhase = .inhale
    @Published var phaseProgress: Double = 0.0
    @Published var phaseTimeRemaining: Double = 0.0
    @Published var circleScale: CGFloat = 1.0
    @Published var completedCycles: Int = 0
    
    var pattern: BreathingPattern = BreathingPattern.patterns[0]
    
    private var phaseTimer: Timer?
    private var currentPhaseDuration: Double = 0.0
    private var phaseStartTime: Date?
    
    func setPattern(_ pattern: BreathingPattern) {
        self.pattern = pattern
    }
    
    func startBreathing() {
        startPhase(.inhale)
    }
    
    func stopBreathing() {
        phaseTimer?.invalidate()
        phaseTimer = nil
    }
    
    private func startPhase(_ phase: BreathingPhase) {
        currentPhase = phase
        currentPhaseDuration = getDurationForPhase(phase)
        phaseTimeRemaining = currentPhaseDuration
        phaseStartTime = Date()
        
        // 動畫圓圈縮放
        withAnimation(.easeInOut(duration: currentPhaseDuration)) {
            circleScale = getScaleForPhase(phase)
        }
        
        phaseTimer?.invalidate()
        phaseTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updatePhaseProgress()
        }
    }
    
    private func updatePhaseProgress() {
        guard let startTime = phaseStartTime else { return }
        
        let elapsed = Date().timeIntervalSince(startTime)
        phaseTimeRemaining = max(0, currentPhaseDuration - elapsed)
        phaseProgress = elapsed / currentPhaseDuration
        
        if elapsed >= currentPhaseDuration {
            moveToNextPhase()
        }
    }
    
    private func moveToNextPhase() {
        switch currentPhase {
        case .inhale:
            if pattern.holdSeconds > 0 {
                startPhase(.hold)
            } else {
                startPhase(.exhale)
            }
        case .hold:
            startPhase(.exhale)
        case .exhale:
            if pattern.pauseSeconds > 0 {
                startPhase(.pause)
            } else {
                completedCycles += 1
                startPhase(.inhale)
            }
        case .pause:
            completedCycles += 1
            startPhase(.inhale)
        }
    }
    
    private func getDurationForPhase(_ phase: BreathingPhase) -> Double {
        switch phase {
        case .inhale: return pattern.inhaleSeconds
        case .hold: return pattern.holdSeconds
        case .exhale: return pattern.exhaleSeconds
        case .pause: return pattern.pauseSeconds
        }
    }
    
    private func getScaleForPhase(_ phase: BreathingPhase) -> CGFloat {
        switch phase {
        case .inhale: return 1.3
        case .hold: return 1.3
        case .exhale: return 0.8
        case .pause: return 0.8
        }
    }
}
