//
//  AlertService.swift
//  GenerateImageTest
//
//  Created by Anton  on 24.05.2023.
//

import UIKit

class CustomAlert {
    
    func alert(title: String?,
               message: String?,
               actionTitle: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle,
                                   style: .default)
        alertController.addAction(action)
        
        return alertController
    }
    
    func alertImageTransform() -> UIAlertController  {
        return alert(
            title:"Ошибка",
            message: "Изображение не преобразовано",
            actionTitle: "Ок")
    }
    
    func alertImageDowload(error: CustomError) -> UIAlertController  {
        return alert(title:"Ошибка",
                     message: error.description,
                     actionTitle: "Ок")
    }
    
    func alertStopDowload() -> UIAlertController  {
        return alert(
            title: "Подождите",
            message: "Повторная загрузка будет доступна через 5 секунд",
            actionTitle: "Ок")
    }
    
    func alertImageAdded() -> UIAlertController  {
        return alert(
            title: "Изображение добавлено в избранное",
            message: nil,
            actionTitle: "Oк")
    }
}
