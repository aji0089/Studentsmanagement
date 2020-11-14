//
//  RegisterViewController.swift
//  Student Management
//
//  Created by Antriv Singh on 10/13/20.
//  Copyright © 2020 Antriv Singh. All rights reserved.
// 

import UIKit
import CoreData
class RegisterViewController: UIViewController {
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var registerNumTxt: UITextField!
    @IBOutlet weak var genderTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var courseTxt: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mobileNum: UITextField!
    @IBOutlet weak var registerbutton: UIButton!
    
    // MARK: Variables declearations
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "registration"
        registerbutton.layer.cornerRadius = 5
        registerbutton.layer.borderColor = UIColor.lightGray.cgColor
        registerbutton.layer.borderWidth = 0.5
        
        // Do any additional setup after loading the view.
    }
    // MARK: Methods to Open, Store and Fetch data
    func openDatabse()
    {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LoginDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newUser)
    }
    func saveData(UserDBObj:NSManagedObject)
    {
        UserDBObj.setValue(firstname.text, forKey: "firstname")
        UserDBObj.setValue(lastName.text, forKey: "lastname")
        UserDBObj.setValue(mobileNum.text, forKey: "mobilenumber")
        UserDBObj.setValue(emailId.text, forKey: "emailid")
      UserDBObj.setValue(confirmPassword.text, forKey: "password")
         UserDBObj.setValue(addressTxt.text, forKey: "address")
         UserDBObj.setValue(ageTxt.text, forKey: "age")
         UserDBObj.setValue(courseTxt.text, forKey: "course")
         UserDBObj.setValue(genderTxt.text, forKey: "gender")
         UserDBObj.setValue(registerNumTxt.text, forKey: "uniqueID")
        //uniqueID
      
        print("Storing Data..")
        do {
            try context.save()
             print("Storing")
            // Create the alert controller
                   let alertController = UIAlertController(title: "Student management", message: "Registration Success", preferredStyle: .alert)

                   // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                       UIAlertAction in
                       NSLog("OK Pressed")
                self.navigationController?.popViewController(animated: true)
                   }

                   // Add the actions
                   alertController.addAction(okAction)
                  // alertController.addAction(cancelAction)

                   // Present the controller
                   self.present(alertController, animated: true, completion: nil)
            
          
            
        } catch {
            print("Storing data Failed")
        }
    }
    

    @IBAction func registerAction(_ sender: Any) {
        
        if firstname.text == "" || lastName.text == "" || mobileNum.text == "" || emailId.text == "" {
            
            let alertController = UIAlertController(title: "Student management", message: "All feilds are mandatory", preferredStyle: .alert)

                            // Create the actions
                     let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                NSLog("OK Pressed")
                         //self.dismiss(animated: true, completion: nil)
                            }

                            // Add the actions
                            alertController.addAction(okAction)
                           // alertController.addAction(cancelAction)

                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
        }
        else{
             openDatabse()
            
        }
        
       
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
