//
//  testViewController.swift
//  appdocu
//
//  Created by thuylinh on 8/12/20.
//  Copyright © 2020 thuylinh. All rights reserved.
//

import UIKit
import SDWebImage

class testViewController: UIViewController {
    @IBOutlet weak var mota: UILabel!
    var NewFeedDetails : NewFeedDetail!

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        mota.text = NewFeedDetails!.motacongthuc
        // Do any additional setup after loading the view.
//        image.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/appdocu-2c67f.appspot.com/o/imagefoler1%2FplXsi7C1EJayZlREg0gir9MUEqK2?alt=media&token=93582bea-6a58-4823-8aca-fb49ec2edcf7"), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
