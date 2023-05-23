//
//  ChatViewModel.swift
//  ChatGPTApp
//
//  Created by Enrico Sousa Gollner on 16/04/23.
//

import UIKit

protocol ChatViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class ChatViewModel {
    
    private var service: ChatService = ChatService()
    private var messageList: [Message] = []
    
    private weak var delegate: ChatViewModelProtocol?
    
    public func delegate(delegate: ChatViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func featchMessage(message: String) {
        service.sendOpenAIRequest(text: message) { [weak self] result in  //
            guard let self else { return }
            
            switch result {
            case .success(let success):
                print(success)
                self.delegate?.success()
            case .failure(let failure):
                self.delegate?.error(message: failure.localizedDescription)
            }
        }
    }
    
    public func addMessage(message: String, type: TypeMessage) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), date: Date(), typeMessage: type), at: .zero)
    }
    
    public var numberOfRowsInSection: Int {
        return messageList.count
    }
    
    public func loadCurrentMessage(indexPath: IndexPath) -> Message {
        return messageList[indexPath.row]
    }
    
    public func heightForRow(indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
