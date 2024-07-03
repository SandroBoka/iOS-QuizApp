//
//  Enums.swift
//  Quiz
//
//  Created by Sandro Boka on 03.07.2024..
//

import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    case random = "Random"
    case general = "General Knowledge"
    case books = "Entertainment: Books"
    case film = "Entertainment: Film"
    case music = "Entertainment: Music"
    case musicalAndTheatres = "Entertainment: Theatre"
    case tv = "Entertainment: Television"
    case videoGames = "Entertainment: Video games"
    case boardGames = "Entertainment: Board games"
    case nature = "Science: Nature"
    case computers = "Science: Computers"
    case math = "Science: Mathematics"
    case mithology = "Mithology"
    case sports = "Sports"
    case geography = "Geography"
    case history = "History"
    case politics = "Politics"
    case art = "Art"
    case celebrites = "Celebrities"
    case animals = "Animals"
    case vehicles = "Vehicles"
    case comics = "Entertainment: Comics"
    case gadgets = "Science: Gadgets"
    case mangaAndAnime = "Entertainment: Manga/Anime"
    case animationAndCartoons = "Entertainment: Animation/Cartoons"
    
    var id: String { self.rawValue }
}

enum Difficulty: String, CaseIterable, Identifiable {
    case any = "Any"
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var id: String { self.rawValue }
}

enum QuestionType: String, CaseIterable, Identifiable {
    case any = "Any"
    case multipleChoice = "Multi-Choice"
    case trueFalse = "True/False"
    
    var id: String { self.rawValue }
}

let categoryDictionary: [Category: Int] = [
    .general: 9,
    .books: 10,
    .film: 11,
    .music: 12,
    .musicalAndTheatres: 13,
    .tv: 14,
    .videoGames: 15,
    .boardGames: 16,
    .nature: 17,
    .computers: 18,
    .math: 19,
    .mithology: 20,
    .sports: 21,
    .geography: 22,
    .history: 23,
    .politics: 24,
    .art: 25,
    .celebrites: 26,
    .animals: 27,
    .vehicles: 28,
    .comics: 29,
    .gadgets: 30,
    .mangaAndAnime: 31,
    .animationAndCartoons: 32,
]

let typeDictionary: [QuestionType: String] =  [
    .multipleChoice: "multiple",
    .trueFalse: "boolean"
]
