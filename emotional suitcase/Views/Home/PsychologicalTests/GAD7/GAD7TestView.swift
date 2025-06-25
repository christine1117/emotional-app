import SwiftUI

struct GAD7TestView: View {
    @Binding var isPresented: Bool
    @State private var currentQuestion = 0
    @State private var answers: [Int] = Array(repeating: 0, count: 7)
    @State private var showingResult = false
    
    let questions = [
        "感覺緊張、焦慮或煩躁",
        "無法停止或控制憂慮",
        "對各種不同的事情過度擔心",
        "很難放鬆下來",
        "坐立不安，難以靜坐",
        "變得容易苦惱或急躁",
        "感覺害怕，好像將有可怕的事情發生"
    ]
    
    let options = ["完全沒有", "好幾天", "一半以上的天數", "幾乎每天"]
    
    var body: some View {
        NavigationView {
            if showingResult {
                GAD7ResultView(score: calculateScore(), isPresented: $isPresented)
            } else {
                VStack(spacing: 20) {
                    ProgressView(value: Double(currentQuestion + 1), total: Double(questions.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0.4, green: 0.2, blue: 0.1)))
                    
                    Text("第 \(currentQuestion + 1) 題，共 \(questions.count) 題")
                        .font(.caption)
                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1).opacity(0.7))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("在過去兩週內，您有多常被以下的問題所困擾：")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                        
                        Text(questions[currentQuestion])
                            .font(.headline)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.leading)
                    }
                    
                    VStack(spacing: 12) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Button(action: {
                                selectAnswer(index)
                            }) {
                                HStack {
                                    Text(options[index])
                                        .font(.body)
                                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                                    Spacer()
                                    Text("(\(index)分)")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1).opacity(0.6))
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.1), radius: 2)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(red: 0.996, green: 0.953, blue: 0.780))
                .navigationTitle("GAD-7 焦慮症篩檢")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("取消") { isPresented = false })
            }
        }
    }
    
    private func selectAnswer(_ answer: Int) {
        answers[currentQuestion] = answer
        
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
        } else {
            showingResult = true
        }
    }
    
    private func calculateScore() -> Int {
        return answers.reduce(0, +)
    }
}
