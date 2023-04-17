//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Illya Blinov on 15.04.23.
//

import UIKit

final class ProfileHeaderView: UIView {

    var avatarView = UIView()
    var userName = UILabel()
    var btShowStatus = UIButton()
    var txtStatus = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addSubView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        addAllFrame()
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

        userName = {
            let lebel = UILabel()
            let userNameFont = UIFont.systemFont(ofSize: 18, weight: .bold)
            lebel.text = "User Name"
            lebel.textColor = .black
            lebel.font = userNameFont
            return lebel
        }()

        btShowStatus = {
            let button = UIButton()
            button.setTitle("Show status", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.tintColor = .white
            button.layer.cornerRadius = 4
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7
            button.addTarget(self, action: #selector(btShowStatusPresed), for: .touchUpInside)
            return button
        }()


        txtStatus = {
            let text = UITextView()
            let txtStatusFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            text.text = "It's my status..."
            text.backgroundColor = self.backgroundColor
            text.textColor = .gray
            text.font = txtStatusFont
            return text
        }()
    }

    private func addSubView(){
        
        addSubview(avatarView)
        addSubview(userName)
        addSubview(btShowStatus)
        addSubview(txtStatus)
    }

    private func addAllFrame(){
        avatarView.frame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: frame.width / 3 , height: frame.width / 3 ))
        avatarView.layer.cornerRadius = avatarView.frame.height / 2

        userName.frame = CGRect(origin: CGPoint(x: avatarView.frame.maxX + 32 , y: 27), size: CGSize(width: frame.width * (2 / 3) - 64 , height: 30))

        btShowStatus.frame = CGRect(origin: CGPoint(x: 16, y: avatarView.frame.maxY + 16), size: CGSize(width: frame.width - 32, height: 50))

        txtStatus.frame = CGRect(origin: CGPoint(x: avatarView.frame.maxX + 32, y: btShowStatus.frame.minY - 34 - 24), size: CGSize(width: frame.width * (2 / 3) - 64, height: 24))
    }

    @objc func btShowStatusPresed() {
        print(txtStatus.text ?? "Empty")
    }
}
