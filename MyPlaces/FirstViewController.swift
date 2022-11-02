//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by PC-793 on 10/10/22.
//

import UIKit

class FirstViewController: UITableViewController, ManagerPlacesObserver {
    
    let manager = ManagerPlaces.shared()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        manager.addObserver(object: self)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPlace))
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return manager.GetCount()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      // Access to item using manager
        
      // Present detail controller
        
        //tableView.deselectRow(at: indexPath, animated: true)
        manager.setPlaceSelected(position: indexPath.row)
        performSegue(withIdentifier: "showDetail", sender: self)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return 100
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        cell = UITableViewCell()
        
        let wt: CGFloat = tableView.bounds.size.width
        
        let fuente: UIFont = UIFont(name: "Arial", size: 12)!
        
        let fuenteBold: UIFont = UIFont(name: "Arial-BoldMT", size: 12)!
        var place:Place = manager.GetItemAt(position: indexPath.row)
        var label: UILabel
        label = UILabel(frame: CGRect(x:50,y:35,width:wt,height:40))
        label.font = fuenteBold
        label.numberOfLines = 2
        label.text = place.name
        label.sizeToFit()
        cell.contentView.addSubview(label)
                
        
        return cell
    }
    
    @objc func newPlace(){
        manager.setPlaceSelected(position: -1)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func onPlacesChange(){
        let view: UITableView = (self.view as? UITableView)!;
        view.reloadData()
    }
}
