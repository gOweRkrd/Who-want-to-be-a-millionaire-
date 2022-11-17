
import UIKit
import AVFoundation

class StartGameViewController: UIViewController {
    var player: AVAudioPlayer?
    let music = MusicModel()

    private lazy var moneyBackgraundImage = UIImage(named: "Background")
    private lazy var logoBackgraundImage = UIImage(named: "Logo")
    private lazy var imageStartButton = UIImage(named: "PlayButton")
    private lazy var imageRuleButton = UIImage(named: "RulesButton")
    private lazy var stackButtonView = UIStackView()
    private lazy var startBackgroundView = UIImageView()
    private lazy var logoImageView = UIImageView(image: logoBackgraundImage)
    private lazy var startButton = UIButton()
    private lazy var rulesButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForView()
        setupUI()
        player?.prepareToPlay()
        playMainMusic()
        startBackgroundView.isUserInteractionEnabled = true
        
        startButton.addTarget(self, action: #selector(showGameVC), for: .touchUpInside)
        rulesButton.addTarget(self, action: #selector(showRulesVC), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        music.player?.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      playMainMusic()
    }
}

extension StartGameViewController {

    private func playMainMusic() {
        music.playSound(nameOfMusic: "StartSound")
        music.player?.numberOfLoops = 5
    }
    
    private func settingsForView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        startBackgroundView.contentMode = .scaleAspectFill
        startBackgroundView.image = moneyBackgraundImage
        startBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackButtonView = UIStackView(arrangedSubviews: [startButton, rulesButton])
        stackButtonView.axis = .horizontal
        stackButtonView.distribution = .fillEqually
        stackButtonView.spacing = 10
        stackButtonView.translatesAutoresizingMaskIntoConstraints = false
        startButton.setBackgroundImage(imageStartButton, for: .normal)
        rulesButton.setBackgroundImage(imageRuleButton, for: .normal)
    }
    
    private func setupUI() {
        view.addSubview(startBackgroundView)
        startBackgroundView.addSubview(logoImageView)
        startBackgroundView.addSubview(stackButtonView)
        
        NSLayoutConstraint.activate([
            startBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            startBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            logoImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 1.0),
            logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            stackButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            stackButtonView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 30),
            startButton.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }
    
    @objc func showGameVC() {
        music.playSound(nameOfMusic: "Button Push")
        let gameVC = MainViewController()
        gameVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(gameVC, animated: true)
        }
    }
    
    @objc func showRulesVC() {
        music.playSound(nameOfMusic: "Button Push")
        let rulesVC = RulesViewController()
        rulesVC.modalPresentationStyle = .fullScreen
        present(rulesVC, animated: true)
    }
}
