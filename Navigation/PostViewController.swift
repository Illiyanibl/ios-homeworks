import UIKit

class PostViewController: UIViewController {

    var getPost: Post?
    let messageLabel = UILabel()
    lazy var rightButton : UIBarButtonItem = UIBarButtonItem(title: "Info", style: UIBarButtonItem.Style.plain, target: self, action: #selector(openInfo))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        if let getPost {
            title = getPost.title
        } else {
            title = "No title"
        }
        self.navigationItem.rightBarButtonItem = rightButton
        view.addSubview(messageLabel)
        messageLabel.text = getPost?.message
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        messageLabel.frame = CGRect(origin: CGPoint(x: 8, y: view.safeAreaInsets.top + 8), size: CGSize(width: 100, height: 20))
    }
    
    @objc func openInfo(){
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
