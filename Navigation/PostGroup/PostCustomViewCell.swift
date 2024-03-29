import UIKit

final class PostCustomViewCell: UITableViewCell {
    
    var callBack: (() -> Void)?
    var callBackImageTap: (() -> Void)?
    
    
    let authorLabel: UILabel = {
        let label = UILabel()
        let labelFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .white
        label.font = labelFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    let liksView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.2
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        let labelFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.backgroundColor = .white
        label.font = labelFont
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.font = labelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImage: UIView = {
        let image = UIView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemBackground
        return image
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        let labelFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = labelFont
        label.textColor = .black
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        let labelFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.font = labelFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.layer.contents = nil
        descriptionLabel.text = nil
        likesLabel.text = nil
        viewsLabel.text = nil
        authorLabel.text = nil
    }
    func setupSell(post: UsersPost){
        authorLabel.text = post.author
        postImage.layer.contents = UIImage(named: post.image)?.cgImage
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: " + String(post.likes)
        viewsLabel.text = "Views: " + String(post.views)
        
    }
    
    func setupGesture(){
        let tapLikeGesture = UITapGestureRecognizer(target: self, action: #selector(tapLike))
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        liksView.addGestureRecognizer(tapLikeGesture)
        postImage.addGestureRecognizer(tapImageGesture)
        
    }
    @objc func tapLike(){
        callBack?()
    }
    
    @objc func tapImage(){
        print("Tap image")
        callBackImageTap?()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [authorLabel, descriptionLabel, postImage, likesLabel, viewsLabel, liksView].forEach {contentView.addSubview($0) }
        self.backgroundColor = .systemBackground
        setConstraints()
        setupGesture()
    }
    
    
    private func setConstraints(){
        
        let indentLeftRight: CGFloat = 16
        NSLayoutConstraint.activate([
            
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: indentLeftRight),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indentLeftRight),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentLeftRight),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: indentLeftRight),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.7),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: indentLeftRight),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indentLeftRight),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentLeftRight),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: indentLeftRight),
            viewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: indentLeftRight),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indentLeftRight),
            
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: indentLeftRight),
            likesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -indentLeftRight),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -indentLeftRight),
            
            liksView.centerXAnchor.constraint(equalTo: likesLabel.centerXAnchor),
            liksView.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
            liksView.widthAnchor.constraint(equalTo: likesLabel.widthAnchor),
            liksView.heightAnchor.constraint(equalTo: likesLabel.heightAnchor),
        ])
    }
}
