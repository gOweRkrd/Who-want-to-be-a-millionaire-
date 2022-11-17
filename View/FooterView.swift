
import UIKit
import AVFoundation

class FooterView : UIView {
    
    var buttonFooter: (() -> Void)?
    
    let music = MusicModel()
    
    var switchButton : UIButton = {
        let switchNextScreen = UIButton ()
        switchNextScreen.setTitle("Продолжить.....", for: .normal)
        switchNextScreen.layer.masksToBounds = true
        switchNextScreen.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
        return switchNextScreen
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFooter()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     func setupFooter() {
        addSubview(switchButton)
        setupConstraintsFooter()
    }
    
    @objc func nextScreen() {
        buttonFooter?()
        music.playSound(nameOfMusic: "Button Push")
    }
    private func setupConstraintsFooter() {

        switchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            switchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            switchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            switchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            switchButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
