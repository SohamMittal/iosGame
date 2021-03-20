//
//  chooseGameViewController.swift
//  Games
//
//  Created by english on 2020-12-06.
//  Copyright © 2020 AkhilaMadhuri. All rights reserved.
//

import UIKit

class chooseGameViewController: UIViewController {

    @IBOutlet weak var txtChooseGame: UILabel!
    var name: String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        txtChooseGame.text = "Choose your game \(name)"
        // Do any additional setup after loading the view.
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
