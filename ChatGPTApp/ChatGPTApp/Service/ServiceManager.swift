//
//  ServiceManager.swift
//  ChatGPTApp
//
//  Created by Enrico Sousa Gollner on 16/04/23.
//

import UIKit
import OpenAISwift

enum OpenAIError: Error {
    case missingChoiseText
    case apiError(Error)
}

class ServiceManager {  // Responsabilidade única - O ServiceManager faz uma configuração que podemos reutilizar em qualquer outra classe.
    
    let openAIModelType: OpenAIModelType = .gpt3(.davinci)
    let token = OpenAISwift(authToken: API.authToken)
    
    
}
