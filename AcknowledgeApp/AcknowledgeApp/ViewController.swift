//
//  ViewController.swift
//  AcknowledgeApp
//
//  Created by Fhict on 13/04/16.
//  Copyright © 2016 Gregory Lammers. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var eV = [EKEvent]()
    let datumTijdFormat = "dd/MM/yyyy HH:mm"
    var start = [String]()
    var end = [String]()
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func buttonCalendar(sender: AnyObject) {
        let eventStore : EKEventStore = EKEventStore()
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
            (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = "Open dag Acknowlege"
                event.startDate = NSDate()
                event.endDate = NSDate()
                event.notes = "This is a note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.saveEvent(event, span: EKSpan.ThisEvent)
                } catch {
                    print("bad things happened")
                }
                print("Saved Event")
                
                let alert = UIAlertController(title: "Evenement is aangemaakt:", message: event.title, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
        
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let eventStore : EKEventStore = EKEventStore()
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
            (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = "Test Title"
                event.startDate = NSDate()
                event.endDate = NSDate()
                event.notes = "This is a note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    //try eventStore.saveEvent(event, span: EKSpan.ThisEvent)
                } catch {
                    print("bad things happened")
                }
                print("Saved Event")
            }
        })
        
        
        // This lists every reminder
        let predicate = eventStore.predicateForRemindersInCalendars([])
        eventStore.fetchRemindersMatchingPredicate(predicate) { reminders in
            for reminder in reminders! {
                print(reminder.title)
            }}
        
        
        // What about Calendar entries?
        let startDate=NSDate().dateByAddingTimeInterval(-60*60*24)
        let endDate=NSDate().dateByAddingTimeInterval(60*60*24*60)
        let predicate2 = eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: nil)
        
        print("startDate:\(startDate) endDate:\(endDate)")
        eV = eventStore.eventsMatchingPredicate(predicate2)
        
        //if eV != nil {
        for i in eV {
            
            //lblTitle.text = i.title
            //lblStart.text = dateformatter.stringFromDate(i.startDate)
            //lblEnd.text = dateformatter.stringFromDate(i.endDate)
            print("Title  \(i.title)" )
            print("startDate: \(i.startDate)" )
            print("endDate: \(i.endDate)" )
            
            if i.title == "Test Title" {
                print("YES" )
                // Uncomment if you want to delete
                //eventStore.removeEvent(i, span: EKSpanThisEvent, error: nil)
            }
        }
        //}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return self.section [section]
        return "Naam - Starttijd - Eindtijd"
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eV.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("kalenderCell", forIndexPath: indexPath)
            as! KalendarCell
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = datumTijdFormat
        
        for i in eV {
            start.append(dateformatter.stringFromDate(i.startDate))
            end.append(dateformatter.stringFromDate(i.endDate))
        }
        
        cell.lblTitle.text = eV[indexPath.row].title
        cell.lblStart.text = start[indexPath.row]
        cell.lblEnd.text = end[indexPath.row]
        //cell.lblStart.text = start
        //cell.lblEnd.text = end
        //cell.lblEnd.text = dateformatter.stringFromDate(i.endDate)
        
        
        return cell
    }
    
    
    


}

