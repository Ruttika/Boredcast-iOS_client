//
//  MessengerVC.swift
//  Boredcast
//
//  Created by Rudolf Dani on 2018. 09. 24..
//  Copyright © 2018. Rudolf Dani. All rights reserved.
//

import UIKit

class MessengerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
