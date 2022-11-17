
import Foundation

enum GameRoundResult {
    case gameWin(_ prize: Int)
    case roundWin(_ prize: Int)
    case roundLoose(_ prize: Int)
    case takeAwayMoney(_ totalSum: Int)
}

enum RoundResult {
    case win(Int)
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
    func makeСhoice(chooseAnswer: String) -> Bool {
        let isCorrectAnswer = roundData.question.correctAnswer == chooseAnswer
        
        let roundResult: RoundResult = {
            isCorrectAnswer ? .win(self.roundData.sumOfQuestion) : .loose
        }()
        roundEndHandler?(roundResult)
        invalidateTimer()
        
        return isCorrectAnswer
    }
    
    ///Подсказка 50/50
    func excludeTwoWrongAnswers() -> [String] {
        
        var wrongAnswers: [String] = []
        wrongAnswers = roundData.question.answeres.filter { $0 != roundData.question.correctAnswer }
        let randomElement = Int.random(in: 0 ..< wrongAnswers.count)
        wrongAnswers.remove(at: randomElement)
        
        return wrongAnswers
    }
    
    ///Право на ошибку
    func rightToMakeMistake() -> String {
        //Функция для остановки таймера
        roundEndHandler?(.win(self.roundData.sumOfQuestion))
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
        
        let remainingSec = self.roundDuration - self.elapsedSec
        self.remainingRoundSecHandler?(remainingSec)
        
        if remainingSec <= 0 {
            self.invalidateTimer()
            self.roundEndHandler?(.loose)
        }
    }
    
    /// Таймер останавливается
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

