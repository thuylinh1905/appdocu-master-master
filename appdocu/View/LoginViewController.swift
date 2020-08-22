import UIKit
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var buttongoogle: UIButton!
    @IBOutlet weak var buttonface: UIButton!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpass: UITextField!
    @IBOutlet weak var buttonsigin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navibutton()
        self.addimagetextfield(textfield: txtemail, image: UIImage(named: "mail")!)
        self.addimagetextfield(textfield: txtpass, image: UIImage(named: "password")!)
        self.hidenavi()
        self.hideKeyboard()
//        txtemail.attributedPlaceholder = NSAttributedString(string: "Mời nhập Email",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
   
    func navibutton() {
           let btnCancel = UIButton()
        btnCancel.setImage(UIImage(named: "back"), for: .normal)
           btnCancel.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
           btnCancel.addTarget(self, action:  #selector(goToSettings), for: .touchUpInside)
           let leftBarButton = UIBarButtonItem()
           leftBarButton.customView = btnCancel
           self.navigationItem.leftBarButtonItem = leftBarButton
       }
       @objc func  goToSettings(){
           let delegate = UIApplication.shared.delegate as! AppDelegate
           delegate.gotoOnboarding()
       }
    
    @IBAction func login(_ sender: Any) {
        SVProgressHUD.show(withStatus: "Đang đăng nhập...")
        if var email = txtemail.text ,var  pass = txtpass.text{
            self.view.endEditing(true)
            Auth.auth().signIn(withEmail: "minh02@gmail.com", password: "Linh19051998") { (result, error) in
                if error != nil{
                    SVProgressHUD.showError(withStatus: "Tài khoản chưa được tạo")
                } else{
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.gototabbar()
                }
            }
        }
    }
    @IBAction func signin(_ sender: Any) {
    }
}
extension LoginViewController {
    func Alertcontroller(messege : String) {
        let alertcontroller = UIAlertController(title: "thong bao", message: messege, preferredStyle: .actionSheet)
        if messege == "dang nhap thanh cong" {
            let button1 = UIAlertAction(title: "OK", style: .default) { (action) in
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.gotoHome()
                self.txtemail.text = ""
                self.txtpass.text = ""
            }
            alertcontroller.addAction(button1)
        } else {
            let button2 = UIAlertAction(title: "Thu lai", style: .cancel){(action) in
                self.txtemail.text = ""
                self.txtpass.text = ""
            }
            alertcontroller.addAction(button2)
        }
        self.present(alertcontroller, animated: true, completion: nil)
    }
}
