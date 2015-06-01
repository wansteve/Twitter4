//
//  LeftMenuViewController.swift
//  Twitter
//
//  Created by Steve Wan on 5/31/15.
//  Copyright (c) 2015 Steve Wan. All rights reserved.
//

import UIKit

protocol LeftMenuViewControllerDelegate {
    func cellSelected(menuItem: NSString)
}

// class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

class LeftMenuViewController: UIViewController {

//     @IBOutlet weak var tableView: UITableView!
    var delegate: LeftMenuViewControllerDelegate?
    
    let menuItems: NSArray = ["Timeline", "Mentions", "Profile", "Compose Tweet", "Log Out"]
 
    /*
    override func viewDidLoad() {
        println("leftmenu loaded")
        super.viewDidLoad()
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
*/
  
    @IBAction func onTapTweetsView(sender: AnyObject) {
        delegate?.cellSelected(menuItems[0] as! NSString)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(0, forKey: "MentionsKey")


    }
    
    @IBAction func onTapProfileView(sender: AnyObject) {
        delegate?.cellSelected(menuItems[2] as! NSString)

    }
    
    
    @IBAction func onTapMentionsView(sender: AnyObject) {
        delegate?.cellSelected(menuItems[1] as! NSString)
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(1, forKey: "MentionsKey")
        

    }
    
    override func viewDidLoad() {

        println("leftmenu loaded")
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    /*
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("menucell") as? MenuCell
        // cell.itemLabel.text = menuItems[indexPath.row] as NSString
       
        if cell == nil {
            // cell = MenuCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CELL")
            cell = MenuCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Menucell")
        }
        
        //we know that cell is not empty now so we use ! to force unwrapping

       //  cell!.itemLabel.text = self.menuItems[indexPath.row] as? String

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("inside didSelectRowAtIndexPath")
        delegate?.cellSelected(menuItems[indexPath.row] as! NSString)
        println(menuItems[indexPath.row])
    }
    */
}
