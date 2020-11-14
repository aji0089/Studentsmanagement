//
//  UserListViewController.swift
//  Student Management
//
//  Created by Antriv Singh on 10/13/20.
//  Copyright © 2020 Antriv Singh. All rights reserved.
//

import UIKit
import CoreData
class UserListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tble: UITableView!
    var quotes = [LoginDetails]()
    var email  = String()
    var phonenum = String()
    var name = String()
    var registernum = String()
    var mark  = String()
    let onlyDateArr = NSArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
        var context:NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationController?.navigationBar.isHidden = true
       
        self.title = "user List"
         tble.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         fetchData()
         self.navigationItem.setHidesBackButton(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tble.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        if quotes[indexPath.row].lastname != nil{
             cell.isHidden = false
             cell.name.text = "Name : \(quotes[indexPath.row].lastname ?? "")"
             cell.email.text = "Email ID : \(quotes[indexPath.row].emailid ?? "")"
             cell.registerNum.text = "Mobile Number : \(quotes[indexPath.row].mobilenumber ?? "")"
        }
        else{
            
            cell.isHidden = true
        }
 
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc:DetailViewController = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        vc.email = quotes[indexPath.row].emailid ?? ""
        vc.name = quotes[indexPath.row].firstname ?? ""
        vc.regNum = quotes[indexPath.row].uniqueID ?? ""
        vc.mobileNum = quotes[indexPath.row].mobilenumber ?? ""
        vc.mark = quotes[indexPath.row].mark ?? ""
        vc.Percentage = quotes[indexPath.row].percentage ?? ""
        vc.ageStr = quotes[indexPath.row].age ?? ""
        vc.course = quotes[indexPath.row].course ?? ""
        vc.address = quotes[indexPath.row].address ?? ""
        vc.gender = quotes[indexPath.row].gender ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if quotes[indexPath.row].lastname != nil{
            
               return 120
        }
        else
         {
               return 0
            
        }
     
    }
    
    func fetchData(){

        //onlyDateArr.removeAll()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")

        do {
            let results = try context.fetch(fetchRequest)
            let  dateCreated = results as NSArray
            for data in results as! [LoginDetails] {
//
                
                DispatchQueue.main.async {
                  // your code here
                    self.quotes.append(data)
                    self.tble.reloadData()
                }
                                          
                }
            print(quotes)
        }catch let err as NSError {
            print(err.debugDescription)
        }


    }
//    func fetchData()
//          {
//           context = appDelegate.persistentContainer.viewContext
//                  let entity = NSEntityDescription.entity(forEntityName: "LoginDetails", in: context)
//                  let newUser = NSManagedObject(entity: entity!, insertInto: context)
//              print("Fetching Data..")
//              let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginDetails")
//          // request.predicate = NSPredicate(format: "mobilenumber == %@ AND password == %@", username.text ?? "",password.text ?? "") //"username = %@ AND password = %@"
//
//              request.returnsObjectsAsFaults = false
//              do {
//                  let result = try context.fetch(request)
//
//               if (result.count > 0){
//
//                   for data in result as! [NSManagedObject]
//                   {
//
//                    print(data)
//
////                            let Name = data.value(forKey: "lastname") as! String
////                            let Mobile = data.value(forKey: "mobilenumber") as! String
////                                  let Password = data.value(forKey: "password") as! String
////                                  let email = data.value(forKey: "emailid") as! String
////                                  let registrationnum = data.value(forKey: "firstname") as! String
////                                     print("User Name is : "+Name+" and Mobile is : "+Mobile+"Email id is"+email+"registration number"+registrationnum)
//
//
//
//                    }
//
//                }
//            }
//            catch{
//
//
//
//            }
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NSManagedObject {
  func toJSON() -> String? {
    let keys = Array(self.entity.attributesByName.keys)
    let dict = self.dictionaryWithValues(forKeys: keys)
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        return reqJSONStr
    }
    catch{}
    return nil
  }
}
