import SwiftUI

struct Question {
    let text: String
    let answers: [String]
}

struct QuestionView: View {
    let question: Question
    @State private var selectedAnswer: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text(question.text)
                .font(.title)
                .padding()
            
            ForEach(question.answers, id: \.self) { answer in
                Button(action: {
                    selectedAnswer = answer
                    print("Selected answer: \(answer)")
                }) {
                    Text(answer)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.buttonsColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
        .background(Color.backgroundColor.opacity(0.3))
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleQuestion = Question(
            text: "What is the capital of France?",
            answers: ["Paris", "London", "Berlin", "Rome"]
        )
        QuestionView(question: sampleQuestion)
    }
}
