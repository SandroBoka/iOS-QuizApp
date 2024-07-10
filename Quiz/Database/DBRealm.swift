




import Foundation
import RealmSwift

class StatsModelEntity: Object, Identifiable { 
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var numAnswered: Int = 0
    @Persisted var numCorrect: Int = 0
    @Persisted var bestScore: Int = 0
    @Persisted var dashNum: Int = 0
    @Persisted var normalNum: Int = 0
}

class QuestionEntity: Object {
    @Persisted var question: String = ""
    @Persisted var allAnswers: List<String> = List<String>()
    @Persisted var correctAnswer: String = ""
}

class QuestionTypeEntity: Object {
    @Persisted var questionType: String = ""
    @Persisted var allQuestions: List<QuestionEntity> = List<QuestionEntity>()
}



class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {
        // Private initialization to ensure just one instance is created.
    }
    
    func initializeRealm() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if !hasLaunchedBefore {
            // First launch, initialize Realm with default values
            do {
                let realm = try Realm()
                
                
                try realm.write {
                    let newStats = StatsModelEntity()
                    newStats.numAnswered = 0
                    newStats.numCorrect = 0
                    newStats.bestScore = 0
                    newStats.dashNum = 0
                    newStats.normalNum = 0
                    realm.add(newStats)
                    
                    let newQuestions = QuestionEntity()
                    newQuestions.question = ""
                    newQuestions.allAnswers = List<String>()
                    newQuestions.correctAnswer = ""
                    
                    let newQuestionType = QuestionTypeEntity()
                    newQuestionType.questionType = ""
                    newQuestionType.allQuestions = List<QuestionEntity>()
                    print("Initial stats created and added to Realm: \(newStats)")
                }
                
                
                UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            } catch {
                print("Error initializing Realm: \(error)")
            }
        }
    }
    
    
    
    
    func clearDatabase() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error clearing Realm database: \(error)")
        }
    }
}
