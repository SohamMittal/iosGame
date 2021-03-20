//
//  hitThehamsterViewController.swift
//  Games
//
//  Created by english on 2020-12-06.
//  Copyright © 2020 AkhilaMadhuri. All rights reserved.
//

import UIKit

class hitThehamsterViewController: UIViewController {
    var hits = 0;
    var timer : Timer?
    var count = 0.0
    var currentHamsterAt = -1;
    @IBOutlet weak var time: UILabel!
    let hole = UIImage(named: "hole");
    let hamster = UIImage(named: "hamster")
    
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    
    
    
    fileprivate func initButtons() {
        // Do any additional setup after loading the view.
        for btn in btns {
            btn.setImage(hole, for: UIControl.State.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButtons()
        
        btnStop.isEnabled = false;
        
        
        
    }
    @IBOutlet var btns: [UIButton]!
    @IBOutlet weak var txtHits: UILabel!
    
    @objc func action () {
        count = count + 0.1;
        
        time.text = String(format: "%.1f", count) + "s"
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if(sender.currentImage == hamster){
            hits = hits + 1
            txtHits.text = String(hits)
            replay()
        }
        
    }
    
   
    @IBAction func stop(_ sender: Any) {
        timer?.invalidate();
        timer = nil;
        ChangeStop(false)
        ChangeStart(true)
        btnStart.alpha = 1
        btnStop.alpha = 0.5
        
    }
    @IBAction func start(_ sender: UIButton) {
        initButtons()
        startTimer()
        createHamster()
        ChangeStart(false)
        ChangeStop(true);
        btnStart.alpha = 0.5
        btnStop.alpha = 1
        
        
        
        
        //btn10.setImage(UIImage(named: "hole"), for: UIControl.State.normal)
    }
    func replay(){
           initButtons();
           createHamster()
       }
    func ChangeStart(_ choice : Bool){
        btnStart.isEnabled = choice;
    }
    
    func ChangeStop(_ choice : Bool){
        btnStop.isEnabled = choice;
    }
    
    func createHamster(){
        var number = 0;
        if(currentHamsterAt == -1){
            number = Int.random(in: 0...8)
        }
        else{
            while(number == currentHamsterAt){
                number = Int.random(in: 0...8)
            }
        }
        btns[number].setImage(hamster, for: UIControl.State.normal)
        currentHamsterAt = number
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
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
