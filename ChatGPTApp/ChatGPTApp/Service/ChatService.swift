//
//  ChatService.swift
//  ChatGPTApp
//
//  Created by Enrico Sousa Gollner on 16/04/23.
//

import UIKit

class ChatService: ServiceManager {
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let text = model.choices?.first?.text else {
                        completion(.failure(.missingChoiseText))  // não temos o texto
                        return
                    }
                    completion(.success(text))  // temos o texto
                case .failure(let error):
                    completion(.failure(.apiError(error)))
                }
            }
        })
    }
}
