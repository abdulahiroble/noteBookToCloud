//
//  TableViewController.swift
//  NotebookToCloud
//
//  Created by abdulahi roble on 18/09/2021.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    
    var db = Firestore.firestore() // get ref to the database
    var notes:[Note] = []
    var currentNote = -1
    
    var note = [String]()
    let noteKey = "noteKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        startListener()
        loadFromUserdefaults()
    }
    
    func loadFromUserdefaults() {
        if let array = userDefaults.object(forKey: noteKey) as? [String]{
           note = array
        }else {
            note = [String]()
            note.append("Empty note")
            note.append("Empty note2")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return note.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

       cell.textLabel?.text = note[indexPath.row]

       return cell
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentNote = indexPath.row  // save current note index
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.parentViewCon = self
        }
    }
    
    func getCurrentNote() -> String {
        return note[currentNote]
    }
    
    func startListener() {
        db.collection("notes").addSnapshotListener {(snap, error) in
            if let e = error {
                print("error fetching notes \(e)")
            } else {
                if let s = snap {
                    self.notes.removeAll()
                    for doc in s.documents {
                        if let txt = doc.data()["txt"] as? String {
                            print("et dokument: \(txt)")
                            let note = Note()
                            note.txt = txt
                            note.id = doc.documentID
                            self.notes.append(note)
                        }
                    }
                }
            }
        }
    }

   

}
