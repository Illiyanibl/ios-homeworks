import UIKit

final class ProfileHeaderView: UIView {
    
    let avatarImageView = {
        let image = UIView()
        image.backgroundColor = .systemBackground
        image.layer.contents = UIImage(named: "dog")?.cgImage
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 75
        return image
    }()
    
    let fullNameLabel = {
        let lebel = UILabel()
        let userNameFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        lebel.text = "User Name"
        lebel.textColor = .black
        lebel.font = userNameFont
        return lebel
    }()
    
    let statusLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = .gray
        label.text = "It's empty label"
        return label
    }()
    
    let setStatusButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(nil, action: #selector(btShowStatusPresed), for: .touchUpInside)
        return button
    }()
    
    
    let statusTextField = {
        let text = UITextField()
        let txtStatusFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        text.placeholder = "It's my status..."
        text.backgroundColor = .white
        text.textColor = .gray
        text.font = txtStatusFont
        text.layer.cornerRadius = 12
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.borderWidth = 1
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        addConstraints()
    }
    
    func setupViews() {
        let allSubView = [avatarImageView, fullNameLabel, setStatusButton, statusTextField, statusLabel]
        ([self] + allSubView).forEach() {$0.translatesAutoresizingMaskIntoConstraints = false}
        allSubView.forEach() {self.addSubview($0)}
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageView.layer.cornerRadius * 2),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func btShowStatusPresed() {
        print(statusTextField.text ?? "Empty")
        statusLabel.text = statusTextField.text ?? ""
    }
}
