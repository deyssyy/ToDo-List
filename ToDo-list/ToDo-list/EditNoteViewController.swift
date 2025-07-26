import UIKit
class EditNoteViewController: UIViewController{
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editNoteTextView: UITextView!
    weak var delegate: AddNoteDelegate?
    var name: String?
    var note: String?
    var index: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.text = name
        editNoteTextView.text = note
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: Any) {
        guard let noteName = nameTextView.text else { return }
        guard let noteText = editNoteTextView.text else { return }
        guard let index = index else { return }
        delegate?.editNote(noteName: noteName, noteText: noteText, index: index)
        self.dismiss(animated: true)
    }
    
}
