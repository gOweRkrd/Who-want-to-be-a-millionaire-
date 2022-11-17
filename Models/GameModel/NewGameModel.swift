
import Foundation

class NewGameModel {
    
    private(set) var currentRoundIndex: Int = 0 {
        didSet {
            print("___currentRoundIndex: \(self.currentRoundIndex)")
            print("")
        }
    }

    // инициализируем модель мопросов на раунд
    private var questions = [Question]()
    private let assuredSums = [1000, 32000, 1000000]
    private var  roundPrizes = [100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]

    var gameModel: [GameModel] = []
    private var currentAssuredSum: Int = 0
    private var roundCompletion: ((GameRoundResult) -> Void)?
    private let roundDuration: TimeInterval
    private var totalWinSum: Int = 0
    
    /// Текущий раунд игры
    private(set) var currentRound: NewGameRound?
    
    init(
        questions: [Question],
        roundDuration: TimeInterval
    ) {
        self.questions = questions
        self.roundDuration = roundDuration
        
        self.gameModel = {
            var arr = [GameModel]()
            for dataGame in zip(roundPrizes, questions) {
                arr.append(.init(sumOfQuestion: dataGame.0, question: dataGame.1))
            }
            currentRoundIndex = roundPrizes.count - 1
            let sortedArr = arr.sorted(by: > )
//            print("arr: \(sortedArr)")
            return sortedArr
        }()
    }
}

extension NewGameModel {
    
    /// Запускаем новый раунд
    func startNewRound(roundCompletion: @escaping (GameRoundResult) -> Void) -> NewGameRound {
        self.roundCompletion = roundCompletion
        print("I start new round currentRoundIndex: \(currentRoundIndex)")
        
        let round = NewGameRound(
            roundData: self.gameModel[currentRoundIndex],
            roundDuration: self.roundDuration
        )
        
        self.currentRound = round
        
        round.start() {
            // Вызов в конце раунда продолжается игра или нет
            [weak self] roundResult in
            guard let self = self else { return }
            
            //Подставить в функцию для отслеживания победа или поражение и вызов алерта.
            self.gameGoOn(roundResult: roundResult)
        }
        
        return round
    }
    
    private func gameGoOn(roundResult: RoundResult) {
        switch roundResult {
            
        case .win(let roundSum):
            self.totalWinSum = roundSum
            
            if self.currentRoundIndex == 0 {
                self.roundCompletion?(.gameWin(self.totalWinSum))
                return
            }
            
            self.currentRoundIndex -= 1
            
            if self.assuredSums.contains(self.totalWinSum) {
                self.currentAssuredSum = self.totalWinSum
            }
            
            self.roundCompletion?(.roundWin(self.totalWinSum))
            
        case .loose:
            print("I loose and my money is \(self.currentAssuredSum)")
            self.roundCompletion?(.roundLoose(self.currentAssuredSum))
            
        case .takeAwayMoney:
            print("I take away my money \(self.totalWinSum)")
            self.roundCompletion?(.takeAwayMoney(self.totalWinSum))
        }
    }
}
