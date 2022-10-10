//
//  DetailController.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import UIKit

class DetailController: UIViewController {
    
    let manager = ManagerPlaces.shared()
        
    @IBOutlet var scrollview:UIScrollView!;
    @IBOutlet var titulo:UITextField!
    @IBOutlet var desc:UITextField!
    @IBOutlet var update:UIButton!
    @IBOutlet var delete:UIButton!
    
    var place:Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        scrollview.contentSize = CGSize(width: 0.0, height: 1000);
         place = manager.getPlaceSelected()
        titulo.text = place?.name
        desc.text = place?.description
        
        update = UIButton(type: .system, primaryAction: UIAction(handler: {_ in self.updatePlace()}))
        delete = UIButton(type: .system, primaryAction: UIAction(handler: {_ in self.deletePlace()}))
        
        
    }
    
    
    @IBAction func deletePlace(){
        print("DELETE")
        manager.remove(manager.getPlaceSelected())
    }
    @IBAction func updatePlace(){
        print("update")
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
