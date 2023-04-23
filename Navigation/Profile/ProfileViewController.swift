import UIKit

final class ProfileViewController: UIViewController{

    let profileHeaderView = ProfileHeaderView()

    let newButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("We are wating new finction!", for: .normal)
        return button
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

            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
