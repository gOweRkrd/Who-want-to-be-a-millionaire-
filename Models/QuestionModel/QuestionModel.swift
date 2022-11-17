//
//  QuestionModel.swift
//  Who want to be a millionaire?
//
//  Created by Alexander Altman on 04.11.2022.
//

import Foundation

struct Question: Decodable {
    let question: String
    let answeres: [String]
    let correctAnswer: String
    let questionLevel: String
    
    init(i:Int,q: String, a: [String], ca: String, ql: String) {
        question = q
        answeres = a
        correctAnswer = ca
        questionLevel = ql
    }
}
