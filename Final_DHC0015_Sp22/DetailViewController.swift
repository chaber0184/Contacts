//
//  DetailViewController.swift
//  Final_DHC0015_Sp22
//
//  Created by Dimitri Chaber on 4/19/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var lastText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var zipText: UITextField!
    @IBOutlet weak var streetText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    var masterViewController: MasterViewController!
    var itemIndex = 0

    
    @IBAction func cancelPressed(_ sender: Any) {
        if masterViewController.newFlag == true{
            masterViewController.items.remove(at: 0)
            masterViewController.tableView.reloadData()
            masterViewController.newFlag = false
        }
    }
  
    @IBAction func callPressed(_ sender: Any) {
        guard let number = URL(string: "tel://" + phoneText.text!)else{
            print("Invalid number")
            return}
        UIApplication.shared.open(number)
    }
    @IBAction func savePressed(_ sender: Any) {
        masterViewController.items[itemIndex].firstname = nameText.text!
        masterViewController.items[itemIndex].lastname = lastText.text!
        masterViewController.items[itemIndex].state = stateText.text!
        masterViewController.items[itemIndex].city = cityText.text!
        masterViewController.items[itemIndex].street = streetText.text!
        masterViewController.items[itemIndex].zip = zipText.text!
        masterViewController.items[itemIndex].phone = phoneText.text!
        masterViewController.items.sort(by: {$0.lastname < $1.lastname})
        masterViewController.tableView.reloadData()
    }
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(itemIndex)
        
        nameText.text = masterViewController.items[itemIndex].firstname
        lastText.text = masterViewController.items[itemIndex].lastname
        stateText.text = masterViewController.items[itemIndex].state
        cityText.text = masterViewController.items[itemIndex].city
        streetText.text = masterViewController.items[itemIndex].street
        zipText.text = masterViewController.items[itemIndex].zip
        phoneText.text = masterViewController.items[itemIndex].phone
       
        
    }
    

}
