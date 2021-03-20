//
//  StonePaperScissorsViewController.swift
//  Games
//
//  Created by english on 2020-12-06.
//  Copyright © 2020 AkhilaMadhuri. All rights reserved.
//

import UIKit

class StonePaperScissorsViewController: UIViewController {

    @IBOutlet weak var ResultText: UILabel!
       var Images = ["rock","paper","scissors"]
        var result = "";
        var UserChoice = -1;
        @IBOutlet weak var ComputerSelection: UIImageView!
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            ResultText.text="";
           
        }

        
        @IBAction func StartGame(_ sender: UIButton) {
            
             let choice = Int.random(in: 0..<3)
          

            
            
            UserChoice = sender.tag
            ComputerSelection.image = UIImage(named: Images[choice])
              
            
            if(UserChoice == choice){
                result = "It is a draw!";
            }
            else if(UserChoice == 0){
                if(choice == 1){
                    result = "You lose!";
                }
                else{
                    result = "You win"
                }
            }
            
            else if(UserChoice == 1){
                if(choice == 0){
                    result = "You win!";
                }
                else{
                    result = "You lose!";
                }
            }
            
            else if(UserChoice == 2){
                if(choice == 0){
                    result = "You lose!";
                }
                else{
                    result = "You win!";
                }
            }
            
            ResultText.text = result;
            
        }
        
    }

