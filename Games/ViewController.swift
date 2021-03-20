//
//  ViewController.swift
//  Games
//
//  Created by english on 2020-12-01.
//  Copyright © 2020 AkhilaMadhuri. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    var name: String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signup(_ sender: Any) {
        
    }
    @IBAction func login(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")
        fetchRequest.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(fetchRequest)
            if(results.count>0){
                
                
                for result in results as! [NSManagedObject]{
                    
                    if (result.value(forKey: "username") as? String == username.text ){
                        if(result.value(forKey: "password") as? String == password.text){
                            if let name = result.value(forKey: "name") as? String{
                                causeAlert(message: "Welcome!", title: "Hello \(name)", true)
                                self.name = name
                            }
                        }
                    }
                }
            }
        }catch{
            print("Failure")
        }
        causeAlert(message: "Error!", title: "Either username or Password is incorrect")
        
    }
    func causeAlert(message : String , title : String, _ success : Bool = false ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction =  UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            if(success){
                self.performSegue(withIdentifier: "seg1", sender: nil)
            }
            
        }
        
        
        alert.addAction(okAction)
        present(alert,animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "seg1"){
            if let destination = segue.destination as? chooseGameViewController{
                destination.name = self.name
            }
        }
    }
}

