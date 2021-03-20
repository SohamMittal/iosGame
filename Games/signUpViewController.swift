//
//  signUpViewController.swift
//  Games
//
//  Created by english on 2020-12-06.
//  Copyright © 2020 AkhilaMadhuri. All rights reserved.
//

import UIKit
import CoreData

class signUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtConfirmPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var btnSignup: UIButton!
    
   
    fileprivate func SaveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let newLogin = NSEntityDescription.insertNewObject(forEntityName: "LoginDetails", into: context)
        
        //Atributes
        newLogin.setValue(txtName.text!, forKey: "name")
        newLogin.setValue(txtUsername.text!, forKey: "username")
        
        newLogin.setValue(txtPass.text!, forKey: "password")
        
               
        do{
            
            try context.save()
            causeAlert(message: "Sign up Successfull!", title: "Success!", true)
            
        }catch{
            causeAlert(message: "Sign up unsuccessfull!")
        }
    }
    
    func isUniqueUsername() -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext;
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")
        fetchRequest.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(fetchRequest)
            if(results.count>0){
                
                
                for result in results as! [NSManagedObject]{
                    
                    if (result.value(forKey: "username") as? String == txtUsername.text ){
                        return false
                    }
                }
             
            }
            else{
                return true
            }
        }catch{
            print("Failure")
        }
        return true
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        if(txtName.text?.count == 0){
            causeAlert(message: "Please enter your name!")
            return
        }
        else if(txtUsername.text?.count == 0){
            causeAlert(message: "Please enter your username!")
            return
        }
        else if(!isUniqueUsername()){
            causeAlert(message: "The username must be unique")
        }
        else if((txtPass.text?.count)! < 8){
            causeAlert(message: "The password must be atleast 8 charachters long")
        }
        else if(txtPass.text != txtConfirmPass.text){
            causeAlert(message: "The passwords do not match!")
            return
        }
        
       SaveData()
    }
    
    func causeAlert(message : String , title : String = "Error!", _ goBack : Bool = false){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction =  UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
            if(goBack){
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        
        alert.addAction(okAction)
        present(alert,animated: true, completion: nil)
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
