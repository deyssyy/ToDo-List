import UIKit

class NoteViewController: UIViewController{
    
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    weak var delegate: AddNoteDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let noteName = noteTextView.text else { return }
        guard let noteText = noteText.text else { return }
        if noteName == ""{
            let defaultNoteName = "Новая заметка"
            delegate?.addNote(noteName: defaultNoteName, note: noteText)
        }else{
            delegate?.addNote(noteName: noteName, note: noteText)
        }
        self.dismiss(animated: true)
    }
    
}
