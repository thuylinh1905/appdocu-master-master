import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var buttlogup: UIButton!
    @IBOutlet weak var buttonsigin: UIButton!
    @IBOutlet weak var image : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.buttonchangehome(button: buttlogup)
        Utilities.buttonchangehome(button: buttonsigin)
        image.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        let user = Auth.auth().currentUser
        if (user != nil) {
            print("hhiajkds")
        } else {
            print("loi roi")
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        let signupviewcontroller = SignupViewController()
        navigationController?.pushViewController(signupviewcontroller, animated: true)
    }
    @IBAction func signin(_ sender: Any) {
        let loginViewcontroller = LoginViewController()
        navigationController?.pushViewController(loginViewcontroller, animated: true)
    }
}
extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func hidenavi() {
           self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
             self.navigationController?.navigationBar.shadowImage = UIImage()
             self.navigationController?.navigationBar.isTranslucent = true
             self.navigationController?.view.backgroundColor = .clear
    }
    func addimagetextfield(textfield : UITextField, image : UIImage) {
           textfield.leftViewMode = UITextField.ViewMode.always
           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (image.size.width), height: (image.size.height)))
           imageView.image = image
           textfield.leftView = imageView
       }
}
