import UIKit

final class ProfileHeaderView: UIView {

    let avatarImageView = {
        $0.backgroundColor = .systemBackground
        $0.layer.contents = UIImage(named: "dog")?.cgImage
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 3
        $0.layer.cornerRadius = 75
        return $0
    }(UIView())

    let fullNameLabel = {
        let lebel = UILabel()
        let userNameFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        lebel.text = "User Name"
        lebel.textColor = .black
        lebel.font = userNameFont
        return lebel
    }()

    let statusLabel = {
        $0.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        $0.textColor = .gray
        $0.text = "It's empty label"
        return $0
    }(UILabel())

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

    override func point(inside point: CGPoint,
                        with event: UIEvent?) -> Bool
    {
        let inside = super.point(inside: point, with: event)
        if !inside {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return inside
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
