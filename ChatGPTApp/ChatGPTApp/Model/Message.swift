//
//  Message.swift
//  ChatGPTApp
//
//  Created by Enrico Sousa Gollner on 20/05/23.
//

import UIKit

enum TypeMessage {
    case user
    case chatGPT
}

struct Message {
    var message: String
    var date: Date
    var typeMessage: TypeMessage
}
