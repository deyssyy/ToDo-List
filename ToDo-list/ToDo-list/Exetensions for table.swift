//
//  Exetensions for table.swift
//  ToDo-list
//
//  Created by nikita on 24.07.2025.
//
import Foundation
import UIKit
extension TableViewController: UITableViewDataSource, UITableViewDelegate{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.notes.remove(at: indexPath.row)
            self.arr.remove(at: indexPath.row)
            UserDefaults.standard.set(self.arr, forKey: "Note")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditNote", sender: indexPath)
    }
    
   
}

extension TableViewController: AddNoteDelegate{
    func addNote(noteName: String, note: String) {
        let newNote = Note(name: noteName, text: note)
        notes.append(newNote)
        encode(notes: notes)
        UserDefaults.standard.set(arr, forKey: "Note")
        tableView.insertRows(at: [IndexPath(row: notes.count - 1, section: 0)], with: .automatic)
    }
    func editNote(){
        
    }
}
