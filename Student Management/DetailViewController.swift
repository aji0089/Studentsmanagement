//
//  DetailViewController.swift
//  Student Management
//
//  Created by Antriv Singh on 10/13/20.
//  Copyright © 2020 Antriv Singh. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {
    
    var name = String()
    var email = String()
    var mobileNum = String()
    var regNum = String()
    var mark = String()
    var Percentage = String()
    var ageStr = String()
    var address = String()
    var course = String()
    var gender = String()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
        var context:NSManagedObjectContext!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    @IBOutlet weak var marktxt: UITextField!
    //@IBOutlet weak var viewHeightConstant: NSLayoutConstraint!//405
    @IBOutlet weak var agetxt: UITextField!
    @IBOutlet weak var percentage: UITextField!
    @IBOutlet weak var gendertxt: UITextField!
    @IBOutlet weak var addresstxt: UITextField!
    @IBOutlet weak var courseTxt: UITextField!
    @IBOutlet weak var MarkView: UIView!
    @IBOutlet weak var percentgeView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var mobileNumTxt: UITextField!
    @IBOutlet weak var registerNumTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detail Page"
        detailView.dropShadow()
      //  heightConstant.constant = 290
      //  MarkView.isHidden = true
      //  percentgeView.isHidden = true

        nametxt.isUserInteractionEnabled = false
         emailIdTxt.isUserInteractionEnabled = false
         mobileNumTxt.isUserInteractionEnabled = false
         registerNumTxt.isUserInteractionEnabled = false
         marktxt.isUserInteractionEnabled = false
        percentage.isUserInteractionEnabled = false
        agetxt.isUserInteractionEnabled = false
        courseTxt.isUserInteractionEnabled = false
        addresstxt.isUserInteractionEnabled = false
        gendertxt.isUserInteractionEnabled = false
        marktxt.placeholder = "Enter Mark"
        percentage.placeholder = "Enter Percentage"
        agetxt.text = ageStr
        courseTxt.text = course
        addresstxt.text = address
        gendertxt.text = gender
        nametxt.text = name
        emailIdTxt.text = email
        mobileNumTxt.text = mobileNum
        registerNumTxt.text = regNum
        percentage.text = Percentage
        marktxt.text = mark
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(DeleteData))
       // let barButton = UIBarButtonItem(image: UIImage(named: "home"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(addTapped))
        //self.navigationItem.rightBarButtonItem = barButton
        // Do any additional setup after loading the view.
    }
    
    func removeCoreData() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")
         request.predicate = NSPredicate(format: "uniqueID == %@",regNum )
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

                  do {
                      try managedContext.execute(deleteRequest)
                    let alertController = UIAlertController(title: "Student management", message: "Data Delete Succefully!!!", preferredStyle: .alert)

                                                                                                 // Create the actions
                                                                                          let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                                                                     UIAlertAction in
                                                                                                     NSLog("OK Pressed")
                                        //self.navigationController?.popViewController(animated: true)
                                          let vc = self.storyboard?.instantiateViewController(identifier: "login") as! ViewController
                                          
                                          self.navigationController?.pushViewController(vc, animated: true)
                                                                                            
                                                                                                 }

                                                                                                 // Add the actions
                                                                                                 alertController.addAction(okAction)
                                                                                                // alertController.addAction(cancelAction)

                                                                                                 // Present the controller
                                                                                                 self.present(alertController, animated: true, completion: nil)
                                            
                    
                  } catch let error as NSError {
                      // TODO: handle the error
                      print(error.localizedDescription)
                  }
      
        
      
    }
    @objc func DeleteData(){
        
        
        //self.performSegue(withIdentifier: "login", sender: self)
        
        
        removeCoreData()
        
        
        
        
        
  
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    func SaveAndUpdateData(){
        
               context = appDelegate.persistentContainer.viewContext
                      let entity = NSEntityDescription.entity(forEntityName: "LoginDetails", in: context)
                      let newUser = NSManagedObject(entity: entity!, insertInto: context)
                  print("Fetching Data..")
                  let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")
               request.predicate = NSPredicate(format: "uniqueID == %@",regNum ) //"username = %@ AND password = %@"
               
                  request.returnsObjectsAsFaults = false
                  do {
                      let result = try context.fetch(request)
                   
                   if (result.count > 0){
                       
                       for data in result as! [NSManagedObject] {
                        
                        data.setValue(registerNumTxt.text, forKey: "firstname")
                               data.setValue(nametxt.text, forKey: "lastname")
                               data.setValue(mobileNumTxt.text, forKey: "mobilenumber")
                               data.setValue(emailIdTxt.text, forKey: "emailid")
                             data.setValue(marktxt.text, forKey: "mark")
                        data.setValue(percentage.text, forKey: "percentage")
                        data.setValue(agetxt.text, forKey: "age")
                         data.setValue(agetxt.text, forKey: "address")
                         data.setValue(courseTxt.text, forKey: "course")
                         data.setValue(registerNumTxt.text, forKey: "uniqueID")
                        

                        do {
                                  try context.save()
                             print("Save  Data..")
                            let alertController = UIAlertController(title: "Student management", message: "Data Saved Successfuly!!!!!!", preferredStyle: .alert)

                                                                                 // Create the actions
                                                                          let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                                                     UIAlertAction in
                                                                                     NSLog("OK Pressed")
                        //self.navigationController?.popViewController(animated: true)
    let vc:UserListViewController = self.storyboard?.instantiateViewController(identifier: "UserListViewController") as! UserListViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                                                                            
                                                                                 }

                                                                                 // Add the actions
                                                                                 alertController.addAction(okAction)
                                                                                // alertController.addAction(cancelAction)

                                                                                 // Present the controller
                                                                                 self.present(alertController, animated: true, completion: nil)
                            
                        }
                        catch
                        {
                            
                            
                            
                        }
                    
                    }
                       
                       
                   }
                    
        }
        catch{
                    
                    
        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        
        SaveAndUpdateData()
        
    }
 
    
    @IBAction func edit(_ sender: Any) {
        
        
      nametxt.isUserInteractionEnabled = true
     // registerNumTxt.isUserInteractionEnabled = true
        percentage.isUserInteractionEnabled = true
               agetxt.isUserInteractionEnabled = true
               courseTxt.isUserInteractionEnabled = true
               addresstxt.isUserInteractionEnabled = true
         gendertxt.isUserInteractionEnabled = true
        mobileNumTxt.isUserInteractionEnabled = true
        emailIdTxt.isUserInteractionEnabled = true
    }
    @IBAction func addMark(_ sender: Any) {
        
        
       marktxt.isUserInteractionEnabled = true
       percentage.isUserInteractionEnabled = true
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
  extension UIView {

    func dropShadow() {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowRadius = 1
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = UIScreen.main.scale
//        layer.cornerRadius = 5
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
       layer.shadowOffset =  CGSize.zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
    }
}
extension UIView {

    func dropShadow2() {

        var shadowLayer: CAShapeLayer!
        let cornerRadius: CGFloat = 16.0
        let fillColor: UIColor = .white

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()

            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: -2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
