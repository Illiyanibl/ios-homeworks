import UIKit

class ProfileViewController: UIViewController{
    
    let profileHeaderView = ProfileHeaderView()
    private var userPost = UsersPost.createPost()
    
    lazy var tableViewM: UITableView = {
        let  table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PostCustomViewCell.self, forCellReuseIdentifier: PostCustomViewCell.identifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
        [tableViewM].forEach { view.addSubview($0)}
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
        //   profileHeaderView.backgroundColor = .darkGray
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

            tableViewM.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewM.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewM.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 2),
            tableViewM.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ProfileViewController: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = PhotosTableViewCell()
            header.callBackTapView = { [weak self] in
                guard let self = self else { return}
                self.navigationController?.pushViewController(PhotosViewController(), animated: false)
            }
            return header }
        else {
            return nil
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCustomViewCell.identifier, for: indexPath) as! PostCustomViewCell
        cell.setupSell(post: userPost[indexPath.row])
        
        cell.callBack = { [weak self] in
            guard let self = self else { return }
            self.userPost[indexPath.row].likes += 1
            cell.setupSell(post: self.userPost[indexPath.row])
            
        }
        
        cell.callBackImageTap = { [weak self] in
            guard let self = self else { return }
            self.userPost[indexPath.row].views += 1
            cell.setupSell(post: self.userPost[indexPath.row])
            let post = PostView()
            post.showPost(post: self.userPost[indexPath.row])
            let postController = UIViewController()
            postController.view = post
            self.navigationController?.present(postController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewM {}
        else {
            goToPhotosViewController()
        }
    }
}
