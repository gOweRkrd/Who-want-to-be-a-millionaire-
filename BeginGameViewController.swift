
import UIKit
import AVFoundation

class BeginGameViewController: UIViewController {
    
    
    let music = MusicModel()
    
    
    
    var ololoHandler: (([ HelperButton : Bool ]) -> Void)?
    
    //Все свойства должны быть в одном месте и упрядочены. Свойства, которые не должны быть доступны на других экранах - должны быть private. UI-объекты должны быть private lazy var (инициализация объектов происходит тогда, когда мы к ним обращаемся, а не храняться в памяти приложения с момента запуска)
    
    var newGameRound : NewGameRound
    
    var helpers: [ HelperButton : Bool ] {
        didSet {
            self.ololoHandler?(self.helpers)
        }
    }
    
    init(newGameRound: NewGameRound,
         helpers: [ HelperButton : Bool ]) {
        self.helpers = helpers
        self.newGameRound = newGameRound
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var circleTimer = CircleTimerShape()
    var landscape: [NSLayoutConstraint]?
    var portrait: [NSLayoutConstraint]?
    var isLandscape = true
    
    
    lazy var timeNumber = newGameRound.roundDuration
    
    lazy var answerStack = UIStackView()
    lazy var helpStack = UIStackView()
    lazy var hitStack = UIStackView()
    lazy var letterStack = UIStackView()
    lazy var imageView = UIImageView()
    
    lazy var backgroundImage = UIImage(named: "rulesBackground")
    
    lazy var firstHelpButton = UIButton()
    lazy var secondHelpButton = UIButton()
    lazy var thirtHelpButton = UIButton()
    lazy var fourHelpButton = UIButton()
    
    lazy var firstAnswerButton = UIButton()
    lazy var secondAnswerButton = UIButton()
    lazy var thirtAnswerButton = UIButton()
    lazy var fourAnswerButton = UIButton()
    
    lazy var color1 = #colorLiteral(red: 0.07450980392, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
    lazy var color2 = #colorLiteral(red: 0.8352941176, green: 0.6705882353, blue: 0, alpha: 1)
    lazy var color3 = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.4570478225)
    lazy var color4 = #colorLiteral(red: 0.1497105928, green: 0.6043053612, blue: 0.7280215983, alpha: 0.6094313868)
    
    
    
    //Я не просто так убрала это свойство из кода. Я не ошаблась. Зачем ты переписал логику и вернул эту хрень?!
    lazy var mistake = false
    
    
    
