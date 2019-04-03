package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	
	//ITEMBAR///////////////////////////////////////////////////////////////////////////////////////////////
	//import flash.display.MovieClip;
	import flash.ui.Multitouch;
	import flash.events.TouchEvent;
	import flash.display.SimpleButton;
	import flash.ui.MultitouchInputMode;
	//import flash.display.Sprite;
	import flash.geom.Rectangle;
	//import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	//for testing items
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	//ITEMBAR///////////////////////////////////////////////////////////////////////////////////////////////


	public class ComicPanels extends MovieClip {
		//Button Controls
		private var redButton:MovieClip = new ButtonRed;
		private var bluButton:MovieClip = new ButtonBlue;
		private var redActive:Boolean = false;
		private var blueActive:Boolean = false;
		private var redClicked:Boolean = false;
		private var blueClicked:Boolean = false;

		//for story flow
		private var WizardBool: Boolean = false;
		private var NinjaBool: Boolean = false;
		private var DwarfBool: Boolean = false;
		private var ElfBool: Boolean = false;
		private var FireBool: Boolean = false;
		private var LightningBool: Boolean = false;
		
		//ITEMBAR///////////////////////////////////////////////////////////////////////////////////////////////
		private var background:MovieClip = new Background();
		private var lButton:SimpleButton = new LButton();
		private var rButton:SimpleButton = new RButton();
		private var uibackground:MovieClip = new UIBG();
		//number of item slots
		private var itemBar:MovieClip = new ItemBarMC();
		//space between item slots
		private var itemSlot:MovieClip;	
		
		//----------------------------- Y position of the item bar ----------------------------
		private var itemBarY:Number = 1140
		
		;
		
		//how far the bar can move to the left before stopping
		private var itemBarEnd:Number = -413.25;
		//how far the icons move when pressing an arrow (basically the width of one item slot)
		private var movement:Number = 137.75;
		//Friction for swiping
		private var friction:Number = 0.4;
		//Velocity for swiping
		private var vel:Number = 0;
		//for finding velocity
		private var oldFrame:Number = 0;
		//area the bar can be dragged
		private var fl_DragBounds:Rectangle = new Rectangle(itemBarEnd, itemBarY, -itemBarEnd, 0)
		//wait time before dragging, to allow for tap
		private var dragDelay:Timer = new Timer(60);
		//arrays for the items
		private var itemSlots:Array = new Array();
		private var items:Array = new Array();
		
		
		private var openingPanels:Array = new Array();
		private var vPanels:Array = new Array();
		private var nPanels:Array = new Array();
		private var wPanels:Array = new Array();
		private var dPanels:Array = new Array();
		private var ePanels:Array = new Array();
		private var endingPanels:Array = new Array();
		private var currentPanel:MovieClip;
		
		
		//ITEMBAR///////////////////////////////////////////////////////////////////////////////////////////////

		public function ComicPanels() {
			// constructor code
			init();
		}

		private function init(): void {
			
			

			//add the buttons
			addEventListener(Event.ENTER_FRAME, update);
			redButton.addEventListener(MouseEvent.CLICK, redClick);
			bluButton.addEventListener(MouseEvent.CLICK, bluClick);
			redButton.x = 20;
			redButton.y = 940;
			bluButton.x = 380;
			bluButton.y = 940;
			uibackground.y = 800;
			addChild(uibackground)
			addChild(redButton);
			addChild(bluButton);

		//ITEMBAR///////////////!!!!!!!!!!!!!!!!!!!!!////////////////////////////////////////////////////////////////////////////////

						//position of the right button
			rButton.x = 720;
			rButton.y = itemBarY;
			lButton.y = itemBarY;
			itemBar.y = itemBarY;

			//addChild(background);
			addChild(itemBar);
			addChild(lButton);
			addChild(rButton);
			
			//set up touch
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			//event listeners for left and right buttons
			lButton.addEventListener(TouchEvent.TOUCH_TAP, LeftButtonTap);
			rButton.addEventListener(TouchEvent.TOUCH_TAP, RightButtonTap);

			
			//event listener looking for a touchon the bar
			itemBar.addEventListener(TouchEvent.TOUCH_BEGIN, startDragging);
			
			//array of the item slots
			itemSlots[0] = itemBar.slot1;
			itemSlots[1] = itemBar.slot2;
			itemSlots[2] = itemBar.slot3;
			itemSlots[3] = itemBar.slot4;
			itemSlots[4] = itemBar.slot5;
			itemSlots[5] = itemBar.slot6;
			

			openingPanels[0] = new Open1();
			openingPanels[1] = new Open2();
			openingPanels[2] = new Open3();
			
			vPanels[0] = new CRVPanel1();
			vPanels[1] = new CRVPanel2();
			vPanels[2] = new CRVPanel3();
			vPanels[3] = new VPanel4b();
			vPanels[4] = new VPanel5a();
			vPanels[5] = new VPanel5b();
			vPanels[6] = new VPanelF();
			
			nPanels[0] = new NinjaSceneOne();
			nPanels[1] = new NinjaSceneTwoAlt();
			nPanels[2] = new NinjaSceneThree();
			nPanels[3] = new NinjaSceneFour();
			nPanels[4] = new NinjaSceneSix();
			nPanels[5] = new NinjaSceneSeven();
			nPanels[6] = new NinjaSceneEight();
			
			wPanels[0] = new TreesPath();
			wPanels[1] = new WholeScene();
			wPanels[2] = new WholeScene1();
			wPanels[3] = new WholeScene2();
			wPanels[4] = new WholeScene3();
			wPanels[5] = new WholeScene3FB();
			wPanels[6] = new WholeScene3L();
			wPanels[7] = new WholeScene3LB();
			wPanels[8] = new WholeScene4();
			wPanels[9] = new WholeScene4L();
			
			dPanels[0] = new DwarfP1();
			dPanels[1] = new DwarfP1a();
			dPanels[2] = new DwarfP11();
			dPanels[3] = new DwarfP12();
			dPanels[4] = new DwarfP2();
			dPanels[5] = new DwarfP3();
			dPanels[6] = new DwarfP4();
			dPanels[7] = new DwarfP4Choice1();
			dPanels[8] = new DwarfP4Choice2();
			dPanels[9] = new DwarfP4Choice22();
			dPanels[10] = new DwarfP4Choice23();
			dPanels[11] = new DwarfP5Bad();
			dPanels[12] = new DwarfP5Good();
			
			ePanels[0] = new ElfP1A();
			ePanels[1] = new ElfP2A();
			ePanels[2] = new ElfP3A();
			ePanels[3] = new ElfP3B();
			ePanels[4] = new ElfP4();
			
			endingPanels[0] = new WolfAChoice();
			endingPanels[1] = new WolfBChoice();
			endingPanels[2] = new WolfCChoice();
			endingPanels[3] = new WolfDChoice();
			endingPanels[4] = new WolfEChoice();
			endingPanels[5] = new WolfEnd();
			endingPanels[6] = new WolfEntersEnd();
			
			currentPanel = openingPanels[0];
			
			addChild(currentPanel);

		}
		
		private function changePanel()
		{
			removeChild(currentPanel);				
			
			//first tank panel
			if (currentPanel == openingPanels[0])
				{
					currentPanel = vPanels[0];
					currentPanel.x = 350;
					currentPanel.y = 600;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}
			
			else if (currentPanel == vPanels[0])
				{
					currentPanel = vPanels[1];
					currentPanel.x = 0;
					currentPanel.y = -200;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}	
				
			//go left
			else if (currentPanel == vPanels[1] && redClicked == true)
				{
					currentPanel = vPanels[2];
					currentPanel.x = 0;
					currentPanel.y = -200;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}
				
			else if (currentPanel == vPanels[2])
				{
					currentPanel = vPanels[4];
					currentPanel.x = 0;
					currentPanel.y = -400;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}	
				
			//go right
			else if (currentPanel == vPanels[1] && blueClicked == true)
				{
					currentPanel = vPanels[3];
					currentPanel.x = 0;
					currentPanel.y = -200;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}
				
	
			else if (currentPanel == vPanels[3])
				{
					currentPanel = vPanels[5];
					currentPanel.x = 0;
					currentPanel.y = -200;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}	
				
			//tank item is used
			else if (0 == 1)
				{
					currentPanel = vPanels[6];
					currentPanel.x = 0;
					currentPanel.y = 0;
					currentPanel.scaleX = 0.8;
					currentPanel.scaleY = 0.8;
				}
				
			//first ninja panel
			else if (currentPanel == vPanels[4] || currentPanel == vPanels[5])
				{
					addHammer();
					
					currentPanel = nPanels[0];
					currentPanel.x = 0;
					currentPanel.y = -550;
					currentPanel.scaleX = 1;
					currentPanel.scaleY = 1;
				}	
				
			else if (currentPanel == nPanels[0])
				{
					currentPanel = nPanels[1];
					currentPanel.x = -50;
					currentPanel.y = -550;
				}		
				
			else if (currentPanel == nPanels[1])
				{
					currentPanel = nPanels[2];
					currentPanel.x = -50;
					currentPanel.y = -550;
				}

			//red choice
			else if (currentPanel == nPanels[2] && redClicked == true)
				{
					currentPanel = nPanels[3];
				}		
				
			else if (currentPanel == nPanels[3])
				{
					currentPanel = nPanels[4];
					currentPanel.x = 0;
					currentPanel.y = -550;
				}
				
			//blue choice
			else if (currentPanel == nPanels[2] && blueClicked == true)
				{
					currentPanel = nPanels[5];
					currentPanel.x = 0;
					currentPanel.y = -550;
				}
				
			//ninja item
			else if (0 == 1)
				{
					currentPanel = nPanels[6];
				}
				
			
			currentPanel.gotoAndPlay(1);
				
			addChild(currentPanel);
				
			setChildIndex(uibackground, numChildren - 1);
			setChildIndex(redButton, numChildren - 1);
			setChildIndex(bluButton, numChildren - 1);
			setChildIndex(itemBar, numChildren - 1);
				
			redClicked = false;
			blueClicked = false;
		}

		//Cases for red button, then blue button

		public function redClick(e: MouseEvent):void
		{
			if (redActive == true)
			{
				redClicked = true;
				changePanel();
			}
		}
			
		public function bluClick(e: MouseEvent):void
		{
			if (blueActive == true)
			{
				blueClicked = true;
				changePanel();
			}
		}


		private function update(e: Event): void {
			if (currentPanel.currentFrame == currentPanel.totalFrames)
			{
				redActive = true;
				blueActive = true;
				
				redButton.gotoAndStop(1);
				bluButton.gotoAndStop(1);
			}
			
			else {
				//change before end
				redActive = true;
				blueActive = true;
				
				redButton.gotoAndStop(2);
				bluButton.gotoAndStop(2);
			}
		}
		
		//------------------------ Call these functions when you want to add an item ----------------------------
		//_______________________________________________________________________________________________________
		
		private function addBeer():void
		{
			var exists = false;
			
			//check the items to see if the needed item already exists, to prevent getting multiple
			for each (var item in items)
			{
				if (item.name == "beer")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
				//make the item icon
				var beer = new BeerItem();
				//name the item so that we can check if it is in the items
				beer.name = "beer";
				//add it to the bar
				itemBar.addChild(beer);
				//set the item's position to the first available slot
				beer.x = itemSlots[items.length].x;
				//add an event listener for the item
				beer.addEventListener(TouchEvent.TOUCH_TAP, useBeer);

				//add the item to the items array
				items.push(beer);					
			}

		}
				
		private function addHookshot():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "hookshot")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
			//make the item icon
			var hookshot = new HookshotItem();
			hookshot.name = "hookshot";
			//add it to the bar
			itemBar.addChild(hookshot);
			//set the item's position to the first available slot
			hookshot.x = itemSlots[items.length].x;
			//add an event listener for the item
			hookshot.addEventListener(TouchEvent.TOUCH_TAP, useHookshot);
			
			//add the item to the items array
			items.push(hookshot);
			}
		}	
		
		private function addHammer():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "hammer")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
			//make the item icon
			var hammer = new HammerItem();
			hammer.name = "hammer";
			//add it to the bar
			itemBar.addChild(hammer);
			//set the item's position to the first available slot
			hammer.x = itemSlots[items.length].x;
			//add an event listener for the item
			hammer.addEventListener(TouchEvent.TOUCH_TAP, useHammer);
			
			//add the item to the items array
			items.push(hammer);
			}
		}
		
		private function addLightning():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "lightning" || item.name == "fire")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
			//make the item icon
			var lightning = new LightningItem();
			lightning.name = "lightning";
			//add it to the bar
			itemBar.addChild(lightning);
			//set the item's position to the first available slot
			lightning.x = itemSlots[items.length].x;
			//add an event listener for the item
			lightning.addEventListener(TouchEvent.TOUCH_TAP, useLightning);
			
			//add the item to the items array
			items.push(lightning);
			}
		}
		
		private function addFire():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "lightning" || item.name == "fire")
				{
					exists = true;
					
					break;
				}
			}
			
			
			if (exists == false)
			{
			//make the item icon
			var fire = new FireItem();
			fire.name = "fire";
			//add it to the bar
			itemBar.addChild(fire);
			//set the item's position to the first available slot
			fire.x = itemSlots[items.length].x;
			//add an event listener for the item
			fire.addEventListener(TouchEvent.TOUCH_TAP, useFire);
			
			//add the item to the items array
			items.push(fire);
			}
		}
		
		private function addDagger():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "dagger")
				{
					exists = true;
					
					break;
				}
			}

			if (exists == false)
			{
			//make the item icon
			var dagger = new DaggerItem();
			dagger.name = "dagger";
			//add it to the bar
			itemBar.addChild(dagger);
			//set the item's position to the first available slot
			dagger.x = itemSlots[items.length].x;
			//add an event listener for the item
			dagger.addEventListener(TouchEvent.TOUCH_TAP, useDagger);
			
			//add the item to the items array
			items.push(dagger);
			}
		}
		
		private function LeftButtonTap(event:TouchEvent):void
		{
			//end any velocity
			vel = 0;
			
			//check the bar's position to make sure it is divisible by 137.75 (where it's centered)
			var num = itemBar.x % movement;
			
			//check if the bar is as far as it can go
			if(itemBar.x >= 0)
			{
				itemBar.x = 0;
			}
			
			//check if it is between two items, if so go to the next closest			
			else if(num != 0)
			{
				itemBar.x -= num;
			}
			
			//move the item slots one over			
			else
			{
				itemBar.x += movement;
			}
		}		
		private function RightButtonTap(event:TouchEvent):void
		{
			vel = 0;
			
			var num = itemBar.x % movement;

			if(itemBar.x <= itemBarEnd)
			{
				itemBar.x = itemBarEnd;
			}

			else if(num != 0)
			{
				trace(itemBar.x, num);
				itemBar.x -= movement + num;
			}
			
			else
			{
				itemBar.x -= movement;
			}
		}
		
		private function startDragging(event:TouchEvent):void
		{
			//when touch begins, start the delay timer
			dragDelay.addEventListener(TimerEvent.TIMER, Delay);
			dragDelay.start();
			
			trace("timer started");
			
			//add an event listener for ending touch
			addEventListener(TouchEvent.TOUCH_END, bar_TouchEndHandler);
		}
		
		private function Delay(event:TimerEvent):void
		{
			//when delay ends, start the touch move event to drag the bar
			itemBar.addEventListener(TouchEvent.TOUCH_MOVE, bar_TouchMove);
			
			//add an event listener to look at where the bar's current X is
			addEventListener(Event.ENTER_FRAME, Dragging);
			
			//stop the timer
			dragDelay.removeEventListener(TimerEvent.TIMER, Delay);
			dragDelay.stop();
			dragDelay.reset();
			
			trace("start drag");
			
			//disable the items while dragging
			for each(var item in items)
			{
				item.mouseEnabled = false;
			}
		}
		
		private function bar_TouchMove(event:TouchEvent):void
		{
			//start dragging the item bar, ccan only be dragged on the x axis, between -413.25 and 0)
			itemBar.startTouchDrag(event.touchPointID, false, fl_DragBounds);
		}

		private function bar_TouchEndHandler(event:TouchEvent):void
		{
			//check if dragging has started by checking the timer
			if (dragDelay.running == false)
			{
				trace("end drag");
				
				itemBar.removeEventListener(TouchEvent.TOUCH_MOVE, bar_TouchMove);
				
				//stop dragging the bar
				itemBar.stopTouchDrag(event.touchPointID);
				
				//stop looking at the bar position
				removeEventListener(Event.ENTER_FRAME, Dragging);
				
				//set the velocity using the previous position and current position
				vel = itemBar.x - oldFrame;
				trace(vel);
				
				//start updating the velocity
				addEventListener(Event.ENTER_FRAME, doVelocity)
				
				//re-enable items
				for each(var item in items)
				{
					item.mouseEnabled = true;
				}
			}
			
			else
			{
				//stop the timer
				dragDelay.removeEventListener(TimerEvent.TIMER, Delay);
				dragDelay.stop();
			}

			//stop looking for drag end
			removeEventListener(TouchEvent.TOUCH_END, bar_TouchEndHandler);	
		}
		
		private function Dragging(event:Event):void
		{
			//get the current frame of the bar
			oldFrame = itemBar.x;
		}
		
		private function doVelocity(event:Event):void
		{
			//check if velocity is less than 1
			if(vel < 1 && vel > -1)
			{
				removeEventListener(Event.ENTER_FRAME, doVelocity);				
			}
			
			else if(vel >= 1)
			{
				vel -= friction;		
			}
			
			else if(vel <= -1)
			{
				vel += friction;
			}
			
			//add the velocity to the item bar
			itemBar.x += vel;
			
			//make sure the item bar is still within view, if not stop the velocity
			if(itemBar.x <= itemBarEnd)
			{
				itemBar.x = itemBarEnd;
				vel = 0;
			}
			
			else if(itemBar.x >= 0)
			{
				itemBar.x = 0;
				vel = 0;
			}
		}
		
		//------------ Functions for when you touch an item on the bar, add your code here. Use removeItem(event.target) when you want to remove the item from the bar --------------------
		//_________________________________________________________________________________________________________________________________________________________________________
		
		private function useBeer(event:TouchEvent):void
		{
			//code goes here
			trace("used Beer");
			
			removeItem(event.target);
		}
		
		private function useHookshot(event:TouchEvent):void
		{
			//code goes here
			trace("used Hookshot");
			
			removeItem(event.target);
		}	
		
		private function useHammer(event:TouchEvent):void
		{
			//code goes here
			trace("used Hammer");
			
			removeItem(event.target);
		}	
		
		private function useLightning(event:TouchEvent):void
		{
			//code goes here
			trace("used Lightning Staff");
			
			removeItem(event.target);
		}
		
		private function useFire(event:TouchEvent):void
		{
			//code goes here
			trace("used Fire Staff");
			
			removeItem(event.target);
		}	
		
		private function useDagger(event:TouchEvent):void
		{
			//code goes here
			trace("used Dagger");
			
			removeItem(event.target);
		}	
		
		private function removeItem(itemRemoved):void
		{
			for(var i:int = 0; i < items.length; i++)
			{
				//find the item that needs to be removed
				if(items[i] == itemRemoved)
				{
					//remove it from the item bar and the array
					itemBar.removeChild(items[i]);
					items.splice(i, 1);
					i = items.length;
				}
			}
			
			for(var j:int = 0; j < items.length; j++)
			{
				//reposition each of the items
				items[j].x = itemSlots[j].x;
			}
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}

