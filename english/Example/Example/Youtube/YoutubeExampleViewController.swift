

import Foundation
import XLPagerTabStrip

class YoutubeExampleViewController: BaseButtonBarPagerTabStripViewController<YoutubeIconCell> {

    let redColor = UIColor(red: 221/255.0, green: 0/255.0, blue: 19/255.0, alpha: 1.0)
    let unselectedIconColor = UIColor(red: 73/255.0, green: 8/255.0, blue: 10/255.0, alpha: 1.0)

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonBarItemSpec = ButtonBarItemSpec.NibFile(nibName: "YoutubeIconCell", bundle: NSBundle(forClass: YoutubeIconCell.self), width: { (cell: IndicatorInfo) -> CGFloat in
                return 55.0
        })
    }
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = redColor
        settings.style.buttonBarItemBackgroundColor = .clearColor()
        settings.style.selectedBarBackgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .blackColor()
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: YoutubeIconCell?, newCell: YoutubeIconCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.iconImage.tintColor = self?.unselectedIconColor
            newCell?.iconImage.tintColor = .whiteColor()
            
        }
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = TableChildExampleViewController(style: .Plain, itemInfo: IndicatorInfo(title: " HOME", image: UIImage(named: "home")))
        let child_2 = TableChildExampleViewController(style: .Plain, itemInfo: IndicatorInfo(title: " TRENDING", image: UIImage(named: "trending")))
        let child_3 = ChildExampleViewController(itemInfo: IndicatorInfo(title: " ACCOUNT", image: UIImage(named: "profile")))
        return [child_1, child_2, child_3]
    }
    
    
    override func configureCell(cell: YoutubeIconCell, indicatorInfo: IndicatorInfo) {
        cell.iconImage.image = indicatorInfo.image?.imageWithRenderingMode(.AlwaysTemplate)
    }
    
    
    override func pagerTabStripViewController(pagerTabStripViewController: PagerTabStripViewController, updateIndicatorFromIndex fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.pagerTabStripViewController(pagerTabStripViewController, updateIndicatorFromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        
        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
            let child = viewControllers[toIndex] as! IndicatorInfoProvider
            UIView.performWithoutAnimation({ [weak self] () -> Void in
                guard let me = self else { return }
                me.navigationItem.leftBarButtonItem?.title =  child.indicatorInfoForPagerTabStrip(me).title
            })
        }
    }
    
    // MARK: - Actions

//    @IBAction func closeAction(sender: UIButton) {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
}





