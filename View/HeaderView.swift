//
//  headerView.swift
//  Who want to be a millionaire?
//
//  Created by Александр Косяков on 02.11.2022.
//

enum HelperButton {
    case oneMistake
    case fiftyFifty
    case helpHall
}

import UIKit
import AVFoundation

class HeaderView : UIView   {
    
    // связь с главным экраном
    var buttonHandler: (() -> Void)?
   
    let sumLabel : UILabel = {
        let titleSumLabel = UILabel()
        titleSumLabel.text = "Ваша сумма очков: "
        titleSumLabel.numberOfLines = 0
        titleSumLabel.font = UIFont.systemFont(ofSize: 20)
        titleSumLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleSumLabel.backgroundColor = .orange
        titleSumLabel.textColor = .white
        titleSumLabel.textAlignment = NSTextAlignment.center
        
        return titleSumLabel
    }()
    
    var calllFriendsButton : UIButton = {
        let callFriends = UIButton ()
        callFriends.setImage(UIImage(named: "call"), for: .normal)
        callFriends.layer.masksToBounds = true
        callFriends.layer.cornerRadius = 15
        callFriends.isUserInteractionEnabled = false
        
        return callFriends
    }()
    
    var halfHintButton : UIButton = {
        let halfButton = UIButton ()
        halfButton.setImage(UIImage(named: "5050"), for: .normal)
        halfButton.layer.masksToBounds = true
        halfButton.layer.cornerRadius = 15
        halfButton.isUserInteractionEnabled = false
        
        return halfButton
    }()
    
    var helpRayonButton : UIButton = {
        let helpRayon = UIButton ()
        helpRayon.setImage(UIImage(named: "holl"), for: .normal)
        helpRayon.layer.masksToBounds = true
        helpRayon.layer.cornerRadius = 15
        helpRayon.isUserInteractionEnabled = false
        
        return helpRayon
    }()
    
    private lazy var exitButton : UIButton = {
        let exitButton = UIButton ()
        exitButton.setImage(UIImage(named: "money"), for: .normal)
        exitButton.layer.masksToBounds = true
        exitButton.layer.cornerRadius = 15
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        return exitButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(sumLabel)
        addSubview(calllFriendsButton)
        addSubview(halfHintButton)
        addSubview(helpRayonButton)
        addSubview(exitButton)
        setupConstraints()
    }
    
    @objc func exit() {
        buttonHandler?()
    }
    
    private func setupConstraints() {
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        calllFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        halfHintButton.translatesAutoresizingMaskIntoConstraints = false
        helpRayonButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sumLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            sumLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            sumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            sumLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            sumLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            calllFriendsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            calllFriendsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            calllFriendsButton.trailingAnchor.constraint(equalTo: halfHintButton.leadingAnchor, constant: -5),
            calllFriendsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            halfHintButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            halfHintButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:100),
            halfHintButton.trailingAnchor.constraint(equalTo: helpRayonButton.leadingAnchor, constant: -5),
            halfHintButton.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([
            helpRayonButton.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            helpRayonButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 200),
            helpRayonButton.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor, constant: -5),
            helpRayonButton.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([
            
            exitButton.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            exitButton.leadingAnchor.constraint(equalTo: helpRayonButton.leadingAnchor,constant:100),
            exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            exitButton.heightAnchor.constraint(equalToConstant: 50)])
    }
}
