//
//  ViewController.swift
//  Student Management
//
//  Created by Antriv Singh on 10/13/20.
//  Copyright © 2020 Antriv Singh. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    // MARK: Variables declearations
     let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
     var context:NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameView.layer.cornerRadius = 4
        passwordView.layer.cornerRadius = 4
        usernameView.layer.borderWidth = 0.5
        usernameView.layer.borderColor = UIColor.darkGray.cgColor
        passwordView.layer.borderColor = UIColor.darkGray.cgColor
        passwordView.layer.borderWidth = 0.5
        
        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
        loginButton.layer.borderWidth = 0.5
    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationItem.setHidesBackButton(true, animated: true)
       }
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationItem.setHidesBackButton(false, animated: false)
       }
    
    func fetchData()
       {
        context = appDelegate.persistentContainer.viewContext
               let entity = NSEntityDescription.entity(forEntityName: "LoginDetails", in: context)
               let newUser = NSManagedObject(entity: entity!, insertInto: context)
           print("Fetching Data..")
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")
        request.predicate = NSPredicate(format: "mobilenumber == %@ AND password == %@", username.text ?? "",password.text ?? "") //"username = %@ AND password = %@"
        
           request.returnsObjectsAsFaults = false
           do {
               let result = try context.fetch(request)
            
            if (result.count > 0){
                
                for data in result as! [NSManagedObject] {
                                  let Name = data.value(forKey: "lastname") as! String
                                  let Mobile = data.value(forKey: "mobilenumber") as! String
                               let Password = data.value(forKey: "password") as! String
                               let email = data.value(forKey: "emailid") as! String
                               let registrationnum = data.value(forKey: "firstname") as! String
                                  print("User Name is : "+Name+" and Mobile is : "+Mobile+"Email id is"+email+"registration number"+registrationnum)
                               
                              }
                
                self.performSegue(withIdentifier: "gotolist", sender: self)
                
            }
            else{
                
                print("nodata")
                let alertController = UIAlertController(title: "Student management", message: "Not a registerd User", preferredStyle: .alert)

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
              
           } catch {
               print("Fetching data Failed")
           }
       }



    @IBAction func loginAction(_ sender: Any) {
        
         fetchData()
    }
}

