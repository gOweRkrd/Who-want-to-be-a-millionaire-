
import UIKit
import AVFoundation

class BossViewController: UIViewController {
    var player: AVAudioPlayer?

    var stackButtonView = UIStackView()
    var stackLogoView = UIStackView()
    var startBackgroundView = UIImageView()
    var logoImageView = UIImageView()
    var startButton = UIButton()
    var rulesButton = UIButton()
    let moneyBackgraundImage = UIImage(named: "Background")
    let logoBackgraundImage = UIImage(named: "Logo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundAndButtonView()
        setupStackButtonView()
        setupStackLogoView()
        playSound(nameOfMusic: "Thinking")
        startButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        rulesButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    func backgroundAndButtonView(){
        // Do any additional setup after loading the view.
        startBackgroundView = UIImageView(frame: self.view.bounds)
        startBackgroundView.contentMode = .scaleAspectFill
        startBackgroundView.center = view.center
        startBackgroundView.image = moneyBackgraundImage
        view.addSubview(startBackgroundView)
        
        logoImageView = UIImageView(image: logoBackgraundImage)
        view.addSubview(logoImageView)
        
        startButton.setBackgroundImage(UIImage.init(named: "PlayButton"), for: .normal)
        view.addSubview(startButton)
        rulesButton.setBackgroundImage(UIImage.init(named: "RulesButton"), for: .normal)
        view.addSubview(rulesButton)
    }
}

extension BossViewController {
    // Настраиваем наш stackView
    private func setupStackButtonView() {
        // В массиве мы указываем что хотим поместить в stack. В нашем случае это три кнопки.
        stackButtonView = UIStackView(arrangedSubviews: [startButton, rulesButton])
        // Добавляем наш stack на основной view.
        view.addSubview(stackButtonView)
        // Кнопки будут расположены вертикально.
        stackButtonView.axis = .horizontal
        // Параметр .fillEqually означает, что все вложенные представления будут изменены так, чтобы они были одинаковой высоты (для вертикального стека).
        stackButtonView.distribution = .fillEqually
        // Отступ между кнопками
        stackButtonView.spacing = 10
        stackButtonView.translatesAutoresizingMaskIntoConstraints = false
        // Закрепляем наш stack констрейнтами.
        NSLayoutConstraint.activate([
            stackButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
       //     stackButtonView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor,constant: 500),
            stackButtonView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -90)
        ])
    }
    
    private func setupStackLogoView(){
        // В массиве мы указываем что хотим поместить в stack. В нашем случае это три кнопки.
        stackLogoView = UIStackView(arrangedSubviews: [logoImageView])
        logoImageView.contentMode = .scaleAspectFill
        // Добавляем наш stack на основной view.
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }
    func playSound(nameOfMusic: String) {
            let url = Bundle.main.url(forResource: nameOfMusic, withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
        }
    
    @objc func pressButton(_ sender: UIButton) {
        print("hi")
        playSound(nameOfMusic: "Choose")
    }
}

import SwiftUI
struct ListProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    struct ContainterView: UIViewControllerRepresentable {
        let listVC = BossViewController()
        func makeUIViewController(context:
                                  UIViewControllerRepresentableContext<ListProvider.ContainterView>) -> BossViewController {
            return listVC
        }
        func updateUIViewController(_ uiViewController:
                                    ListProvider.ContainterView.UIViewControllerType, context:
                                    UIViewControllerRepresentableContext<ListProvider.ContainterView>) {
        }
    }
}
