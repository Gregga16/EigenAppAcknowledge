//
//  DocumentTableView.swift
//  AcknowledgeApp
//
//  Created by Fhict on 13/04/16.
//  Copyright © 2016 Gregory Lammers. All rights reserved.
//

import UIKit

class DocumentTableView: UITableViewController {

    var files_ppt = [Document]()
    var files_pdf = [Document]()
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [Document]
    }
    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadJsonData()
        //let fm = NSFileManager.defaultManager()
        //let path = NSBundle.mainBundle().resourcePath!
        //let items = try! fm.contentsOfDirectoryAtPath(path)
        
        /*for item in items {
         if item.hasPrefix("1") {
         objects.append(item)
         }
         }*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadJsonData()
    {
        let url = NSURL(string: "http://athena.fhict.nl/users/i254909/iOS/get_files_data.php")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJsonData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    func parseJsonData(jsonObject:AnyObject)
    {
        if let jsonData = jsonObject as? NSArray
        {
            for item in jsonData
            {
                let splitArray = (item.objectForKey("file") as! String).characters.split{$0 == "."}.map(String.init)
                let title = splitArray[0]
                let type = splitArray[1]
                let url = "http://athena.fhict.nl/users/i254909/iOS/files/" + title + "." + type
                let newDocument = Document(
                    title: title,
                    type: type,
                    url: url
                )
                if(type == "pptx")
                {
                    files_ppt.append(newDocument)
                }
                
                if(type == "pdf")
                {
                    files_pdf.append(newDocument)
                }
            }
        }
        
        objectArray = [Objects(sectionName: "Powerpoint", sectionObjects: files_ppt), Objects(sectionName: "PDF", sectionObjects: files_pdf)]
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPaths = self.tableView.indexPathForSelectedRow {
                var url = objectArray[indexPaths.section].sectionObjects[indexPaths.row].url!
                url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                let controller = segue.destinationViewController as! ViewDocument
                controller.detailItem = url
                //load(NSURL(string: url)!, segue: segue)
            }
        }
    }
    
    func load(URL: NSURL, segue: UIStoryboardSegue) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error == nil) {
                // Success
                
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                print("Success file download: \(statusCode)")
                
                // This is your file-variable:
                // data
                let documents_path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                print(documents_path)
                let indexPaths = self.tableView.indexPathForSelectedRow
                let title = self.objectArray[indexPaths!.section].sectionObjects[indexPaths!.row].title!
                let type = self.objectArray[indexPaths!.section].sectionObjects[indexPaths!.row].type!
                let writePath = documents_path.stringByAppendingString(title).stringByAppendingString(".").stringByAppendingString(type)
                data!.writeToFile(writePath, atomically: true)
                let controller = segue.destinationViewController as! ViewDocument
                controller.detailItem = writePath
            }
            else {
                // Failure
                print("Faulure: %@", error!.localizedDescription);
            }
        })
        task.resume()
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return self.section [section]
        
        return objectArray[section].sectionName
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return self.section.count
        return objectArray.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectArray[section].sectionObjects.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("presCell", forIndexPath: indexPath)
            as UITableViewCell
        
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row].title!
        
        return cell
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
