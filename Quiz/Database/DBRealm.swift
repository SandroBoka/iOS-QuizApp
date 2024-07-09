




import Foundation
import RealmSwift

class StatsModelEntity: Object, Identifiable { 
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var numAnswered: Int
    @Persisted var numCorrect: Int
    @Persisted var bestScore: Int
    @Persisted var dashNum: Int
    @Persisted var normalNum: Int
}

class QuestionEntity: Object {
    @Persisted var question: String
    @Persisted var allAnswers: List<String>
    @Persisted var correctAnswer: String
}

class QuestionTypeEntity: Object {
    @Persisted var questionType: String
    @Persisted var allQuestions: List<QuestionEntity>
}
