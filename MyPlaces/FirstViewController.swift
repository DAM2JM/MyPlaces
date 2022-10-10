//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by PC-793 on 10/10/22.
//

import UIKit

class FirstViewController: UITableViewController {
    
    let manager = ManagerPlaces.shared()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        
        // UILabel and UIImageView
        //if(indexPath.row < (manager.GetCount()-1)){
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
        
        /*var labelDes: UILabel
        labelDes = UILabel(frame: CGRect(x:20,y:40,width:wt,height:40))
        labelDes.font = fuente
        labelDes.numberOfLines = 2
        labelDes.text = place.description
        labelDes.sizeToFit()
        cell.contentView.addSubview(labelDes)*/
        //}
        
        //let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
        //imageIcon.frame = CGRect(x:10, y:50, width:50, height:50)
        //cell.contentView.addSubview(imageIcon)
        
        
        return cell
    }

}
