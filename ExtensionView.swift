//
//  ExtensionView.swift
//  Who want to be a millionaire?
//
//  Created by Админ on 04.11.2022.
//

import UIKit

extension BeginGameViewController {
    
    func configureView() {
        setupStack()
        setConstraints()
        setButtonLine()
    }
    
    func setupStack(){
        
        answerStack.axis = .vertical
        answerStack.distribution = .fillEqually
        answerStack.spacing = 6
        
        helpStack.axis = .horizontal
        helpStack.distribution = .fillEqually
        helpStack.spacing = 15
        
        letterStack.axis = .vertical
        letterStack.distribution = .fillEqually
        letterStack.backgroundColor = .red
        letterStack.spacing = 20
    }
    
    func imageViewSettings(){
        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = backgroundImage
        imageView.center = view.center
        imageView.contentMode = .scaleToFill
    }
    
    func setupView(){
        view.addSubview(imageView)
        view.addSubview(queshionsLabel)
        view.addSubview(scoreLabel)
        view.addSubview(answerStack)
        view.addSubview(helpStack)
        view.addSubview(timerDisplay)
        imageView.layer.addSublayer(circleTimer.pulsingLayer)
        imageView.layer.addSublayer(circleTimer.circleLayer)
        imageView.layer.addSublayer(circleTimer.progressLayer)
    }
    
    func createHelpButton(title: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: title), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 3
        button.tag = tag
        return button
    }
    
    func createAnsverButton(title: String, tag: Int) -> UIButton{
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Image1"), for: .normal)
        //button.backgroundColor = .red
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 2
        button.tag = tag
        return button
    }
    
// MARK: - Timer Sittings
    func updateTimer() {
        
        if roundTime >= 0 {
            roundTime -= 1
            circleTimer.durationLine += 0.034
            timerDisplay.text = "\(roundTime)"
            self.circleTimer.progressLayer.strokeEnd = self.circleTimer.durationLine
            DispatchQueue.main.async {
                self.circleTimer.animatePulsingLayer()
            }
        } else {
            if roundTime <= 1 {
                timerDisplay.textColor = .yellow
                timerDisplay.text = "0"
            }
        }
        if roundTime < 6 {
            circleTimer.progressLayer.strokeColor = UIColor.red.cgColor
        } else {
            circleTimer.progressLayer.strokeColor = color2.cgColor
        }
    }
    
    func timeTic() {
    
            self.newGameRound.remainingRoundSecHandler = {
                [weak self] _ in
                guard let self = self else { return }
                self.updateTimer()
            }
        }
    
//MARK: - Load questions and SumPrize
    func gameData() {
        scoreLabel.text = "$\(newGameRound.roundData.sumOfQuestion)"
        queshionsLabel.text = newGameRound.roundData.question.question
    }
    
    
