//
//  RegisterViewController.swift
//  Student Management
//
//  Created by Ajith on 10/14/20.
//  Copyright © 2020 Ajith. All rights reserved.
//

import UIKit
import CoreData
class RegisterationViewController: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var mobileNum: UITextField!
    @IBOutlet weak var emailId: UITextField!
    
    // MARK: Variables declearations
      let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
      var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Registration"
        openDatabse()
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
        UserDBObj.setValue(lastname.text, forKey: "lastname")
        UserDBObj.setValue(emailId.text, forKey: "emailid")
         UserDBObj.setValue(mobileNum.text, forKey: "mobilenumber")

        print("Storing Data..")
        do {
            try context.save()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Storing data Failed")
        }

    }

    @IBAction func registerAction(_ sender: Any) {
        
        openDatabse()
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

