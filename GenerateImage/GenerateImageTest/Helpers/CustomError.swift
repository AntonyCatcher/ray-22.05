//
//  CustomError.swift
//  GenerateImageTest
//
//  Created by Anton  on 24.05.2023.
//

import Foundation

enum CustomError: Error {
    case urlNotCreate
    case internetConnectionLost
    case dataError
    case saveCoreData
    
    var description: String {
        switch self {
        case .urlNotCreate:
            return "URL не создан"
        case .internetConnectionLost:
            return "Проверьте интернет соединение"
        case .dataError:
            return "Что-то не так с данными"
        case .saveCoreData:
            return "Ошибка при сохрнении"
        }
    }
}
