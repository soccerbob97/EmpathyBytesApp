import UIKit

class CustomTableViewCell: UITableViewCell {
    //String used to register to a tableView
    static let identifier = "CustomTableViewCell"
    
    private let cellImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"ToyAirplane");
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private let cellLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17,weight: .bold)
        label.text = "Custom Cell"
        return label
    }()

    //Tableview calls this method interally when initiializing and dequeuing the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(cellImageView)
        contentView.addSubview(cellLabel)
        //cell color is orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String, imageName:String) {
        cellLabel.text = text
        cellImageView.image = UIImage(named:imageName)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellLabel.text = nil
        cellImageView.image = nil
    }
    
    // Called when deciding how subviews will be placed.
    // Assigning Frames to Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.frame.size.height - 6
        
        cellLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width - 10 - imageSize, height: contentView.frame.size.height);
        
        cellImageView.frame = CGRect(x: contentView.frame.size.width - imageSize, y: 3, width: imageSize, height: imageSize)
        
        
    }

}
