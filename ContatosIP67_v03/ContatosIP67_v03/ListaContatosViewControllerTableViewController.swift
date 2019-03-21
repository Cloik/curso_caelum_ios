//
//  ListaContatosViewControllerTableViewController.swift
//  FormularioContatoViewController
//
//  Created by ios8106 on 3/20/19.
//  Copyright © 2019 caelum. All rights reserved.
//

import UIKit

class ListaContatosViewControllerTableViewController: UITableViewController {
    
    var dao: ContatoDao
    static let cellIdentifier = "Cell"
    
    required init?(coder aDecoder: NSCoder){
        //self.dao = ContatoDao.ContatoDaoInstance()
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dao.listaTodos().count
    }

    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let contato:Contato = self.dao.buscaContatoNaPosicao(indexPath.row)
    
    var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ListaContatosViewControllerTableViewController.cellIdentifier)
    
    if (cell == nil){
        cell = UITableViewCell(style: .default, reuseIdentifier: ListaContatosViewControllerTableViewController.cellIdentifier)
    }
        cell!.textLabel?.text = contato.nome

        return cell!
   }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
//    
//
//    
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dao.remove(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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