

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private var transition: CardTransition?
    
    let path = Bundle.main.path(forResource: "ExampleData", ofType: "plist")
    
    private lazy var cardModels: [CardContentViewModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        // Make it responds to highlight state faster
        collectionView.delaysContentTouches = false
        
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .init(top: 20, left: 0, bottom: 64, right: 0)
        }

        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.register(UINib(nibName: "\(CardCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "card")
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCollectionView")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        let dict = NSDictionary(contentsOfFile: path!)
        for allData in dict! {
            let data = allData.value as? [String: Any]
            let material = data!["material"] as! [[String:String]]
            cardModels.append(
                CardContentViewModel(primary: data!["nameProduct"] as! String,
                                     secondary: data!["summery"] as! String,
                                     description: data!["desc"] as! String,
                                     image: UIImage(named: data!["image"] as! String)!
                                                    .resize(toWidth: UIScreen.main.bounds.size.width *
                                                    (1/GlobalConstants.cardHighlightedFactor)),
                                     material: material,
                                     after: data!["after"] as! String,
                                     storyBoard: data!["storyBoard"] as! String))
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
//    override var statusBarAnimatableConfig: StatusBarAnimatableConfig {
//        return StatusBarAnimatableConfig(prefersHidden: false,
//                                         animation: .slide)
//    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CardCollectionViewCell
        cell.cardContentView?.viewModel = cardModels[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionView", for: indexPath) as? HeaderCollectionReusableView {
            if UserDefaults.standard.object(forKey: "savedImage") as? NSData != nil {
                let imageProfile = UserDefaults.standard.object(forKey: "savedImage") as! NSData
                sectionHeaderView.imageView.image = UIImage(data: imageProfile as Data)
            }
            
            

            sectionHeaderView.nameApp = Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String
             let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            sectionHeaderView.imageView.isUserInteractionEnabled = true
            sectionHeaderView.imageView.addGestureRecognizer(tapGestureRecognizer)
            
            return sectionHeaderView
        }
        return UICollectionReusableView()
    }

    
}

extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardHorizontalOffset: CGFloat = 20
        let cardHeightByWidthRatio: CGFloat = 0.9
        let width = collectionView.bounds.size.width - 2 * cardHorizontalOffset
        let height: CGFloat = width * cardHeightByWidthRatio
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Get tapped cell location
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell

        // Freeze highlighted state (or else it will bounce back)
        cell.freezeAnimations()

        // Get current frame on screen
        let currentCellFrame = cell.layer.presentation()!.frame

        // Convert current frame to screen's coordinates
        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)

        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
        let cardFrameWithoutTransform = { () -> CGRect in
            let center = cell.center
            let size = cell.bounds.size
            let r = CGRect(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2,
                width: size.width,
                height: size.height
            )
            return cell.superview!.convert(r, to: nil)
        }()

        let cardModel = cardModels[indexPath.row]

        // Set up card detail view controller
        let vc = CardDetailViewController(nibName: "DetailView", bundle: nil)

        vc.cardViewModel = cardModel.highlightedImage()
        vc.unhighlightedCardViewModel = cardModel // Keep the original one to restore when dismiss
        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                           fromCell: cell)
        transition = CardTransition(params: params)
        vc.transitioningDelegate = transition

        // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.modalPresentationStyle = .custom

        present(vc, animated: true, completion: { [unowned cell] in
            // Unfreeze
            cell.unfreezeAnimations()
        })
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        // Push View controller to Profile
        
        
        //define xib file view controller
        
        /*
         let newViewController = NewViewController()
         self.navigationController?.pushViewController(newViewController, animated: true)
         */
        
        // Define storyboard
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let newController = storyBoard.instantiateViewController(identifier: "ProfileStoryBoard") as! ProfileViewController
        navigationController?.pushViewController(newController, animated: true)
        
        
        /*
        let storyBoard: UIStoryboard = UIStoryboard(name: "tutorialScrub", bundle: nil)
        let newController = storyBoard.instantiateViewController(identifier: "tutorialScrub") as! tutorialScrub
        navigationController?.pushViewController(newController, animated: true)
         */
        
    }
    
}
