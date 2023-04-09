import SwiftUI

class FeedViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "Feed"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let btShowPost = UIButton(type: .system)
        btShowPost.isUserInteractionEnabled = true
        btShowPost.frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.left + 8, y: view.safeAreaInsets.top + 8), size: CGSize(width: 100, height: 20))
        btShowPost.setTitle("Show Post", for: .normal)
        btShowPost.backgroundColor = .systemYellow
        btShowPost.setTitleColor(.black, for: .normal)
        btShowPost.tintColor = .black
        btShowPost.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        view.addSubview(btShowPost)

    }
    @objc func showPost(){
        let postViewController = PostViewController()
        postViewController.getPost = Post(title: "Hello", message: "It's test text")
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
