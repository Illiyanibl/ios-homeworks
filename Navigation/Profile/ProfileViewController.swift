import SwiftUI
class ProfileViewController: UIViewController{
    let profileHeaderView = ProfileHeaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        creatProfileHeaderView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.safeAreaLayoutGuide.layoutFrame
        profileHeaderView.backgroundColor = .lightGray
    }
    func creatProfileHeaderView(){
        view.addSubview(profileHeaderView)
    }
}
