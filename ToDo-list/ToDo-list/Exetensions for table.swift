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
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return notes.count
        }else{
            return completedNotes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        if indexPath.section == 0 {
            let task = self.notes[indexPath.row]
            cell.textLabel?.text = notes[indexPath.row].name
            cell.accessoryType = task.status ? .checkmark : .none

        } else {
            let task = self.completedNotes[indexPath.row]
            cell.textLabel?.text = completedNotes[indexPath.row].name
            cell.accessoryType = task.status ? .checkmark : .none

        }
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { (action, view, completionHandler) in
           // tableView.cellForRow(at: indexPath)?.accessoryType = self.notes[indexPath.row].status ? .none : .checkmark
            if indexPath.section == 0{
                self.notes[indexPath.row].status.toggle()
                let note  = self.notes.remove(at: indexPath.row)
                print(note)
                self.completedNotes.append(note)
                tableView.reloadData()
                var allNotes = self.notes + self.completedNotes
                self.encode(notes: allNotes)
                UserDefaults.standard.set(self.arr, forKey: "Note")
            }else{
                self.completedNotes[indexPath.row].status.toggle()
                let note = self.completedNotes.remove(at: indexPath.row)
                self.notes.append(note)
                tableView.reloadData()
                var allNotes = self.notes + self.completedNotes
                self.encode(notes: allNotes)
                UserDefaults.standard.set(self.arr, forKey: "Note")
            }
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditNote", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Незавершенные задачи"
        default:
            return "Завершенные задачи"
        }
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
    func editNote(noteName: String, noteText: String, index: Int) {
        let editedNote = Note(name: noteName, text: noteText)
        print(notes[index])
        notes[index] = editedNote
        print(notes[index])
        encode(notes: notes)
        UserDefaults.standard.set(arr, forKey: "Note")
    }
}