    lazy var answers = newGameRound.roundData.question.answeres
    lazy var currentAnswer = newGameRound.roundData.question.correctAnswer
    lazy var buttonArray = [firstAnswerButton, secondAnswerButton, thirtAnswerButton, fourAnswerButton]
    lazy var roundTime = Int(newGameRound.roundDuration)
    
    
    
    
    let queshionsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 25)
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.backgroundColor = .clear
        label.textColor = UIColor.white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.layer.shadowOpacity = 0.5
        let borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.borderColor = borderColor.cgColor
        label.layer.borderWidth = 10
        label.layer.shadowRadius = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        let borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        let backColor = #colorLiteral(red: 0.2732658284, green: 0.1998029978, blue: 0.4841783049, alpha: 0.9531554165)
        label.layer.borderColor = borderColor.cgColor
        label.backgroundColor = backColor
        label.layer.borderWidth = 5
        label.textColor = UIColor.white
        label.layer.cornerRadius = 20
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 0
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timerDisplay: UILabel = {
        let display = UILabel()
        display.text = ""
        display.layer.shadowOpacity = 0.5
        display.textAlignment = .center
        display.sizeToFit()
        display.font = UIFont.systemFont(ofSize: 35)
        display.textColor = .yellow
        display.layer.cornerRadius = 50
        display.layer.masksToBounds = true
        return display
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewSettings()
        circleTimer.shapeSetting()
        setupView()
        configureView()
        
        
        switchBtnImage()
        
        musicPlay()
        timeTic()
        gameData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        music.player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        musicPlay()
    }
    
    private func musicPlay() {
        music.playSound(nameOfMusic: "Thinking")
    }
    
    private func musicAfterHint() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.musicPlay()
        }
    }
    
    //MARK: - Create Game Logic
    @objc func mistakeHelpButtonPressed() {
        
        music.playSound(nameOfMusic: "Hint Chosen")
        musicAfterHint()
        
        self.mistake = true
        newGameRound.rightToMakeMistake()
        
        helpers[.oneMistake] = false
        
        
        firstHelpButton.blink(stopAfter: 2.0)
        for button in buttonArray {
            button.blink(stopAfter: 2.0)
            button.setBackgroundImage(UIImage(named: "Image2"), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            firstHelpButton.setBackgroundImage(UIImage(named: "call2"), for: .normal)
            firstHelpButton.isEnabled = false
        }
        firstHelpButton.blink(stopAfter: 2.0)
    }
    
    
    @objc func fiftyHelpButtonPressed() {
        
        music.playSound(nameOfMusic: "Hint Chosen")
        
        musicAfterHint()
        helpers[.fiftyFifty] = false
        
        musicAfterHint()
        
        
        secondHelpButton.blink(stopAfter: 2.0)
        for array in buttonArray {
            array.blink(stopAfter: 5.0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            [self] in
            secondHelpButton.setBackgroundImage(UIImage(named: "50502"), for: .normal)
            secondHelpButton.isEnabled = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            //Что это и зачем оно нужно?! Ты это нигде не используешь
            var arr = newGameRound.excludeTwoWrongAnswers()
            //Ты перебираешь массив с кнопками, то есть цикл проходит по каждой кнопке, почему в цикле объект array, а не button?!
            for array in buttonArray {
                arr.forEach { string in
                    if array.titleLabel?.text == string {
                        array.setBackgroundImage(UIImage(named: ""), for: .normal)
                        array.setTitleColor(.clear, for: .normal)
                        array.isEnabled = false
                    }
                }
            }
        }
    }
    
    
    @objc func helpButtonPressed() {
        music.playSound(nameOfMusic: "Hint Chosen")
        musicAfterHint()
        helpers[.helpHall] = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            for array in buttonArray {
                if array.titleLabel?.text == newGameRound.hallSupport() {
                    array.setBackgroundImage(UIImage(named: "Image4"), for: .normal)
                    array.layer.shadowOpacity = 1.0
                    array.layer.shadowColor = UIColor.white.cgColor
                    array.layer.shadowOffset = CGSize(width: 5, height: 5)
                    array.layer.shadowRadius = 10
                }
            }
        }
        thirtHelpButton.blink(stopAfter: 2.0)
        for array in buttonArray {
            array.blink(stopAfter: 5.0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            thirtHelpButton.setBackgroundImage(UIImage(named: "holl2"), for: .normal)
            thirtHelpButton.isEnabled = false
        }
    }
    
    
    @objc func moneyHelpButtonPressed() {
        
        music.playSound(nameOfMusic: "Button Push")
        musicAfterHint()
        
        fourHelpButton.blink(stopAfter: 2.0)
        let alertController = UIAlertController(title: "Вы уверены что хотите забрать деньги?", message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { action in
            
            self.newGameRound.takeAwayMoney()
            
            self.music.playSound(nameOfMusic: "Win")
            self.dismiss(animated: true)
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func answerButtonLogic(sender: UIButton!) {
        
        buttonArray.forEach { $0.isEnabled = false }
        buttonArray.forEach { button in
            music.playSound(nameOfMusic: "AnswerAccepted")
        }
        let userAnswer = sender.currentTitle!
        sender.isEnabled = true
        sender.blink()
        
        if mistake == false {
            let chooseAnswer = sender.titleLabel!.text!
            //Что это и зачем оно нужно?! Ты это нигде не используешь
            let choose = !self.newGameRound.makeСhoice(chooseAnswer: chooseAnswer)
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
                if userAnswer == currentAnswer {
                    music.playSound(nameOfMusic: "Correct")
                    
                    sender.setBackgroundImage(UIImage(named: "Image2"), for: .normal)
                    sender.layer.shadowOpacity = 1.0
                    sender.layer.shadowColor = UIColor.white.cgColor
                    sender.layer.shadowOffset = CGSize(width: 5, height: 5)
                    sender.layer.shadowRadius = 10
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                        self.dismiss(animated: true)
                    }
                } else {
                    sender.setBackgroundImage(UIImage(named: "Image3"), for: .normal)
                    music.playSound(nameOfMusic: "Wrong")
                    for array in buttonArray {
                        if array.titleLabel?.text == currentAnswer {
                            array.setBackgroundImage(UIImage(named: "Image2"), for: .normal)
                            array.isEnabled = true
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                        self.dismiss(animated: true)
                    }
                }
            }
        } else {
            if sender.isSelected {
                
                //Что это и зачем оно нужно?! Ты это нигде не используешь. Зачем надо было подключать модель, если ты не используешь данные, которые получаешься из этой модели
                let helpChoose = !self.newGameRound.makeСhoice(chooseAnswer: currentAnswer)
            }
            for array in buttonArray {
                music.playSound(nameOfMusic: "Correct")
                array.setBackgroundImage(UIImage(named: "Image2"), for: .normal)
                array.layer.shadowOpacity = 1.0
                array.layer.shadowColor = UIColor.white.cgColor
                array.layer.shadowOffset = CGSize(width: 5, height: 5)
                array.layer.shadowRadius = 10
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                self.dismiss(animated: true)
            }
        }
    }
    
    private func switchBtnImage() {
        if helpers[.oneMistake]! {
            firstHelpButton.setImage(UIImage(named: "call"), for: .normal)
        } else {
            firstHelpButton.setImage(UIImage(named: "call2"), for: .normal)
            firstHelpButton.isUserInteractionEnabled = false
        }
        
        if helpers[.fiftyFifty]! {
            secondHelpButton.setImage(UIImage(named: "5050"), for: .normal)
        } else {
            secondHelpButton.setImage(UIImage(named: "50502"), for: .normal)
            secondHelpButton.isUserInteractionEnabled = false
        }
        
        if helpers[.helpHall]! {
            thirtHelpButton.setImage(UIImage(named: "holl"), for: .normal)
        } else {
            thirtHelpButton.setImage(UIImage(named: "holl2"), for: .normal)
            thirtHelpButton.isUserInteractionEnabled = false
        }
    }
}


