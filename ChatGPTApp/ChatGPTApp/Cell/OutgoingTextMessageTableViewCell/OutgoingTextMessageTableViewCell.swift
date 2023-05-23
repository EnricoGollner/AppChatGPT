//
//  OutgoingTextMessageTableViewCell.swift
//  ChatGPTApp
//
//  Created by Enrico Sousa Gollner on 20/05/23.
//

import UIKit

class OutgoingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: OutgoingTextMessageTableViewCell.self)
    
    lazy var myMessageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .pink
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.helveticaNeueMedium(size: 16)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        transform = CGAffineTransform(scaleX: 1, y: -1)
        selectionStyle = .none
        backgroundColor = .backGround
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(myMessageView)
        myMessageView.addSubview(messageLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            myMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            myMessageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            myMessageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageLabel.leadingAnchor.constraint(equalTo: myMessageView.leadingAnchor, constant: 15),
            messageLabel.topAnchor.constraint(equalTo: myMessageView.topAnchor, constant: 15),
            messageLabel.bottomAnchor.constraint(equalTo: myMessageView.bottomAnchor, constant: -15),
            messageLabel.trailingAnchor.constraint(equalTo: myMessageView.trailingAnchor, constant: -15)
        ])
    }
    
    public func setUpCell(data: Message) {
        messageLabel.text = data.message
    }
    
}
