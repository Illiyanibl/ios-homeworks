import UIKit

class ProfileViewController: UIViewController{
    
    let profileHeaderView = ProfileHeaderView()
    
    let newButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(">", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(newByttonTarget), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    @objc func newByttonTarget() {
        let photoView = PhotosViewController()
        navigationController?.pushViewController(photoView, animated: false)
    }
    
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
        view.addSubview(tableViewM)
        view.addSubview(photoView)
        view.addSubview(newButton)
        setupConstraints(cellHeight: PhotosTableViewCell().getCellH())
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
    
    private func setupConstraints(cellHeight: CGFloat){
        print(cellHeight)
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            newButton.widthAnchor.constraint(equalToConstant: 30),
            newButton.heightAnchor.constraint(equalTo: newButton.widthAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.topAnchor.constraint(equalTo: profileHeaderView.topAnchor),
            
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
