import UIKit

class GradeCell : UICollectionViewCell{
    
    @IBOutlet weak var gradeNameLabel: UILabel!
    
    var gradeName: String{
        didSet{
            gradeNameLabel.text = gradeName;
        }
    }
    
    override var isSelected: Bool{
        didSet{
            gradeNameLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 21) : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)

        }
    }
    
    
    required init?(coder aDecoder: NSCoder){
        self.gradeName = "";
        super.init(coder: aDecoder);
    }
}
