//
//  PostView.swift
//  Navigation
//
//  Created by Illya Blinov on 17.06.23.
//

import Foundation

import UIKit

final class PostView: UIView {

    lazy var postImage: UIView = {
        let image = UIView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var postText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.textAlignment = .left
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showPost(post: UsersPost){
        postImage.layer.contents = UIImage(named: post.image)?.cgImage
        postText.text = post.description
        
    }

    func layout(){
        self.addSubview(postImage)
        self.addSubview(postText)
        self.backgroundColor = .white
        setupConstraints()
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([

            postImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            postImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            postImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),

            postText.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 8),
            postText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            postText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])

    }


}
