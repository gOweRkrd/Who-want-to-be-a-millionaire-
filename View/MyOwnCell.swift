//
//  MyOwnCell.swift
//  Who want to be a millionaire?
//
//  Created by Александр Косяков on 02.11.2022.
//

import Foundation
import UIKit

class MyOwnCell: UITableViewCell  {
    
    var buttonAction: (() -> Void)?

    // MARK: - Costomize cell
   private lazy var labelNumber : UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 25)
        title.font = UIFont.boldSystemFont(ofSize: 25)
        title.textColor = .white
        
        return title
    }()
    
    private let myImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "dollar")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var coinLabel : UILabel = {
        let coin = UILabel()
        coin.font = UIFont.systemFont(ofSize: 20)
        coin.font = UIFont.boldSystemFont(ofSize: 20)
        coin.textColor = .white
        return coin
    }()
  
    // MARK: - Lifecycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        self.contentView.addSubview(labelNumber)
        self.contentView.addSubview(myImageView)
        self.contentView.addSubview(coinLabel)
        self.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 50
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupContent(
        indexPath: IndexPath,
        model: Int,
        questionCellInfo: MainViewController.QuestionCellInfo?
    ) {
        labelNumber.text = String(model)
        self.contentView.backgroundColor = self.cellColor(indexPath: indexPath.row)
        
        if let questionCellInfo = questionCellInfo,
            indexPath.row >= questionCellInfo.index {
            self.contentView.backgroundColor = questionCellInfo.color
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // задаем расположение наших элементов в ячейке
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.frame.size.height - 6

        labelNumber.frame = CGRect (x: 55,
                                    y: 5,
                                    width: 200,
                                    height: contentView.frame.size.height)
        
        myImageView.frame = CGRect (x: 230,
                                    y: 3,
                                    width: imageSize,
                                    height: imageSize)
    }
    
    private func cellColor(indexPath: Int) -> UIColor {
        if indexPath % 15 == 0 {
            return .systemYellow
        } else if indexPath % 5 == 0 {
            return .cyan
        } else {
            return .blue
        }
    }
}
