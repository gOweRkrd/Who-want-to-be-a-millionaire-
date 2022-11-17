//
//  RulesViewController.swift
//  Who want to be a millionaire?
//
//  Created by Alexander Altman on 01.11.2022.
//

import UIKit
import AVFoundation

class RulesViewController: UIViewController {
    
    let music = MusicModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Правила игры"
        label.font = .boldSystemFont(ofSize: 50)

        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitleColor(.yellow, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.setTitle("Назад", for: .normal)
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        setUpViews()
        setConstraints()
        music.playSound(nameOfMusic: "Rules Music")
    }
    
    @objc func buttonPressed(_ sender:UIButton) {
        music.playSound(nameOfMusic: "Button Push")
        self.dismiss(animated: true)
    }
    
    private func setUpViews() {
        view.addSubview(headerLabel)
        view.addSubview(backButton)
        view.addSubview(scrollView)
        contentView.addSubview(subtitleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        let rules = Rules()
        label.text = rules.rules
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .italicSystemFont(ofSize: 19)
        label.textColor = UIColor.lightGray // цвет текста
        label.textAlignment = .justified // выравнивание текста по ширине
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Background image set
    func assignbackground(){
        let background = UIImage(named: "rulesBackground")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: Constraints
extension RulesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
}
