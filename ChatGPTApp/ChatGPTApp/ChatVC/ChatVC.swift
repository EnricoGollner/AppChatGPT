//
//  ViewController.swift
//  ChatGPTApp
//
//  Created by Enrico Sousa Gollner on 16/04/23.
//

import UIKit
import AVFoundation

class ChatVC: UIViewController {
    
    private var screen: ChatScreen?
    private var viewModel: ChatViewModel = ChatViewModel()
    
    var player: AVAudioPlayer?
    
    override func loadView() {
        self.screen = ChatScreen()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate(delegate: self)
        //        viewModel.featchMessage(message: "Crie uma função com swift")
        screen?.delegate(delegate: self)
        screen?.configTableView(delegate: self, dataSource: self)
    }
    
}

extension ChatVC: ChatViewModelProtocol {
    func success() {
        print("Show! Deu certo!")
    }
    
    func error(message: String) {
        print("Deu ruim: \(message)")
    }
}

extension ChatVC: ChatScreenProtocol {
    public func sendMessage(text: String) {
        screen?.sendButton.touchAnimation()
        playSound()
        viewModel.addMessage(message: text, type: .user)
        screen?.reloadData()
        pushMessage()
    }
    
    private func pushMessage() {
        self.screen?.inputMessageTextField.text = ""
        self.screen?.sendButton.isEnabled = false
        self.screen?.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print("Erro ao tocar o som: \(error.localizedDescription)")
        }
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.loadCurrentMessage(indexPath: indexPath)
        
        switch message.typeMessage {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.setUpCell(data: message)
            return cell ?? UITableViewCell()
        case .chatGPT:
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.setUpCell(data: message)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(indexPath: indexPath)
    }
}
