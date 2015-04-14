/**
This class allows you to create a dynamic menu based on an XML file.

Example usage:
In your FLA file, add the following code into the main timeline. Make sure that the XML file points to the appropriate file containing your navigation.

	new XmlMenu("menu.xml", this);
*/
class XmlMenu {
	/* typically the variable, m_parent_mc, will point to the main timeline. 
	   This MovieClip will end up being a container for the entire menu, 
	   and where you'll attach your various navigation menu MovieClip instances. */
	private var m_parent_mc:MovieClip;
	/* the m_menu_array Array holds the references to the main menu movie clips. 
	   This allows you to loop through each main navigation link and hide the dropdown sub-navigation if it is open. */
	private var m_menu_array:Array;

	/* Constructor, this method takes two parameters, xmlpath_str 
	   (which is the path to the XML file containing the navigation), 
	   and parent_mc (which is a reference to a movie clip/timeline 
	   where you'll attach your various menu items). */
	function XmlMenu(xmlpath_str:String, parent_mc:MovieClip) {
		this.m_parent_mc = parent_mc;
		this.m_menu_array = new Array();
		// call this class' initXML function which parses your XML navigation file.
		initXML(xmlpath_str);
	}

	/* This function, initXML, takes a single parameter (xmlpath_str) and is responsible for 
	   loading and parsing the XML document and converting it into an array of objects. */
	private function initXML(xmlpath_str:String):Void {
		/* Set a reference to the current class. 
		   You need to store this reference because Flash can get confused when you refer 
		   to "this" within our XML onLoad method 
		   (where "this" refers to the XML object rather than the XmlMenu class itself). */
		var thisObj = this;
		// create an array which contains the main navigation as well as each menu's sub-navigation links.
		var menu_array:Array = new Array();
		// The XML object which you will use to load and parse the XML navigation file.
		var menu_xml:XML = new XML();
		menu_xml.ignoreWhite = true;
		// define your function which will be triggered when the XML file has completed loading.
		menu_xml.onLoad = function(success:Boolean) {
			/* if the XML file was successfully loaded and parsed,
			   convert it into an array of objects which we can pass to the XmlMenu class' initMenu method. */
			if (success) {
				// for each child node in the XML file (the child nodes here are the main menu navigation items.
				for (var i = 0; i<this.firstChild.childNodes.length; i++) {
					/* create a shortcut to the current node. 
					   This allows us to simplify the code below so you
					   don't have as many firstChild and childNodes within the code. */
					var shortcut = this.firstChild.childNodes[i];
					// create an empty array for sub-navigation items.
					var submenu_array:Array = new Array();
					// for each child node of the main menu items, append the values to our submenu_array.
					for (var j = 0; j<shortcut.childNodes.length; j++) {
						/* append each sub-navigation item to our submenu_array Array.
						   Our XML file specifies the navigation's label and url in attributes rather than child nodes,
						   so if you modify the layout of the navigation XML file this code will need to be modified. */
						submenu_array.push({caption:shortcut.childNodes[j].attributes.name, href:shortcut.childNodes[j].attributes.href});
					}
					// append each menu items, and it's array of submenu items.
					menu_array.push({caption:shortcut.attributes['name'], href:shortcut.attributes['href'], subnav_array:submenu_array});
				}
				// call the XmlMenu class' initMenu method.
				thisObj.initMenu(menu_array);
			}
		};
		// load the navigation XML file.
		menu_xml.load(xmlpath_str);
	}

