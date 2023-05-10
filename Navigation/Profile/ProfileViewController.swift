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

    lazy var photosTableView: UITableView = {
      let  table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return table
    }()

     let photoView: PhotosTableViewCell = {
         let  view = PhotosTableViewCell()
           view.translatesAutoresizingMaskIntoConstraints = false

         return view
     }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Profile"
        createAllView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addAllConstraints()
    }
    
    func createAllView(){
        creatProfileHeaderView()
        view.addSubview(tableViewM)
        view.addSubview(photoView)
        view.addSubview(newButton)
    }

    func creatProfileHeaderView(){
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        profileHeaderView.backgroundColor = .darkGray
        view.addSubview(profileHeaderView)
    }
    
    private func addAllConstraints(){
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


            tableViewM.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           tableViewM.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           tableViewM.topAnchor.constraint(equalTo: photoView.bottomAnchor),
            tableViewM.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewM {
           return userPost.count }
        else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCustomViewCell.identifier, for: indexPath) as! PostCustomViewCell
        cell.setupSell(post: userPost[indexPath.row])


 //       let photosCell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell

        if tableView == tableViewM {
           return cell }
        else {
            return cell
        }

    }


}
