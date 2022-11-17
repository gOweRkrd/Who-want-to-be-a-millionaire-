import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Question {
    let id : Int
    let question: String
    let answers: [String]
    let correctAnswer: String
    let questionLevel: String
}

let questions = [
    Question(id:1,
             question: "Что растёт в огороде?",
             answers: ["Лук", "Пистолет", "Пулемет", "Ракета"],
             correctAnswer: "Лук",
             questionLevel: "Легкий"),
    
    Question(id:2,
             question:"Как называют микроавтобусы, совершающие поездки по определённым маршрутам?",
             answers: ["Рейсовка", "Путевка", "Курсовка", "Маршрутка"],
             correctAnswer: "Маршрутка",
             questionLevel: "Легкий"),
    
    Question(id:3
             ,question: "О чём писал Грибоедов, отмечая, что он «нам сладок и приятен» ?",
             answers: ["Дым Отечества", "Дух купечества", "Дар пророчества", "Пыл девичества"],
             correctAnswer: "Дым Отечества",
             questionLevel: "Легкий"),
    
    Question(id:4,
             question: "Какого персонажа нет в известной считалке «На золотом крыльце сидели» ?",
             answers: ["Сапожника", "Кузнеца", "Короля", "Портного"],
             correctAnswer: "Кузнеца",
             questionLevel: "Легкий"),
    
    Question(id:5,
             question: "Какой специалист занимается изучением неопознанных летающих объектов?",
             answers: ["Кинолог", "Уфолог", "Сексопатолог", "Психиатр"],
             correctAnswer: "Уфолог",
             questionLevel: "Легкий")
]

struct GameModel {
    let sumOfQuestion: Int
    let question: Question
}


class NewGameModel {
    private let questions: [Question]
    
    private let assuredSums = [11500, 81500, 1981500]
    private let roundPrizes = [500, 1000, 2000, 3000, 5000, 7500, 10000, 12500, 15000, 25000, 50000, 100000, 250000, 500000, 1000000]
    private var gameModel: [GameModel] = []
    
    private var currentAssuredSum: Int = 0
   
    private let roundDuration: TimeInterval
    private var currentRoundIndex = 0
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
            return arr
        }()
        
    }
}

extension NewGameModel {
    
    /// Запускаем новый раунд
    func startNewRound() {
        print("I start new round")
        let round = NewGameRound(
            roundData: self.gameModel[currentRoundIndex],
            roundDuration: self.roundDuration
        )

        round.start() {
            // Вызов в конце раунда продолжается игра или нет
            [weak self] roundResult in
            guard let self = self else { return }
            
            //Подставить в функцию для отслеживания победа или поражение и вызов алерта.
            self.gameGoOn(roundResult: roundResult)
        }
        self.currentRound = round
    }
    
    func gameGoOn(roundResult: RoundResult) {
        switch roundResult {
            
        case .win:
            self.totalWinSum += gameModel[currentRoundIndex].sumOfQuestion
            
            if self.currentRoundIndex  == (gameModel.count - 1) {
                print("I win! My money = \(totalWinSum)")
                return
            }
            
            self.currentRoundIndex += 1
            
            if self.assuredSums.contains(self.totalWinSum) {
                self.currentAssuredSum = self.totalWinSum
            }
            
            startNewRound()
            
        case .loose:
            print("I loos and my money is \(self.currentAssuredSum)")
            
        case .takeAwayMoney:
            print("I take away my money \(self.totalWinSum)")
        }
    }

}

enum RoundResult {
    case win
    case loose
    case takeAwayMoney
}

class NewGameRound {
    //Передать сюда модель с музыкой и музыкальную реализацию
    //Перенести в модель всю работу с таймером
    let roundData: GameModel
    let roundDuration: TimeInterval
    var remainingRoundSecHandler: ((TimeInterval) -> Void)?
    private var roundEndHandler: ((RoundResult) -> Void)?
    private var timer: Timer? = nil
    private var elapsedSec: TimeInterval = 0
    
    init(
        roundData: GameModel,
        roundDuration: TimeInterval
    ) {
        self.roundData = roundData
        self.roundDuration = roundDuration
    }
    
    ///Заупскает начало райнуда
    func start(completion: @escaping (RoundResult) -> Void) {
        self.roundEndHandler = completion
        //Запускаем функцию с таймером
        startGameTimer()
        //
    }
    
    ///функция выбора ответа
    func makeСhoice(chooseAnswer: String) {
        let roundResult: RoundResult = {
            roundData.question.correctAnswer == chooseAnswer ? .win : .loose
        }()
        roundEndHandler?(roundResult)
        invalidateTimer()
    }
    
    ///Подсказка 50/50
    func excludeTwoWrongAnswers() -> [String] {
        
        var wrongAnswers: [String] = []
        wrongAnswers = roundData.question.answers.filter { $0 != roundData.question.correctAnswer }
        let randomElement = Int.random(in: 0 ..< wrongAnswers.count)
        wrongAnswers.remove(at: randomElement)
        
        return wrongAnswers
    }
    
    ///Право на ошибку
    func rightToMakeMistake() -> String {
        //Функция для остановки таймера
        roundEndHandler?(RoundResult.win)
        invalidateTimer()
        return roundData.question.correctAnswer
    }
    
    ///Помощь зала возвращает верный ответ. Можно добавить логику с процентами
    func hallSupport() -> String {
        return roundData.question.correctAnswer
    }

    ///Забрать деньги
    func takeAwayMoney() {
        //Функция для остановки таймера
        invalidateTimer()
        roundEndHandler?(RoundResult.takeAwayMoney)
    }
}

// MARK: Timer staff
private extension NewGameRound {
    
    func startGameTimer() {
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.timerTick),
            userInfo: nil,
            repeats: true
        )
        self.timer?.fire()
    }
    
    @objc func timerTick() {
        self.elapsedSec += 1
        print("timerTick elapsedSec: \(self.elapsedSec)")
        
        let remainingSec = self.roundDuration - self.elapsedSec
        self.remainingRoundSecHandler?(remainingSec)
        
        if remainingSec <= 0 {
            self.invalidateTimer()
            self.roundEndHandler?(RoundResult.loose)
        }
    }
    
    /// Таймер останавливается
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

let game = NewGameModel(questions: questions, roundDuration: 10.0)
game.startNewRound()

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    game.currentRound?.makeСhoice(chooseAnswer: "Лук")
}
