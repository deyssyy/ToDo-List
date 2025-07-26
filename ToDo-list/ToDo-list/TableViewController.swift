//
//  ViewController.swift
//  ToDo-list
//
//  Created by nikita on 24.07.2025.
//

import UIKit

protocol AddNoteDelegate: AnyObject {
    func addNote(noteName: String, note: String)
}

struct Note: Codable{
    var name: String
    var text: String
}

class TableViewController: UIViewController{
    var arr: [Data] = []
    var notes: [Note] = []
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        arr = UserDefaults.standard.value(forKey: "Note") as? [Data] ?? []
        decode()
       // UserDefaults.standard.removeObject(forKey: "Note")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newNote", let destination = segue.destination as? NoteViewController {
            destination.delegate = self
        }
        if segue.identifier == "EditNote", let destination = segue.destination as? EditNoteViewController, let selectedIndex = sender as? IndexPath{
            //destination.delegate = self
            destination.index = selectedIndex.row
            let destinationNote = notes[selectedIndex.row]
            destination.name = destinationNote.name
            destination.note = destinationNote.text
            print(destination.name)
            print(destination.note)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
    }
    func encode(notes: [Note]){
        arr = []
        let encoder = JSONEncoder()
        for elem in notes{
            do{
                let data = try encoder.encode(elem)
                arr.append(data)
            }
            catch{
                print("error decoding")
            }
        }
    }
    
    func decode(){
        let decoder = JSONDecoder()
        for elem in arr{
            do{
                let note = try decoder.decode(Note.self, from: elem)
                self.notes.append(note)
            }
            catch{
                print("error decoding")
            }
        }
    }
    
}


