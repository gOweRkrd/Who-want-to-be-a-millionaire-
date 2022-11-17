import UIKit
import AVFoundation

extension MainViewController {
    
    struct QuestionCellInfo {
        var index: Int
        var color: UIColor?
    }
}

final class MainViewController: UIViewController {
    
    private let music = MusicModel()
    private let headerView = HeaderView()
    private let myTableView = UITableView(frame: .zero, style: .plain)
    private let footerView = FooterView()
    private let questions = QuestionFetchModel.loadFetchModel()
    private lazy var helpers: [ HelperButton : Bool ] = [
        .helpHall : true,
        .fiftyFifty : true,
        .oneMistake : true
    ]
    
    
    // подгружаем массив данных из модели Fetch
    private lazy var game = NewGameModel(questions: questions,
                                         roundDuration: 30.0)
    private var sumOfWin: Int = 0
    
    private var currentQuestionCellInfo: QuestionCellInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConstraints()
        myTableView.rowHeight = 40
        playMusic()
        self.headerView.sumLabel.text = "Вы заработали: \(String(self.sumOfWin)) $"
        
        // делаем связь экранов
        headerView.buttonHandler = {
            [weak self] in
            guard let self = self else { return }
            
            let alertController = UIAlertController(title: "Выйти из игры и забрать деньги?", message: "Ваша сумма: \(self.sumOfWin)", preferredStyle: .alert)
            let alertСonfirm = UIAlertAction(title: "Подтвердить", style: .default) {
                [weak self] _ in
                self?.dismiss(animated: true)
            }
            let alertCancel = UIAlertAction(title: "Отмена", style: .default)
            self.present(alertController, animated: true, completion: nil)
            alertController.addAction(alertСonfirm)
            alertController.addAction(alertCancel)
        }
        
        footerView.buttonFooter = {
            [weak self] in
            guard let self = self else { return }
            
            let alertController = UIAlertController(title: "Вы готовы к следующему вопросу?", message: nil, preferredStyle: .alert)
            let alertСonfirm = UIAlertAction(title: "Да", style: .default) {
                [weak self] _s in
                guard let self = self else { return }
                
                let round = self.game.startNewRound() {
                    [weak self] gameRoundResult in
                    guard let self = self else { return }
                    
                    switch gameRoundResult {
                        
                    case .gameWin(let prize):
                        self.getAlert(
                            titel: "ВЫ ВЫИГРАЛИ!",
                            message: "Вы заработали $ \(prize)!",
                            withDelay: 7.5
                        )
                        self.headerView.sumLabel.text = "Вы выиграли $ \(prize)!"
                        self.sumOfWin = prize
                        
                        self.currentQuestionCellInfo?.color = .green
                        
                    case .roundWin(let currntTotalSum):
                        self.headerView.sumLabel.text = "Ваша сумма очков : $ \(currntTotalSum)"
                        self.sumOfWin = currntTotalSum
                        self.currentQuestionCellInfo?.color = .green
                        
                    case .takeAwayMoney(let assuredSum):
                        self.getAlert(
                            titel: "Вы забрали деньги!",
                            message: "Вы забрали $ \(assuredSum)!",
                            withDelay: 1
                        )
                        self.headerView.sumLabel.text = "Вы забрали $ \(assuredSum)!"
                        self.sumOfWin = assuredSum
                        self.currentQuestionCellInfo?.color = .red
                        
                    case .roundLoose(let prize):
                        self.sumOfWin = prize
                        self.currentQuestionCellInfo?.color = .red
                        let message: String = {
                            if prize > 0 {
                                return "Вы проиграли. Вам удалось получить $ \(prize)!"
                            } else {
                                return "Вы проиграли!"
                            }
                        }()
                        self.headerView.sumLabel.text = message
                        self.getAlert(titel: "Вы проиграли!",
                                      message: "Сумма вашего выигрыша составила $ \(prize)!",
                                      withDelay: 7.5)
                    }
                }
                self.currentQuestionCellInfo = .init(index: self.game.currentRoundIndex)
                self.showGameScreen(round)
            }
            
            let alertCancel = UIAlertAction(title: "Нет", style: .cancel)
            self.present(alertController, animated: true, completion: nil)
            alertController.addAction(alertСonfirm)
            alertController.addAction(alertCancel)
        }
    }
    
    private func getAlert(titel: String, message: String, withDelay delay: TimeInterval? = nil) {
        
        let alertShowingBlock = {
            let alertController = UIAlertController(title: titel, message: message, preferredStyle: .alert)
            
            let alertCancel = UIAlertAction(title: "Начать новую игру", style: .cancel) {
                [weak self] _ in
                self?.dismiss(animated: true)
            }
            alertController.addAction(alertCancel)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        if let delay = delay {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                alertShowingBlock()
            }
        } else {
            alertShowingBlock()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        music.player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        switchBtnImage()
        
        playMusic()
    }
    
    private func playMusic() {
        music.playSound(nameOfMusic: "BackMusic")
        music.player?.numberOfLoops = 5
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        myTableView.backgroundColor = UIColor(red: 67/255, green: 32/255, blue: 166/255, alpha: 1)
        view.backgroundColor = UIColor(red: 67/255, green: 32/255, blue: 166/255, alpha: 1)
        myTableView.register(MyOwnCell.self, forCellReuseIdentifier: "CellID")
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    // MARK: - Setup Constrains
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(headerView)
        view.addSubview(myTableView)
        view.addSubview(footerView)
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 23),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 20),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            
        ])
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: myTableView.bottomAnchor,constant: 0),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    func showGameScreen(_ round: NewGameRound) {
        let vc =  BeginGameViewController(newGameRound: round,
                                          helpers: self.helpers)
        
        vc.ololoHandler = {
            [weak self] dict in
            self?.helpers = dict
            self?.switchBtnImage()
            
        }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

// MARK: - TableViewDataSource,TableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.gameModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? MyOwnCell  else {
            fatalError("Creating cell from HotelsListViewController failed")
        }
        cell.setupContent(
            indexPath: indexPath,
            model: game.gameModel[indexPath.row].sumOfQuestion,
            questionCellInfo: self.currentQuestionCellInfo
        )
        return cell
    }
    
    private func switchBtnImage() {
        if helpers[.oneMistake]! {
            headerView.calllFriendsButton.setImage(UIImage(named: "call"), for: .normal)
        } else {
            headerView.calllFriendsButton.setImage(UIImage(named: "call2"), for: .normal)
        }
        
        if helpers[.fiftyFifty]! {
            headerView.halfHintButton.setImage(UIImage(named: "5050"), for: .normal)
        } else {
            headerView.halfHintButton.setImage(UIImage(named: "50502"), for: .normal)
        }
        
        if helpers[.helpHall]! {
            headerView.helpRayonButton.setImage(UIImage(named: "holl"), for: .normal)
        } else {
            headerView.helpRayonButton.setImage(UIImage(named: "holl2"), for: .normal)
        }
    }
}
