# DragAndDrop
iOS 11 Native Feature.


Drag and Drop.
 
This feature mainly focus for an iPad. It moves almost everything magically from one to another application. Its has been designed for large and multi touch displays.
For an iPhone it is done within application only.
In tableview there are two new delegate for drag and drop functionality
UITableViewDragDelegate
UITableViewDropDelegate

How to implement in your app. 
		
How to drag items in UITableView.
 
UITableViewDragDelegate.		
 
 
 
 
First Method(itemsForBeginning session), will lift only one item and drag it but by implementing Second Method(itemsForAddingTo session) you can select and drag multiple items.

Here first and Second Methods are optionals. First Method(canHandle session), will check table view can handle drop or not. Second Method(dropSessionDidUpdate session), is used for animation while dropping item and also check for valid drag session.
Third Method(performDropWith coordinator), will perform drop of items at particular indexPath.
