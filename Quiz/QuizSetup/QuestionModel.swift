//
//  QuestionModel.swift
//  Quiz
//
//  Created by Sandro Boka on 05.07.2024..
//

import Foundation

struct QuestionModel: Identifiable {
    let id = UUID()
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let allAnswers: Set<String>
}

struct QuizResponse: Decodable {
    let response_code: Int
    let results: [QuizQuestion]
}

struct QuizQuestion: Decodable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
