import UIKit

class ProfileViewController: UIViewController{
    
    let profileHeaderView = ProfileHeaderView()
    
    private let userPost = UsersPost.createPost()
    
    lazy var tableViewM: UITableView = {
        let  table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(PostCustomViewCell.self, forCellReuseIdentifier: PostCustomViewCell.identifier)
        return table
    }()
    
    lazy var photoView: UITableView = {
        let  table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return table
    }()

    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.0
        return view
    }()

    lazy var btCloseBgView: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.0
        button.addTarget(nil, action: #selector(tapBtClose), for: .touchUpInside)
        return button
    }()

    lazy var avatar: UIView = {
        let image = UIView()
        image.backgroundColor = .systemBackground
        image.layer.contents = UIImage(named: "dog")?.cgImage
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 75
        image.alpha = 1
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
    // Напоминалкв чтобы не забывть функцию
    // override func viewWillLayoutSubviews() {
    //        super.viewWillLayoutSubviews()
    //       addAllConstraints()
    //   }
    
    func setup(){
        view.backgroundColor = .lightGray
        title = "Profile"
        creatProfileHeaderView()
        self.navigationController?.navigationBar.isHidden = true
        [tableViewM, photoView].forEach { view.addSubview($0)}
        setupConstraints(cellHeight: PhotosTableViewCell().getCellH())
        setupGesture()
    }

    private func setupGesture(){
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        profileHeaderView.avatarImageView.addGestureRecognizer(tapAvatarGesture)
    }

    lazy var getAvatarFrame = profileHeaderView.avatarImageView.frame
    lazy var getAvatarCenter = profileHeaderView.avatarImageView.center

    @objc func tapAvatar(){
        view.addSubview(bgView)
        view.addSubview(avatar)
        view.addSubview(btCloseBgView)
        avatar.frame = getAvatarFrame
        setupShowingAvatarConstraints()
        view.needsUpdateConstraints()
        view.layoutIfNeeded()
        avatarAnimationOpen()
    }
    private func closeAvatarShowing(){
        self.btCloseBgView.removeFromSuperview()
        self.avatar.removeFromSuperview()
        self.bgView.removeFromSuperview()
    }

    @objc func tapBtClose() {
        avatarAnimationClose()
    }


    func avatarAnimationOpen(){
        //   let centerOrigin = avatar.center
        let finalCenter = self.view.center

        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.avatar.frame = CGRect(x: 6, y: 6, width: self.bgView.frame.width - 12, height: self.bgView.frame.width - 12)
            self.avatar.center = CGPoint(x: finalCenter.x, y: finalCenter.y)
            self.avatar.layer.cornerRadius = 2
            self.bgView.alpha = 0.5
        }

        let btAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .linear){
            self.btCloseBgView.alpha = 0.5
        }

        animator.addCompletion {_ in
            btAnimator.startAnimation(afterDelay: 0.0)
        }
        animator.startAnimation(afterDelay: 0.0)
    }

    func avatarAnimationClose(){
        let animatorBtClose = UIViewPropertyAnimator(duration: 0.3, curve: .linear){
            self.btCloseBgView.alpha = 0.0
        }
        let animatorAvatarClose = UIViewPropertyAnimator(duration: 0.5, curve: .linear){
            self.avatar.frame = self.getAvatarFrame
            self.avatar.center = self.getAvatarCenter
            self.avatar.layer.cornerRadius = 75
            self.bgView.alpha = 0
        }
        animatorBtClose.addCompletion {_ in
            animatorAvatarClose.startAnimation(afterDelay: 0.0)
        }
        animatorAvatarClose.addCompletion{_ in
            self.closeAvatarShowing()
        }
        animatorBtClose.startAnimation(afterDelay: 0.0)
    }

    
    func creatProfileHeaderView(){
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .darkGray
        view.addSubview(profileHeaderView)
    }
    
    func goToPhotosViewController(){
        let photoViewController = PhotosViewController()
        navigationController?.pushViewController(photoViewController, animated: false)
    }


    private func setupShowingAvatarConstraints(){
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            btCloseBgView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -6),
            btCloseBgView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 6),
        ])

    }
    
    private func setupConstraints(cellHeight: CGFloat){
        print(cellHeight)
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            photoView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 4),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.heightAnchor.constraint(equalToConstant: 148),
            
            tableViewM.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewM.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewM.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 2),
            tableViewM.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
extension ProfileViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewM {
            return userPost.count }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewM {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCustomViewCell.identifier, for: indexPath) as! PostCustomViewCell
            cell.setupSell(post: userPost[indexPath.row])
            return cell }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPhotosViewController()
    }
}
