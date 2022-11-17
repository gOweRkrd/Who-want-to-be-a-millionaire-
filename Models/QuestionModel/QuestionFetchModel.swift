//
//  QuestionFetchModel.swift
//  Who want to be a millionaire?
//
//  Created by Alexander Altman on 09.11.2022.
//

import Foundation

class QuestionFetchModel {
    let fetchModel = QuestionFetchModel.loadFetchModel()
    
    static func loadFetchModel() -> [Question] {
        guard let modelURL = Bundle.main.url(forResource: "QuestionsData", withExtension: "plist") else { return [] }
        var fetchModels = [Question]()
        do {
            let data = try Data(contentsOf: modelURL)
            let decoder = PropertyListDecoder()
            fetchModels = try decoder.decode([Question].self, from: data)
            let rawQuestionsData = fetchModels.shuffled()
            
            var easyQuestions: [Question] = []
            var mediumQuestions: [Question] = []
            var hardQuestions: [Question] = []
            
            var counter = 0
            
            for i in 0...rawQuestionsData.count - 1 where counter <= 15 {
                
                if rawQuestionsData[i].questionLevel == "easy" && easyQuestions.count < 5 {
                    easyQuestions.append(rawQuestionsData[i])
                    counter += 1
                } else if rawQuestionsData[i].questionLevel == "medium" && mediumQuestions.count < 5 {
                    mediumQuestions.append(rawQuestionsData[i])
                    counter += 1
                } else if rawQuestionsData[i].questionLevel == "hard" && hardQuestions.count < 5 {
                    hardQuestions.append(rawQuestionsData[i])
                    counter += 1
                }
            }
            fetchModels = easyQuestions + mediumQuestions + hardQuestions
            
        } catch {
            print(error)
        }
//        print(fetchModels)
        return fetchModels
    }
}
