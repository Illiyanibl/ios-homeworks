import UIKit

class PostViewController: UIViewController {

    var getPost: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        if let getPost {
            title = getPost.title
        } else {
            title = "No title"
        }
        let rightButton : UIBarButtonItem = UIBarButtonItem(title: "Info", style: UIBarButtonItem.Style.plain, target: self, action: #selector(openInfo))
        self.navigationItem.rightBarButtonItem = rightButton
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let messageLabel = UILabel()
        messageLabel.frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.left + 8, y: view.safeAreaInsets.top + 8), size: CGSize(width: 100, height: 20))
        messageLabel.text = getPost?.message
        view.addSubview(messageLabel)
    }
    
    @objc func openInfo(){
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
