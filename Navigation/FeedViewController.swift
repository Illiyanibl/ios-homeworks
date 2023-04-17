import UIKit

final class FeedViewController: UIViewController{
    var btShowPost = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "Feed"
        let xO = view.safeAreaLayoutGuide.layoutFrame.minX
        let yO = view.safeAreaLayoutGuide.layoutFrame.minY
        print("\(xO) and \(yO)")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
        addSubView()
        let xO = view.safeAreaLayoutGuide.layoutFrame.minX
        let yO = view.safeAreaLayoutGuide.layoutFrame.minY
        print("\(xO) and \(yO)")
    }
    
    private func setupView(){

        btShowPost = {
            let button = UIButton(type: .system)
            button.isUserInteractionEnabled = true
            button.frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.left + 8, y: view.safeAreaInsets.top + 8), size: CGSize(width: 100, height: 20))
            button.setTitle("Show Post", for: .normal)
            button.backgroundColor = .systemYellow
            button.setTitleColor(.black, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(showPost), for: .touchUpInside)
            return button
        }()
    }
    private func addSubView(){
        view.addSubview(btShowPost)
    }

    @objc func showPost(){
        let postViewController = PostViewController()
        postViewController.getPost = Post(title: "Hello", message: "It's test text")
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
