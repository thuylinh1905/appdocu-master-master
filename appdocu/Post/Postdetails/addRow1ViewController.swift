//
//  addRow1ViewController.swift
//  appdocu
//
//  Created by thuylinh on 9/4/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit

protocol addrowcongthuc {
    func addrow(congthuc : String)
}

class addRow1ViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    var delegate : addrowcongthuc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func navibutton() {
        let btnok = UIButton()
        btnok.setTitle("Ok", for: .normal)
        btnok.addTarget(self, action: #selector(getdata), for: .touchUpInside)
        let rightbarbutton = UIBarButtonItem()
        rightbarbutton.customView = btnok
        self.navigationItem.rightBarButtonItem = rightbarbutton
    }
    
    @objc func getdata() {
        delegate?.addrow(congthuc: textview.text)
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
