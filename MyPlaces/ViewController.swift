//
//  ViewController.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import UIKit

class ViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection
    section: Int) -> Int {
    // Número de elmentos del manager
        return 2
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
    // Sirve para indicar subsecciones de la lista. En nuestro casodevolvemos
    // 1 porque no hay subsecciones.
    return 1;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath:IndexPath) {
    // Detectar pulsación en un elemento.
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath:
    IndexPath) -> CGFloat {
    // Devolver la altura de la fila situada en una posición determinada.
        return 100
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:
    IndexPath) -> UITableViewCell {
    // devolver una instancia de la clase UITableViewCell que pinte la fila   / /seleccionada.
        
        var cell: UITableViewCell
        cell = UITableViewCell()
        
        let wt: CGFloat = tableView.bounds.size.width
        
        
        // Add subviews to cell
        // UILabel and UIImageView
        
        var label: UILabel
        label = UILabel(frame: CGRect(x:0,y:0,width:wt,height:40))
        let fuente: UIFont = UIFont(name: "Arial", size: 12)!
        label.font = fuente
        label.numberOfLines = 4
        label.text = "hola"
        label.sizeToFit()
        cell.contentView.addSubview(label)
        
        /*let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
        imageIcon.frame = CGRect(x:10, y:50, width:50, height:50)
        cell.contentView.addSubview(imageIcon)*/
        
        
        return cell
    }
}

