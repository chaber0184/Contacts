//
//  MasterViewController.swift
//  Final_DHC0015_Sp22
//
//  Created by Dimitri Chaber on 4/19/22.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items: [Contact] = []
    var newFlag = false
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = items[indexPath.row]
        cell.textLabel!.text = object.lastname + " , " + object.firstname
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let objectToBeMoved = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(objectToBeMoved, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue){
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let fileURL = dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path)) {
            //let items = NSArray(contentsOfFile: file.path) as? [[String:String]]
            do{
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                items = try decoder.decode(Array<Contact>.self, from: data)
            }
            catch{
                print(error)
            }
            
        }
        else{
            print("file not found")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
    

  
    @IBAction func editPressed(_ sender: UIButton) {
        
        tableView.isEditing = !tableView.isEditing
        if sender.currentTitle == "Done"{
            sender.setTitle("Edit", for: .normal)
        }
        else{
            sender.setTitle("Done", for: .normal)
        }
    }
    
    @IBAction func addPressed(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = (segue.destination as! DetailViewController)
        controller.masterViewController = self
        if segue.identifier == "showDetail"{
            if let selected = tableView.indexPathForSelectedRow{
                
                
                controller.itemIndex = selected.row
                
            }
            
        }
        else{
            controller.itemIndex = 0
            let newObject = Contact()
            items.insert(newObject, at: 0)
            newFlag = true
        }
    }
    
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent("data.json")
        return url!
    }
    
    @objc func applicationWillResignActive(notification: NSNotification){
        let fileURL = self.dataFileURL()
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self.items) {
            do{ try data.write(to: fileURL)
                print("wrote data using coding")
                
            }
            catch{
                print(error)
            }
        }
        //let array = (self.items as NSArray)
        //array.write(to: fileURL as URL, atomically: true)
    }
    

}