	/* this method, initMenu, loops through the menu items and their respective 
	   sub navigation items and builds the movie clips. */
	private function initMenu(nav_array:Array):Void {
		// create a reference to the current class.
		var thisObj = this;
		// create variables which we will use to position the menu items.
		var thisX:Number = 20;
		var thisY:Number = 20;
		for (var menuIndex = 0; menuIndex<nav_array.length; menuIndex++) {
			// for each main menu item attach the menu_mc symbol from the library and position it along the x-axis.
			var menuMC:MovieClip = this.m_parent_mc.attachMovie("menu_mc", "menu"+menuIndex+"_mc", menuIndex, {_x:thisX, _y:thisY});
			/* store the current menu item's information within the MovieClip so you
			   always have a reference to the sub navigation and the current menu item's link */
			menuMC.data = nav_array[menuIndex];
			// add a reference to the current menu movie clip in the class' m_menu_array Array.
			this.m_menu_array.push(menuMC);
			// set the caption on the main menu button.
			menuMC.label_txt.text = menuMC.data.caption;
			// create a new movie clip on the Stage which will be used to hold the submenu items.
			var subMC:MovieClip = this.m_parent_mc.createEmptyMovieClip("submenu"+menuIndex+"_mc", (menuIndex*20)+100);
			// set the sub menu's X and Y position on the Stage.
			subMC._x = thisX;
			subMC._y = menuMC._height;
			// set a variable in the submenu movie clip which stores whether the current sub menu item is visible
			subMC.subMenuVisible = true;
			// call the hideSubMenu method which hides the sub menu item.
			hideSubMenu(subMC);
			// within the sub menu movie clip store a reference to the menu movie clip
			subMC.parentMenu = menuMC;
			// hide the sub menu movie clip on the Stage.
			subMC._visible = false;
			// set a variable which we will use to track the current y-position of the sub-navigation items.
			var yPos:Number = thisY;
			var temp_subnav_array:Array = menuMC.data.subnav_array;
			/* for each sub menu item, attach a new instance of the link_mc MovieClip from the Library, 
			   set the text for the link and increment the yPos counter. */
			for (var i = 0; i<temp_subnav_array.length; i++) {
				var linkMC:MovieClip = subMC.attachMovie("link_mc", "link"+i+"_mc", i, {_x:0, _y:yPos});
				linkMC.data = temp_subnav_array[i];
				linkMC.label_txt.text = linkMC.data.caption;
				linkMC.onRelease = function() {
					getURL(this.data.href, "_blank");
					// trace(this.data.href);
				};
				yPos += linkMC._height;
			}
			// draw a slight 1 pixel drop shadow around the sub menu using the drawing API
			var thisWidth:Number = subMC._width+1;
			var thisHeight:Number = subMC._height+1;
			subMC.beginFill(0x000000, 0);
			subMC.moveTo(0, 0);
			subMC.lineTo(thisWidth, 0);
			subMC.lineTo(thisWidth, thisHeight);
			subMC.lineTo(0, thisHeight);
			subMC.lineTo(0, 0);
			subMC.endFill();
			//
			menuMC.childMenu = subMC;
			thisX += menuMC._width;
		}
		// define the onRollOver and onRelease for each main menu item.
		for (var i in this.m_menu_array) {
			this.m_menu_array[i].onRollOver = function() {
				thisObj.showSubMenu(this.childMenu);
			};
			this.m_menu_array[i].onRelease = function() {
				getURL(this.data.href, "_blank");
				// trace(this.data.href);
			};
		}
	}

	// the showSubMenu method displays the specified sub menu movie clip
	private function showSubMenu(target_mc:MovieClip):Void {
		// create a reference to the current class.
		var thisObj = this;
		if (!target_mc.subMenuVisible) {
			hideAllSubMenus();
			target_mc._visible = true;
			target_mc.subMenuVisible = true;
			/* define a handler for the onMouseMove event. 
			   This function is called whenever the mouse is moved, 
			   whether or not it is over the specified movie clip. */
			   
			/* :KLUDGE: You are using the onMouseMove handler here instead of onRollOut,
			   because using onRollOut caused the nested movie clips to stop responding
			   to their respective onRelease event handlers. */
			target_mc.onMouseMove = function() {
				// hit test both the main menu item, and the submenu to see if the mouse is over either one of them.
				var subHit:Boolean = this.hitTest(_xmouse, _ymouse, true);
				var menuHit:Boolean = this.parentMenu.hitTest(_xmouse, _ymouse, true);
				/* if the mouse is not over the main menu or sub menu, 
				   hide the submenu movie clip and delete the onMouseMove event listener since we don't need it any more. */
				if (!((subHit || menuHit) && this.subMenuVisible)) {
					thisObj.hideSubMenu(this);
					delete this.onMouseMove;
				}
			};
		}
	}
	// hide the specified sub menu Movie Clip, if it is visible.
	private function hideSubMenu(target_mc:MovieClip):Void {
		if (target_mc.subMenuVisible) {
			target_mc._visible = false;
			target_mc.subMenuVisible = false;
		}
	}
	// hide the sub menu for each menu item in the m_menu_array Array.
	private function hideAllSubMenus():Void {
		for (var i in this.m_menu_array) {
			hideSubMenu(this.m_menu_array[i].childMenu);
		}
	}
	// toggle a specific menu's visibility.
	private function toggleSubMenu(target_mc:MovieClip):Void {
		(target_mc.subMenuVisible) ? hideSubMenu(target_mc) : showSubMenu(target_mc);
	}

}
