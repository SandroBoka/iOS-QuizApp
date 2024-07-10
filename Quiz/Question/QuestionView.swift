import SwiftUI
import Foundation

struct QuestionView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    questionViewModel.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.black)
                }
                Text("Question \(questionViewModel.currentQuestionIndex + 1) of \(questionViewModel.questions.count)     ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 70)
                
                Spacer()
            }
            .padding(.leading, 10)
            .background {
                Color.headerColor
                    .ignoresSafeArea()
            }
            
            // Question text and answer buttons
            Text(questionViewModel.questions[questionViewModel.currentQuestionIndex].question)
                .font(.title)
                .padding()
            
            Divider()
                .frame(height: 3)
                .background(Color.gray)
                .padding()
            
            ForEach(Array(questionViewModel.questions[questionViewModel.currentQuestionIndex].allAnswers), id: \.self) { answer in
                Button(action: {
                    questionViewModel.selectAnswer(answer)
                }) {
                    Text(answer)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(questionViewModel.buttonColor(for: answer))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(questionViewModel.selectedAnswer != nil) // Disable buttons after selection
                .opacity(questionViewModel.selectedAnswer != nil && answer != questionViewModel.selectedAnswer ? 0.5 : 1.0) // Dim other answers when one is selected
            }
            
            Spacer()
            
            // Next question button
            if questionViewModel.showNextButton {
                Button(action: questionViewModel.nextQuestion) {
                    Text("Next Question")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.orange.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle("Quiz")
        .background(Color.gray.opacity(0.2))
    }
}



struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let questions: [Quiz.QuestionModel] = [
            Quiz.QuestionModel(
                question: "Who succeeded Joseph Stalin as General Secretary of the Communist Party of the Soviet Union?",
                correctAnswer: "Nikita Khrushchev",
                incorrectAnswers: ["Leonid Brezhnev", "Mikhail Gorbachev", "Boris Yeltsin"],
                allAnswers: ["Nikita Khrushchev", "Boris Yeltsin", "Leonid Brezhnev", "Mikhail Gorbachev"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "GoldenEye 007 on the Nintendo 64 was planned to allow you to play as all previous Bond actors, with the exception of who?",
                correctAnswer: "George Lazenby",
                incorrectAnswers: ["Roger Moore", "Sean Connery", "Timothy Dalton"],
                allAnswers: ["Timothy Dalton", "Sean Connery", "George Lazenby", "Roger Moore"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "How many countries border Kyrgyzstan?",
                correctAnswer: "4",
                incorrectAnswers: ["3", "1", "6"],
                allAnswers: ["6", "4", "3", "1"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "What is the name of the protagonist of J.D. Salinger's novel Catcher in the Rye?",
                correctAnswer: "Holden Caulfield",
                incorrectAnswers: ["Fletcher Christian", "Jay Gatsby", "Randall Flagg"],
                allAnswers: ["Jay Gatsby", "Holden Caulfield", "Randall Flagg", "Fletcher Christian"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "What is the most populous Muslim-majority nation in 2010?",
                correctAnswer: "Indonesia",
                incorrectAnswers: ["Saudi Arabia", "Iran", "Sudan"],
                allAnswers: ["Indonesia", "Sudan", "Saudi Arabia", "Iran"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "After how many years would you celebrate your crystal anniversary?",
                correctAnswer: "15",
                incorrectAnswers: ["20", "10", "25"],
                allAnswers: ["15", "20", "10", "25"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "What is the scientific term for 'taste'?",
                correctAnswer: "Gustatory Perception",
                incorrectAnswers: ["Olfaction", "Somatosensation", "Auditory Perception"],
                allAnswers: ["Auditory Perception", "Olfaction", "Gustatory Perception", "Somatosensation"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "Which of these is not a world in the anime 'Buddyfight'?",
                correctAnswer: "Ancient Dragon World",
                incorrectAnswers: ["Dragon World", "Star Dragon World", "Darkness Dragon World"],
                allAnswers: ["Star Dragon World", "Ancient Dragon World", "Dragon World", "Darkness Dragon World"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "Which album by American rapper Kanye West contained songs such as 'Love Lockdown', 'Paranoid' and 'Heartless'?",
                correctAnswer: "808s & Heartbreak",
                incorrectAnswers: ["Late Registration", "The Life of Pablo", "Graduation"],
                allAnswers: ["Graduation", "808s & Heartbreak", "Late Registration", "The Life of Pablo"],
                category: "aa"
            ),
            Quiz.QuestionModel(
                question: "In association football, or soccer, a corner kick is when the game restarts after someone scores a goal.",
                correctAnswer: "False",
                incorrectAnswers: ["True"],
                allAnswers: ["False", "True"],
                category: "aa"
            )
        ]
        
        QuestionView(questionViewModel: QuestionViewModel(router: Router(), questions: questions, category: "Random", difficulty: "Any"))
    }
}
