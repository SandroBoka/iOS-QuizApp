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

class AppSettingsEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var isDarkMode: Bool = false
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
                    
                    let newAppSettings = AppSettingsEntity()
                    newAppSettings.isDarkMode = false // Set default value for dark mode
                    realm.add(newAppSettings)
                    
                }
                
                
                UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            } catch {
                print("Error initializing Realm: \(error)")
            }
        }
    }
    
    func fetchDarkModeSetting() -> Bool {
            do {
                let realm = try Realm()
                if let appSettings = realm.objects(AppSettingsEntity.self).first {
                    return appSettings.isDarkMode
                }
            } catch {
                print("Error fetching dark mode setting from Realm: \(error)")
            }
            return false // default value if fetch fails
        }
    
    func clearDatabase() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                UserDefaults.standard.set(false, forKey: "hasLaunchedBefore")
            }
        } catch {
            print("Error clearing Realm database: \(error)")
        }
    }
}
