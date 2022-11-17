
import Foundation

struct GameModel: Comparable {
    let sumOfQuestion: Int
    let question: Question
    
    static func < (lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.sumOfQuestion < rhs.sumOfQuestion
    }
    
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.sumOfQuestion == rhs.sumOfQuestion
    }
}
