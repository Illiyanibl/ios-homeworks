//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Illya Blinov on 15.04.23.
//

import UIKit

class ProfileHeaderView: UIView {

    var avatarView = UIView()
    var userName = UILabel()
    var btShowStatus = UIButton()
    var txtStatus = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        avatarView.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: frame.width / 3 , height: frame.width / 3 ))
        avatarView.layer.cornerRadius = avatarView.frame.height / 2

        userName.frame = CGRect(origin: CGPoint(x: avatarView.frame.maxX + 32 , y: 27), size: CGSize(width: frame.width * (2 / 3) - 64 , height: 30))

        btShowStatus.frame = CGRect(origin: CGPoint(x: 16, y: avatarView.frame.maxY + 16), size: CGSize(width: frame.width - 32, height: 50))
        btShowStatus.layer.cornerRadius = 4
        btShowStatus.layer.shadowOffset = CGSize(width: 4, height: 4)
        btShowStatus.layer.shadowRadius = 4
        btShowStatus.layer.shadowColor = UIColor.black.cgColor
        btShowStatus.layer.shadowOpacity = 0.7

        txtStatus.frame = CGRect(origin: CGPoint(x: avatarView.frame.maxX + 32, y: btShowStatus.frame.minY - 34 - 24), size: CGSize(width: frame.width * (2 / 3) - 64, height: 24))
    }

    func setupViews() {

        avatarView = {
            $0.backgroundColor = .systemBackground
            $0.layer.contents = UIImage(named: "dog")?.cgImage
            $0.layer.masksToBounds = true
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 3
            return $0
        }(UIView())

        let userNameFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        userName.text = "User Name"
        userName.textColor = .black
        userName.font = userNameFont

        btShowStatus.setTitle("Show status", for: .normal)
        btShowStatus.setTitleColor(.white, for: .normal)
        btShowStatus.backgroundColor = .systemBlue
        btShowStatus.tintColor = .white
        btShowStatus.addTarget(self, action: #selector(btShowStatusPresed), for: .touchUpInside)

        let txtStatusFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        txtStatus.text = "It's my status..."
        txtStatus.backgroundColor = self.backgroundColor
        txtStatus.textColor = .gray
        txtStatus.font = txtStatusFont

        addSubview(avatarView)
        addSubview(userName)
        addSubview(btShowStatus)
        addSubview(txtStatus)
    }

    @objc func btShowStatusPresed() {
        print(txtStatus.text ?? "Empty")
    }
}
