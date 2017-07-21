//
//  BeersTableViewController.swift
//  PUNKBeers.
//
//  Created by Rafael Fioretti on 7/18/17.
//  Copyright © 2017 RafaelFioretti. All rights reserved.
//

import UIKit

class BeersTableViewController: UITableViewController {
    
    var label: UILabel!
    var fetchedResultController: [Beer] = []
    
    var andamento = UIActivityIndicatorView()




    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
        andamento.center = self.view.center;
        andamento.hidesWhenStopped = true;
        andamento.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        view.addSubview(andamento)
        andamento.startAnimating()
//        tableView.estimatedRowHeight = 106
//        tableView.rowHeight = UITableViewAutomaticDimension
//        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
//        label.text = "Sem cervejas cadastradas"
//        label.textAlignment = .center
//        label.textColor = .white
        carregaTabela()
    
    }
    
    func carregaTabela(){
        
        BeerAPI.getBeers(beerPage: 1) { (beers: [Beer]?) in
            if let beers = beers {
                self.fetchedResultController = beers
                self.andamento.stopAnimating()
                self.tableView.reloadData()
            }
            //print(beers)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BeerViewController{
            if tableView.indexPathForSelectedRow != nil{
                vc.itemSelected = fetchedResultController[tableView.indexPathForSelectedRow!.row]
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultController.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerTableViewCell
        
        let beer = fetchedResultController[indexPath.row]
        
        cell.lbName.text = beer.name
        cell.lbTeor.text = String(beer.teor)
        let url = URL(string: beer.url)
        let data = try? Data(contentsOf: url!)
        cell.ivBeer.image = UIImage(data: data!)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
