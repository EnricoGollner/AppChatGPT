//
//  ViewController.swift
//  CHATGPT
//
//

import UIKit
import OpenAISwift

enum OpenAIError: Error {
    case missingChoiseText
    case apiError(Error)
}

class ViewController: UIViewController {
    
    var openAIModelType: OpenAIModelType = .gpt3(.davinci)
    var token: OpenAISwift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        token = OpenAISwift(authToken: API.authToken)
        sendOpenAIRequest(text: "Crie uma função com swift") { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token?.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let text = model.choices.first?.text else {
                        completion(.failure(.missingChoiseText))
                        return
                    }
                    completion(.success(text))
                case .failure(let error):
                    completion(.failure(.apiError(error)))
                }
            }
        })
    }
    
    
    
    
}