// MARK: - Button Setings
    
    func setButtonLine(){
        
        //MARK: ADD HELPButton
        firstHelpButton = createHelpButton(title: "call", tag: 4)
        firstHelpButton.addTarget(self, action:#selector(mistakeHelpButtonPressed), for: .touchUpInside)
        helpStack.addArrangedSubview(firstHelpButton)
        
        secondHelpButton = createHelpButton(title: "5050", tag: 5)
        secondHelpButton.addTarget(self, action:#selector(fiftyHelpButtonPressed), for: .touchUpInside)
        helpStack.addArrangedSubview(secondHelpButton)
        
        thirtHelpButton = createHelpButton(title: "holl", tag: 6)
        thirtHelpButton.addTarget(self, action:#selector(helpButtonPressed), for: .touchUpInside)
        helpStack.addArrangedSubview(thirtHelpButton)
        
        fourHelpButton = createHelpButton(title: "money", tag: 7)
        fourHelpButton.addTarget(self, action:#selector(moneyHelpButtonPressed), for: .touchUpInside)
        helpStack.addArrangedSubview(fourHelpButton)
        
        //MARK: ADD ANSWERButton
        
        firstAnswerButton = createAnsverButton(title: newGameRound.roundData.question.answeres[0], tag: 0)
        firstAnswerButton.addTarget(self, action: #selector(answerButtonLogic), for: .touchUpInside)
        answerStack.addArrangedSubview(firstAnswerButton)
        
        secondAnswerButton = createAnsverButton(title: newGameRound.roundData.question.answeres[1], tag: 1)
        secondAnswerButton.addTarget(self, action: #selector(answerButtonLogic), for: .touchUpInside)
        answerStack.addArrangedSubview(secondAnswerButton)
        
        thirtAnswerButton = createAnsverButton(title: newGameRound.roundData.question.answeres[2], tag: 2)
        thirtAnswerButton.addTarget(self, action: #selector(answerButtonLogic), for: .touchUpInside)
        answerStack.addArrangedSubview(thirtAnswerButton)
        
        fourAnswerButton = createAnsverButton(title: newGameRound.roundData.question.answeres[3], tag: 3)
        fourAnswerButton.addTarget(self, action: #selector(answerButtonLogic), for: .touchUpInside)
        answerStack.addArrangedSubview(fourAnswerButton)

    }
    
// MARK: - Constreints Settings
    
    func setConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        timerDisplay.translatesAutoresizingMaskIntoConstraints = false
        timerDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        timerDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        timerDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerDisplay.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -10).isActive = true
        
        scoreLabel.topAnchor.constraint(equalTo: timerDisplay.bottomAnchor, constant: 10).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        scoreLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -140).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: queshionsLabel.topAnchor, constant: 20).isActive = true
        
        queshionsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5).isActive = true
        queshionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        queshionsLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        queshionsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25).isActive = true
        queshionsLabel.bottomAnchor.constraint(equalTo: answerStack.topAnchor, constant: -1).isActive = true
        
        answerStack.translatesAutoresizingMaskIntoConstraints = false
        answerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerStack.topAnchor.constraint(equalTo: queshionsLabel.bottomAnchor, constant: 15).isActive = true
        answerStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40).isActive = true
        answerStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        answerStack.bottomAnchor.constraint(equalTo: helpStack.topAnchor, constant: -7).isActive = true
        
        helpStack.translatesAutoresizingMaskIntoConstraints = false
        helpStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        helpStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helpStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        helpStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        
        landscape =  [
            
            timerDisplay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            timerDisplay.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 10),
            timerDisplay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerDisplay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 50),
            scoreLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -260),
            scoreLabel.bottomAnchor.constraint(equalTo: queshionsLabel.topAnchor, constant: 20),
            
            queshionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            queshionsLabel.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 140),
            queshionsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -70),
            queshionsLabel.bottomAnchor.constraint(equalTo: answerStack.topAnchor, constant: -1),
            
            answerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerStack.topAnchor.constraint(equalTo: queshionsLabel.bottomAnchor, constant: 50),
            answerStack.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 300),
            answerStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -120),
            answerStack.bottomAnchor.constraint(equalTo: helpStack.topAnchor, constant: -7),
            
            helpStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            helpStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helpStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            helpStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -300)
        ]
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
        isLandscape = UIDevice.current.orientation.isLandscape
            if isLandscape {
                print("Landscape")
                NSLayoutConstraint.activate(landscape!)
                answerStack.axis = .horizontal
                answerStack.backgroundColor = .orange
                helpStack.spacing = 60
                helpStack.backgroundColor = .blue
            } else {
                print("Portrait")
                NSLayoutConstraint.deactivate(landscape!)
                answerStack.axis = .vertical
                answerStack.backgroundColor = .clear
                helpStack.spacing = 15
                helpStack.backgroundColor = .clear
            }
        }
}

private var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale.current
    return formatter
  }()

extension UIButton {
    
    func blink(enabled: Bool = true, duration: CFTimeInterval = 0.5, stopAfter: CFTimeInterval = 4.8 ) {
        enabled ? (UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 0.8 },
            completion: { [weak self] _ in self?.alpha = 1.0 })) : self.layer.removeAllAnimations()
        
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in
                self?.layer.removeAllAnimations()
            }
        }
    }
}



