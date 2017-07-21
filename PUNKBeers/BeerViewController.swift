//
//  BeerViewController.swift
//  PUNKBeers.
//
//  Created by Rafael Fioretti on 7/18/17.
//  Copyright © 2017 RafaelFioretti. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTag: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTeor: UILabel!
    @IBOutlet weak var lbEscala: UILabel!
    @IBOutlet weak var ivBeer: UIImageView!
    
    var itemSelected: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbName.text = itemSelected.name
        lbTag.text = itemSelected.tag
        lbDescription.text = itemSelected.description
        lbTeor.text = String(itemSelected.teor)
        lbEscala.text = String(itemSelected.ibu)
        let url = URL(string: itemSelected.url)
        let data = try? Data(contentsOf: url!)
        ivBeer.image = UIImage(data: data!)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
