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
		private var redButton: ButtonRed = new ButtonRed;
		private var bluButton: ButtonBlue = new ButtonBlue;

		public var redBtnClickable: Boolean = true;
		public var bluBtnClickable: Boolean = true;

		public var CurrentPanel: MovieClip = panel11;
		public var transImage: MovieClip = CurrentPanel;
		public var NextPanel: MovieClip = panel11;
		public var movieClipHolder: Array;
		private var CurrentMC: MovieClip; //
		//
		// for transitions
		public var previousPosX: Number = 0;
		public var previousPosY: Number = 0;

		public var newPanel: Boolean = false;
		public var transitioningUp: Boolean = false
		public var transitioningDown: Boolean = false
		public var transitionPosX: Number = 0;
		public var transitionScaleX: Number = 0;
		public var transitionPosY: Number = 0;
		public var transitionScaleY: Number = 0;
		public var transitionCounter: Number = 0;
		public var transitionTime: Number = 24;
		
		public var PanX: Number = 14;
		public var PanY: Number = 14;
		public var PanW: Number = 650;
		public var PanH: Number = 900;

		public var playFrame: Number = 1;
		public var caseNumber: Number = 11;
		public var nextCase: Number = 12;

		//Timers
		public var bluDisCounter: Number = 0;
		public var redDisCounter: Number = 0;


		//For pages
		private var boolPage1: Boolean = true;
		private var boolPage2: Boolean = true;
		private var boolPage3: Boolean = true;
		private var boolPage4: Boolean = true;
		private var boolPage5: Boolean = true;
		private var boolPage6: Boolean = true;
		
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
		
		
		//ITEMBAR///////////////////////////////////////////////////////////////////////////////////////////////

		public function ComicPanels() {
			// constructor code
			init();
		}

		private function init(e: Event = null): void {
			//add the buttons
			addEventListener(Event.ENTER_FRAME, update);
			redButton.addEventListener(MouseEvent.CLICK, redClick);
			bluButton.addEventListener(MouseEvent.CLICK, bluClick);
			redButton.x = 20;
			redButton.y = 940;
			bluButton.x = 380;
			bluButton.y = 940;
			addChild(redButton);
			trace("here");
			addChild(bluButton);
			trace("HERE");
			//array
			movieClipHolder = new Array();

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
			
		//ITEMBAR//////////////!!!!!!!!!!/////////////////////////////////////////////////////////////////////////////////

		}

				//ITEMBAR//////88888/////////////////////////////////////////////////////////////////////////////////////////

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
		
				//ITEMBAR//////88888/////////////////////////////////////////////////////////////////////////////////////////

		//Creates an image copy
		private function BirthTrans(): void {
			transImage = CurrentPanel;
			addChild(transImage);

		}

		//Adds children MCs
		public function BirthMC(): void {
			
			//KillPanel();
			trace(CurrentMC);
			movieClipHolder.push(CurrentMC);
			addChild(CurrentMC);
			CurrentMC.gotoAndPlay(playFrame);
			//			
		}

		//Use this for sizing if your panel fits in the frame
		private function DefaultPanels(): void {
			PanX = 20;
			PanY = 20;
			PanH = 880;
			PanW = 690;
		}

		//Use this for sizing your MCPanel to fit in the frame
		private function DefaultMCValues(): void {
			CurrentMC.x = PanX - 2;
			CurrentMC.y = PanY - 4;
			CurrentMC.height = PanH;
			CurrentMC.width = PanW;
		}

		
		//Code for buttons to become clickable after being clicked (if they are clicked before the transition is complete it can mess things up, I can fix that later.
		private function BtnDiscounter(discounter: Number, isAble: Boolean): void {
			bluDisCounter = (transitionTime * 2) + discounter + 2;
			redDisCounter = (transitionTime * 2) + discounter + 2;
			redBtnClickable = isAble;
			bluBtnClickable = isAble;
		}
		//for transisions
		private function scaleMath(): void {
			previousPosX = CurrentPanel.x;
			previousPosY = CurrentPanel.y;
			transitionScaleX = ((PanW) - (CurrentPanel.width)) / transitionTime;
			transitionScaleY = ((PanH) - (CurrentPanel.height)) / transitionTime;
			transitionPosX = ((previousPosX) - (PanX)) / transitionTime;
			transitionPosY = ((previousPosY) - (PanY)) / transitionTime;
		}
		//Kill old panel, before assigning new one
		private function KillPanel(): void {
			removeChild(movieClipHolder[0]);
			movieClipHolder.length = 0;
			newPanel = true;
		}
		
		private function DefaultMask():void{
			Mask1.x = 16;
			Mask1.y = 16;
			Mask2.x = 16;
			Mask2.y = 16;
			Mask3.x = 16;
			Mask3.y = 16;
			Mask4.x = 16;
			Mask4.y = 16;
			Mask5.x = 16;
			Mask5.y = 16;
			Mask6.x = 16;
			Mask6.y = 16;
			boolPage1 = true;
			boolPage2 = true;
			boolPage3 = true;
			boolPage4 = true;
			boolPage5 = true;
			
			
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		//Cases for red button, then blue button

		public function redClick(e: MouseEvent) {
			trace("RED");
			if (redBtnClickable == true) {
				switch (caseNumber) {

					case 11:
						// first panel code

									
						CurrentMC = new Open1();

						
						
						
						CurrentMC.x = 15;
						CurrentMC.y = 35;
						CurrentMC.width *= 0.9;
						CurrentMC.height *= 0.9;
						
						PanX = 15;
						PanY = 50;
						PanH = 767;
						PanW = 660;
					
						CurrentPanel = panel11;
						NextPanel = panel12;
						BirthTrans();
						scaleMath();
						nextCase = 11.5;
						transitioningUp = true;
						playFrame = 1;
						BtnDiscounter(0, false);
						newPanel = true;
						
					

						
						break;

					case 11.5:
						
					
					
					
/*						NextPanel = panel41;	
						
						nextCase = 41;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						KillPanel();
						CurrentMC= new DwarfP1();
						newPanel = true;
						
						
						CurrentMC.x = 287;
						CurrentMC.y = 455;
						CurrentMC.width *= 1;
						CurrentMC.height *= 1;
					
						PanX = -50;
						PanY = 103;
						PanH = 732;
						PanW = 804;
						boolPage1 = false;
						boolPage1 = false;
						boolPage1 = false;
						boolPage1 = false;
						break;*/
					
					
					
					
					
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel12;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 12
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(24, false);
						KillPanel();
						newPanel = true;
						CurrentMC = new CRVPanel1();
						//use newPanel = true,whenever you need to make a new panel
						

						//set these values to make your panel fit. 
						CurrentMC.x = 361;
						CurrentMC.y = 635;
						CurrentMC.width *= .64;
						CurrentMC.height *= .64;
						//DefaultPanels();
						//DefaultMCValues();


						break;

					
					case 12:
						NextPanel = panel13;
						transitioningDown = true;
						nextCase = 12.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						//BirthPanel();
						CurrentMC = new CRVPanel2();
						CurrentMC.x = 117;
						CurrentMC.y = 32;
						CurrentMC.width *= 0.45;
						CurrentMC.height *= 0.45;					
					

						DefaultPanels();
						 //DefaultMCValues();
						//statements;
						break;

					case 12.5:
						
						
							//NextPanel = panel13;
							//transitioningDown = true;
							nextCase = 13;
							caseNumber = nextCase;
							//newPanel = true;
							KillPanel();
							CurrentMC = new CRVPanel3();
							BtnDiscounter(24, false);
							playFrame = 1;
							CurrentMC.x = 117;
							CurrentMC.y = 32;
							CurrentMC.width *= 0.45;
							CurrentMC.height *= 0.45;
							DefaultPanels();
							//DefaultMCValues();
							BirthMC();
							//WizardBool = true;
							//boolPage1 = false;
							//boolPage2 = false;
						
						//boolPage1 = false;
						//statements;
						break;
						
						case 13:						
						
						if(NinjaBool == true){
							NextPanel = panel14;
							transitioningDown = true;
							nextCase = 13.1;

							playFrame = 1;
							BtnDiscounter(24, false);
							newPanel = true;
							KillPanel();
							//BirthPanel();
							CurrentMC = new VPanel5a();
							CurrentMC.x = 40;
							CurrentMC.y = 27;
							CurrentMC.width *= 0.60;
							CurrentMC.height *= 0.60;
							
						}else{
							NextPanel = panel21;
							transitioningDown = true;
							nextCase = 21;
							newPanel = true;
							KillPanel();
							CurrentMC = new NinjaP1();
							BtnDiscounter(24, false);
							playFrame = 1;
							DefaultPanels();
							
							CurrentMC.x = 122;
							CurrentMC.y = 16;
							CurrentMC.width *= 0.65;
							CurrentMC.height *= 0.65;
							
							boolPage1= false;
							NinjaBool = true;
							//boolPage1 = false;
						}
						break;
						case 13.1:
							NextPanel = panel31;
							transitioningDown = true;
							nextCase = 31;
							newPanel = true;
							KillPanel();
							CurrentMC = new WholeScene1();
							BtnDiscounter(24, false);
							playFrame = 1;
							DefaultPanels();
							
							CurrentMC.x = 95;
							CurrentMC.y = 45;
							CurrentMC.width *= .8;
							CurrentMC.height *= .8;
							
							boolPage1= false;
							boolPage1= false;
						
							WizardBool = true;
							break;
						
						case 15:
						
						if(NinjaBool == true&& WizardBool == true){
							NextPanel = panel11;
							transitioningDown = true;
							nextCase = 16;
							newPanel = true;
							KillPanel();
							CurrentMC = new Open3();
							BtnDiscounter(24, false);
							playFrame = 1;

							CurrentMC.x = 15;
						CurrentMC.y = 35;
						CurrentMC.width *= 0.9;
						CurrentMC.height *= 0.9;
						
						PanX = 15;
						PanY = 50;
						PanH = 767;
						PanW = 660;
							DefaultMask();
							
							//DefaultMCValues();
							//boolPage1 = false;
							//boolPage2 = false;
							
						}else{
							NextPanel = panel11;
							transitioningDown = true;
							nextCase = 11.5;
							newPanel = true;
							KillPanel();
							CurrentMC = new Open2();
							BtnDiscounter(24, false);
							playFrame = 1;
							DefaultPanels();

							CurrentMC.x = 15;
						CurrentMC.y = 35;
						CurrentMC.width *= 0.9;
						CurrentMC.height *= 0.9;
						
						PanX = 15;
						PanY = 50;
						PanH = 767;
						PanW = 660;
							//DefaultMCValues();
							//boolPage1=false;
							
							//boolPage1 = false;
						}
						//boolPage1 = false;
						//statements;
						break;
						
						case 16:
						
						
							NextPanel = panel15;
							transitioningDown = true;
							nextCase = 16.1;
							newPanel = true;
							KillPanel();
							CurrentMC = new VPanelF();
							BtnDiscounter(10, false);
							playFrame = 1;
							CurrentMC.x = 48;
							CurrentMC.y = 0;
							CurrentMC.width *= 0.6;
							CurrentMC.height *= 0.6;
							PanX = 42;
							PanY = 84;
							PanH = 777;
							PanW = 646;
							//DefaultPanels();
							//DefaultMCValues();
							//boolPage1 = false;
							//boolPage2 = false;
							
						
						//boolPage1 = false;
						//statements;
						break;
						
						case 16.1:
						
						
							NextPanel = panel36;
							transitioningDown = true;
							nextCase = 16.2;
							newPanel = true;
							KillPanel();
							if(LightningBool == true){
								CurrentMC = new WizardEndL();
							}else{
								CurrentMC = new WizardEndF();
							}
							
							BtnDiscounter(10, false);
							playFrame = 1;
							
							CurrentMC.width *= 0.38;
							CurrentMC.height *= 0.38;
						
							CurrentMC.x = 254;
							CurrentMC.y = 496;
							
							PanX = 12;
							PanY = 296;
							PanH = 250;
							
							
							
							boolPage1 = false;
							boolPage2 = false;
							
						
						//boolPage1 = false;
						//statements;
						break;
						case 16.2:
						
						
							NextPanel = panel26;
							transitioningDown = true;
							nextCase = 16.3;
							newPanel = true;
							KillPanel();
							CurrentMC = new NinjaP8();
							BtnDiscounter(10, false);
							playFrame = 1;
						
							CurrentMC.width *= 0.65;
							CurrentMC.height *= 0.65;
						
							CurrentMC.x = 112;
							CurrentMC.y = 15;
							PanX = 107;
							PanY = 45;
							PanH = 840;
							PanW = 480;
							
							//DefaultPanels();
							
							//boolPage1 = false;
							boolPage2 = true;
							Mask2.x = 16;
							Mask2.y = 16;
						
						//boolPage1 = false;
						//statements;
						break;
						
						case 16.3:
							NextPanel = panel46;	
						
							nextCase = 16.4;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new DwarfLastA();
							newPanel = true;
							
							
							CurrentMC.x = -50;
							CurrentMC.y = -25;
							//CurrentMC.width *= 1;
							//CurrentMC.height *= 1;
						
							PanX = -50;
							PanY = 103;
							PanH = 720;
							PanW = 790;
							
							
							break;
							
							
						case 16.4:
							//NextPanel = panel46;	
						
							nextCase = 16.5;
							caseNumber = nextCase;
							//transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new DwarfLastC();
							newPanel = true;
							BirthMC();
							CurrentMC.width *= .80;
							CurrentMC.height *= .80;
							CurrentMC.x = 296;
							CurrentMC.y = 503;
							
						
							PanX = -50;
							PanY = 103;
							PanH = 732;
							PanW = 804;
							boolPage3 = false;
							boolPage2 = false;
							
							break;
							
						case 16.5:
							NextPanel = panel53;	
						
							nextCase = 16.6;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new ElfP2AA();
							newPanel = true;
							
							
							CurrentMC.x = 46;
							CurrentMC.y = 98;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						
							PanX = 0;
							PanY = 0;
							PanH *= 1.06;
							PanW *= 1.06;
							boolPage4 = false;
							
							
							break;
							
						case 16.6:
							//NextPanel = panel36;	
						
							nextCase = 70;
							caseNumber = nextCase;
							//transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new ElfP4();
							newPanel = true;
							BirthMC();
							
							CurrentMC.x = 46;
							CurrentMC.y = 98;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						
							
							
							break;
						
						
						
						

				
					
					//2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
					case 21:
						
						NextPanel = panel22;	
						
						nextCase = 22;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						KillPanel();
						CurrentMC= new NinjaP2();
						newPanel = true;
						
						
						CurrentMC.x = 90;
						CurrentMC.y = 4;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
						
						PanX = 119;
						PanY = 49;
						PanH = 860;
						PanW = 530;
						NinjaBool = true;
						boolPage1 = false;
						break;

					case 22:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel23;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 24;
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(53, false);
						//newPanel = true;
						KillPanel();
						CurrentMC = new NinjaP4();
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;
					
						CurrentMC.x = 90;
						CurrentMC.y = 4;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
						
						PanX = 95;
						PanY = 45;
						PanH = 852;
						PanW = 524;

						
						break;
						
						case 24:
						
						
					
						
							NextPanel = panel25;
							nextCase = 25;
								
							//caseNumber = 34;
							transitioningDown = true;
							playFrame = 1;
							newPanel = true;
							
							BtnDiscounter(80, false);

							
							
							KillPanel();
							CurrentMC = new NinjaP6();
							
							CurrentMC.y = 45;
							CurrentMC.x = 95;
							CurrentMC.height *=.65;
							CurrentMC.width *=.65;
							
							addHookshot();
							
							
							PanX = 95;
							PanY = 45;
							PanH = 852;
							PanW = 524;
							break;
							
						case 24.1:
						
						
					
						
							NextPanel = panel25;
							nextCase = 25;
								
							//caseNumber = 34;
							transitioningDown = true;
							playFrame = 1;
							newPanel = true;
							
							BtnDiscounter(80, false);

							
							
							KillPanel();
							CurrentMC = new NinjaP7();
							
							CurrentMC.y = 45;
							CurrentMC.x = 95;
							CurrentMC.height *=.65;
							CurrentMC.width *=.65;
							
							addHookshot();
							
							
							PanX = 95;
							PanY = 45;
							PanH = 852;
							PanW = 524;
							break;
							
						case 25:
					
						
						NextPanel = panel35;	
						
						nextCase = 41;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						CurrentMC= new TreesPath();
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 120;
						CurrentMC.y = 30;
						CurrentMC.width *= .45;
						CurrentMC.height *= .45;
					
						PanX = 120;
						PanY = 30;
						PanH = 872;
						PanW = 484;
					
						boolPage2 = false
					
						break;

					
					//33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
					
					case 31:
						
						NextPanel = panel32;	
						
						nextCase = 32;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						CurrentMC= new WholeScene2();
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 42;
						CurrentMC.y = 22;
						CurrentMC.width *= .7;
						CurrentMC.height *= .7;
						
						PanX = 42;
						PanY = 22;
						PanH = 876;
						PanW = 640;
					
						break;

					case 32:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel33;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 33;
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(53, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new WholeScene3L();
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;
					
						CurrentMC.y = 45;
						CurrentMC.x = 95;
						//CurrentMC.height *=.65;
						//CurrentMC.width *=.65;
						
						PanX = 95;
						PanY = 45;
						PanH = 852;
						PanW = 524;

						addLightning();
						LightningBool = true;
						WizardBool = true;
						break;

					case 33:
						
						//NextPanel = panel34;	
						
						nextCase = 34;
						caseNumber = 34;
						//transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						if(LightningBool == true){
							CurrentMC= new WholeScene3LB();
						}
						if(FireBool == true){
							CurrentMC= new WholeScene3FB();
						}
						newPanel = false;
						KillPanel();
						BirthMC();
						
						CurrentMC.y = 45;
						CurrentMC.x = 95;
						//CurrentMC.height *=.65;
						//CurrentMC.width *=.65;
						
						PanX = 95;
						PanY = 45;
						PanH = 852;
						PanW = 524;
					
						break;
					
						
					case 34:
						
						NextPanel = panel34;	
						
						nextCase = 35;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						if(LightningBool == true){
							CurrentMC= new WholeScene4L();
						}
						if(FireBool == true){
							CurrentMC= new WholeScene4();
						}
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 81;
						CurrentMC.y = 26;
						
						
						PanX = 81;
						PanY = 26;
						PanH = 876;
						PanW = 544;
					
						break;
					case 35:
						
						NextPanel = panel35;	
						
						nextCase = 36;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						CurrentMC= new TreesPath();
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 120;
						CurrentMC.y = 30;
						CurrentMC.width *= .45;
						CurrentMC.height *= .45;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
						
						break;
						
					case 36:
						if(DwarfBool = true){
							NextPanel = panel51;	
							
							nextCase = 51;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							
							CurrentMC= new ElfP1AA();
							newPanel = true;
							KillPanel();
							
							CurrentMC.x = 0;
							CurrentMC.y = 61;
							CurrentMC.width *= 1;
							CurrentMC.height *= 1;
						
							PanX = 0;
							PanY = 150;
							PanH = 720;
							PanW = 720;
							
							ElfBool = true;
							boolPage4 = false;
						}else{
							NextPanel = panel41;	
							
							nextCase = 41;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							
							CurrentMC= new DwarfP1();
							newPanel = true;
							KillPanel();
							
							CurrentMC.x = 287;
							CurrentMC.y = 455;
							CurrentMC.width *= 1;
							CurrentMC.height *= 1;
						
							PanX = -50;
							PanY = 103;
							PanH = 732;
							PanW = 804;
							
							DwarfBool = true;
					}
							boolPage1 = false;
							boolPage2 = false;
							boolPage3 = false;
							
					
					break;
					
					
					
					
					
					
										//444444444444444444444444444444444444444444444444444444444444444444444444444444444
					case 41:
						//NextPanel = panel42;
						//transitioningDown = true;
						nextCase = 41.1;
						caseNumber = nextCase

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP1a();
						BirthMC();
					
						CurrentMC.width *= .85;
						CurrentMC.height *= .85;
						CurrentMC.x = 323;
						CurrentMC.y = 498;
						
						DwarfBool = true;

						 //DefaultPanels(); 
						//DefaultMCValues();
						//statements;
						break;
					case 41.1:
						//NextPanel = panel42;
						//transitioningDown = true;
						nextCase = 42;
						caseNumber = nextCase

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP12();
						

						CurrentMC.width *= .85;
						CurrentMC.height *= .85;
						CurrentMC.x = 323;
						CurrentMC.y = 498;
						BirthMC();
						//DefaultPanels(); 
						//DefaultMCValues();
						//statements;
						break;
					
					case 41.2:
						//NextPanel = panel42;
						transitioningDown = true;
						nextCase = 42;
						//caseNumber = nextCase

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP12();

						
						CurrentMC.width *= .85;
						CurrentMC.height *= .85;
						CurrentMC.x = 323;
						CurrentMC.y = 498;
						
						 //DefaultPanels(); 
						//DefaultMCValues();
						//statements;
						break;

					case 42:
						NextPanel = panel42;
						transitioningDown = true;
						nextCase = 43;
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP2();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .9;
						CurrentMC.height *= .9;
						CurrentMC.x = 350;
						CurrentMC.y = 457;
					
						PanX = 0;
						PanY = 100;
						PanH = 720;
						PanW = 720;						
						//DefaultMCValues();
						//statements;
						break;
						
					case 43:
						NextPanel = panel43;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP3();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						//CurrentMC.width *= .85;
						//CurrentMC.height *= .85;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
					
						PanX = 0;
						PanY = 74;
						PanH = 730;
						PanW = 800;						
						//statements;
						break;

					case 44:
						NextPanel = panel44;
						transitioningDown = true;
						nextCase = 44.2;
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP4();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
					
						PanX = 0;
						PanY = 80;
						PanH = 710;
						PanW = 710;						
						//statements;
						break;

					case 44.2:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 44.3;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP42();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
						//statements;
						break;
					
					case 44.3:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 44.4;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP42();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
						//statements;
						break;
					
					case 44.4:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 44.5;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP421();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
						//statements;
						break;
					
					case 44.5:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 45;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP422();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .95;
						CurrentMC.height *= .95;
						CurrentMC.x = 340;
						CurrentMC.y = 469;
						addBeer();
						//statements;
						break;
					
					case 45:
						NextPanel = panel45;
						transitioningDown = true;
						nextCase = 15;
						newPanel = true;
						KillPanel();

						CurrentMC = new DwarfP5Bad();
						BtnDiscounter(24, false);
						playFrame = 2;
							CurrentMC.x = 345;
							CurrentMC.y = 504;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						
							PanX = -50;
							PanY = 103;
							PanH = 732;
							PanW = 804;
						 //DefaultMask(); 
						//statements;
						break;
					case 46:
					
					break;
					
					///555555555555555555555555555555555555555555555555555555555555555555555555
					case 51:
						NextPanel = panel52;
						transitioningDown = true;
						nextCase = 52;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new ElfP2AA();
					
							CurrentMC.x = 0;
							CurrentMC.y = 0;
							//CurrentMC.width *= .85;
							//CurrentMC.height *= .85;
						
							PanX = 0;
							PanY = 94;
							PanH = 720;
							PanW = 720;

						 //DefaultPanels(); DefaultMCValues();
						//statements;
						break;

					case 52:
						//NextPanel = panel;
						//transitioningDown = true;
						nextCase = 15;
						caseNumber = nextCase
						newPanel = true;
						KillPanel();

						CurrentMC = new ElfP3A();
						BtnDiscounter(24, false);
						playFrame = 1;
							CurrentMC.x = 30;
							CurrentMC.y = 180;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						BirthMC();
						addDagger();
						//statements;
						break;
						
					case 53:

						//statements;
						break;


					
					////////////////////////////////////////////////////////////////////////////
					
					
					case 70:
						NextPanel = endPanel1;
						transitioningDown = true;
						nextCase = 70.1;
						//newPanel = true;
						
						caseNumber = nextCase;
						KillPanel();
						CurrentMC = new WolfEnd();
						
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 124;
						PanY = 186;
						PanH = 852;
						PanW = 666;
					
						
						break;
					case 70.1:
						//NextPanel = endPanel1;
						//transitioningDown = true;
						nextCase = 71;
						//newPanel = true;
						
						caseNumber = nextCase;
						KillPanel();
						CurrentMC = new WolfAChoice();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
					
						
						break;
					case 71:
						//NextPanel = endPanel1;
						//transitioningDown = true;
						nextCase = 72;
						
						newPanel = true;
						caseNumber = nextCase;
						KillPanel();
						CurrentMC = new WolfCChoice();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
						
						BirthMC();
					
						
						break;
					case 72:
						//NextPanel = endPanel1;
						//transitioningDown = true;
						nextCase = 72;
						newPanel = true;
						
						KillPanel();
						CurrentMC = new WolfEChoice();
						
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						//DefaultMCValues();
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
						BirthMC();
						
						break;
				}
			}

		}

		private function bluClick(e: MouseEvent) {
			trace("blu");
			if (bluBtnClickable == true) {
				switch (caseNumber) {

					case 11:
						// first panel code

									
						CurrentMC = new Open1();

						
						
						
						CurrentMC.x = 15;
						CurrentMC.y = 35;
						CurrentMC.width *= 0.9;
						CurrentMC.height *= 0.9;
						
						PanX = 15;
						PanY = 50;
						PanH = 767;
						PanW = 660;
					
						CurrentPanel = panel11;
						NextPanel = panel12;
						BirthTrans();
						scaleMath();
						nextCase = 11.5;
						transitioningUp = true;
						playFrame = 1;
						BtnDiscounter(0, false);
						newPanel = true;
						
					

						
						break;

					case 11.5:
						

						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel12;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 12
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(24, false);
						KillPanel();
						newPanel = true;
						CurrentMC = new CRVPanel1();
						//use newPanel = true,whenever you need to make a new panel
						

						//set these values to make your panel fit. 
						CurrentMC.x = 361;
						CurrentMC.y = 635;
						CurrentMC.width *= .64;
						CurrentMC.height *= .64;
						//DefaultPanels();
						//DefaultMCValues();


						break;

					
					case 12:
						NextPanel = panel13;
						transitioningDown = true;
						nextCase = 12.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						//BirthPanel();
						CurrentMC = new CRVPanel2();
						CurrentMC.x = 117;
						CurrentMC.y = 32;
						CurrentMC.width *= 0.45;
						CurrentMC.height *= 0.45;					
					

						DefaultPanels();
						 //DefaultMCValues();
						//statements;
						break;

					case 12.5:
						
						
							//NextPanel = panel13;
							//transitioningDown = true;
							nextCase = 13;
							caseNumber = nextCase;
							//newPanel = true;
							KillPanel();
							CurrentMC = new CRVPanel3();
							BtnDiscounter(24, false);
							playFrame = 1;
							CurrentMC.x = 117;
							CurrentMC.y = 32;
							CurrentMC.width *= 0.45;
							CurrentMC.height *= 0.45;
							DefaultPanels();
							//DefaultMCValues();
							BirthMC();
							//WizardBool = true;
							//boolPage1 = false;
							//boolPage2 = false;
						
						//boolPage1 = false;
						//statements;
						break;
						
						case 13:						
						
						if(WizardBool == true){
							NextPanel = panel14;
							transitioningDown = true;
							nextCase = 13.1;

							playFrame = 1;
							BtnDiscounter(24, false);
							newPanel = true;
							KillPanel();
							//BirthPanel();
							CurrentMC = new VPanel5a();
							CurrentMC.x = 40;
							CurrentMC.y = 27;
							CurrentMC.width *= 0.60;
							CurrentMC.height *= 0.60;
							
						}else{
							NextPanel = panel31;
							transitioningDown = true;
							nextCase = 31;
							newPanel = true;
							KillPanel();
							CurrentMC = new WholeScene1();
							BtnDiscounter(24, false);
							playFrame = 1;
							DefaultPanels();
							
							
							
							CurrentMC.x = 95;
							CurrentMC.y = 45;
							CurrentMC.width *= .8;
							CurrentMC.height *= .8;
							
							boolPage1= false;
							boolPage1= false;
							WizardBool = true;
							//boolPage1 = false;
						}
						break;
						case 13.1:
							NextPanel = panel31;
							transitioningDown = true;
							nextCase = 31;
							newPanel = true;
							KillPanel();
							CurrentMC = new WholeScene1();
							BtnDiscounter(24, false);
							playFrame = 1;
							DefaultPanels();
							CurrentMC.x = 122;
							CurrentMC.y = 16;
							CurrentMC.width *= 0.65;
							CurrentMC.height *= 0.65;
							
							boolPage1= false;

							
							NinjaBool = true;
							break;
						
						case 15:
						
						if(NinjaBool == true&& WizardBool == true){
							NextPanel = panel11;
							transitioningDown = true;
							nextCase = 16;
							newPanel = true;
							KillPanel();
							CurrentMC = new Open3();
							BtnDiscounter(24, false);
							playFrame = 1;

							CurrentMC.x = 15;
						CurrentMC.y = 35;
						CurrentMC.width *= 0.9;
						CurrentMC.height *= 0.9;
							
						DefaultMask();
						PanX = 15;
						PanY = 50;
						PanH = 767;
						PanW = 660;
							
							//DefaultMCValues();
							//boolPage1 = false;
							//boolPage2 = false;
							
						}else{
							NextPanel = panel11;
							transitioningDown = true;
							nextCase = 11.5;
							newPanel = true;
							KillPanel();
							CurrentMC = new Open2();
							BtnDiscounter(24, false);
							playFrame = 1;
							DefaultPanels();

							CurrentMC.x = 15;
						CurrentMC.y = 35;
						CurrentMC.width *= 0.9;
						CurrentMC.height *= 0.9;
						
						PanX = 15;
						PanY = 50;
						PanH = 767;
						PanW = 660;
							//DefaultMCValues();
							//boolPage1=false;
							
							//boolPage1 = false;
						}
						//boolPage1 = false;
						//statements;
						break;
						
						case 16:
						
						
							NextPanel = panel15;
							transitioningDown = true;
							nextCase = 16.1;
							newPanel = true;
							KillPanel();
							CurrentMC = new VPanelF();
							BtnDiscounter(10, false);
							playFrame = 1;
							CurrentMC.x = 48;
							CurrentMC.y = 0;
							CurrentMC.width *= 0.6;
							CurrentMC.height *= 0.6;
							PanX = 42;
							PanY = 84;
							PanH = 777;
							PanW = 646;
							//DefaultPanels();
							//DefaultMCValues();
							//boolPage1 = false;
							//boolPage2 = false;
							
						
						//boolPage1 = false;
						//statements;
						break;
						
						case 16.1:
						
						
							NextPanel = panel36;
							transitioningDown = true;
							nextCase = 16.2;
							newPanel = true;
							KillPanel();
							if(LightningBool == true){
								CurrentMC = new WizardEndL();
							}else{
								CurrentMC = new WizardEndF();
							}
							
							BtnDiscounter(10, false);
							playFrame = 1;
							
							CurrentMC.width *= 0.38;
							CurrentMC.height *= 0.38;
						
							CurrentMC.x = 254;
							CurrentMC.y = 496;
							PanH = 250;
							PanX = 12;
							PanY = 296;
							
							
							
							boolPage1 = false;
							boolPage2 = false;
							
						
						//boolPage1 = false;
						//statements;
						break;
						case 16.2:
						
						
							NextPanel = panel26;
							transitioningDown = true;
							nextCase = 16.3;
							newPanel = true;
							KillPanel();
							CurrentMC = new NinjaP8();
							BtnDiscounter(10, false);
							playFrame = 1;
						
							CurrentMC.width *= 0.65;
							CurrentMC.height *= 0.65;
						
							CurrentMC.x = 112;
							CurrentMC.y = 15;
							PanX = 107;
							PanY = 45;
							PanH = 840;
							PanW = 480;
							
							//DefaultPanels();
							
							//boolPage1 = false;
							boolPage2 = true;
							Mask2.x = 16;
							Mask2.y = 16;
						
						//boolPage1 = false;
						//statements;
						break;
						
						case 16.3:
							NextPanel = panel46;	
						
							nextCase = 16.4;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new DwarfLastA();
							newPanel = true;
							
							
							CurrentMC.x = -50;
							CurrentMC.y = -25;
							//CurrentMC.width *= 1;
							//CurrentMC.height *= 1;
						
							PanX = -50;
							PanY = 103;
							PanH = 720;
							PanW = 790;
							
							
							break;
							
							
						case 16.4:
							//NextPanel = panel46;	
						
							nextCase = 16.5;
							caseNumber = nextCase;
							//transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new DwarfLastC();
							newPanel = true;
							BirthMC();
							CurrentMC.width *= .80;
							CurrentMC.height *= .80;
							CurrentMC.x = 296;
							CurrentMC.y = 503;
							
						
							PanX = -50;
							PanY = 103;
							PanH = 732;
							PanW = 804;
							boolPage3 = false;
							boolPage2 = false;
							
							break;
							
						case 16.5:
							NextPanel = panel53;	
						
							nextCase = 16.6;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new ElfP2AA();
							newPanel = true;
							
							
							CurrentMC.x = 46;
							CurrentMC.y = 98;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						
							PanX = 0;
							PanY = 0;
							PanH *= 1.06;
							PanW *= 1.06;
							boolPage4 = false;
							
							
							break;
							
						case 16.6:
							//NextPanel = panel36;	
						
							nextCase = 70;
							caseNumber = nextCase;
							//transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							KillPanel();
							CurrentMC= new ElfP4();
							newPanel = true;
							BirthMC();
							
							CurrentMC.x = 46;
							CurrentMC.y = 98;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						
							
							
							break;
						
						
						
						

				
					
					//2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
					case 21:
						
						NextPanel = panel22;	
						
						nextCase = 24.1;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						KillPanel();
						CurrentMC= new NinjaP2();
						newPanel = true;
						
						
						CurrentMC.x = 90;
						CurrentMC.y = 4;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
						
						PanX = 119;
						PanY = 49;
						PanH = 860;
						PanW = 530;
						NinjaBool = true;
						boolPage1 = false;
						break;

					case 22:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel24;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 25;
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(53, false);
						//newPanel = true;
						KillPanel();
						CurrentMC = new NinjaP4();
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;
					
						CurrentMC.x = 90;
						CurrentMC.y = 4;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
						
						PanX = 95;
						PanY = 45;
						PanH = 852;
						PanW = 524;

						
						break;
						
						
						
						case 24:
						
						
					
						
							NextPanel = panel25;
							nextCase = 25;
								
							//caseNumber = 34;
							transitioningDown = true;
							playFrame = 1;
							newPanel = true;
							
							BtnDiscounter(80, false);

							
							
							KillPanel();
							CurrentMC = new NinjaP6();
							
							CurrentMC.y = 45;
							CurrentMC.x = 95;
							CurrentMC.height *=.65;
							CurrentMC.width *=.65;
							
							addHookshot();
							
							
							PanX = 95;
							PanY = 45;
							PanH = 852;
							PanW = 524;
							break;
							
							case 24.1:
						
						
					
						
							NextPanel = panel25;
							nextCase = 25;
								
							//caseNumber = 34;
							transitioningDown = true;
							playFrame = 1;
							newPanel = true;
							
							BtnDiscounter(80, false);

							
							
							KillPanel();
							CurrentMC = new NinjaP7();
							
							CurrentMC.y = 45;
							CurrentMC.x = 95;
							CurrentMC.height *=.65;
							CurrentMC.width *=.65;
							
							addHookshot();
							
							
							PanX = 95;
							PanY = 45;
							PanH = 852;
							PanW = 524;
							break;
							
						case 25:
					
						
						NextPanel = panel35;	
						
						nextCase = 41;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						CurrentMC= new TreesPath();
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 120;
						CurrentMC.y = 30;
						CurrentMC.width *= .45;
						CurrentMC.height *= .45;
					
						PanX = 120;
						PanY = 30;
						PanH = 872;
						PanW = 484;
					
						boolPage2 = false
					
						break;

					
					//33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
					
					case 31:
						
						NextPanel = panel32;	
						
						nextCase = 32;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						CurrentMC= new WholeScene2();
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 42;
						CurrentMC.y = 22;
						CurrentMC.width *= .7;
						CurrentMC.height *= .7;
						
						PanX = 42;
						PanY = 22;
						PanH = 876;
						PanW = 640;
					
						break;

					case 32:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel33;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 33;
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(53, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new WholeScene3();
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;
					
						CurrentMC.y = 45;
						CurrentMC.x = 95;
						//CurrentMC.height *=.65;
						//CurrentMC.width *=.65;
						
						PanX = 95;
						PanY = 45;
						PanH = 852;
						PanW = 524;

						addFire();
						FireBool = true;
						WizardBool = true;
						break;

					case 33:
						
						//NextPanel = panel34;	
						
						nextCase = 34;
						caseNumber = 34;
						//transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						if(LightningBool == true){
							CurrentMC= new WholeScene3LB();
						}
						if(FireBool == true){
							CurrentMC= new WholeScene3FB();
						}
						newPanel = false;
						KillPanel();
						BirthMC();
						
						CurrentMC.y = 45;
						CurrentMC.x = 95;
						//CurrentMC.height *=.65;
						//CurrentMC.width *=.65;
						
						PanX = 95;
						PanY = 45;
						PanH = 852;
						PanW = 524;
					
						break;
					
						
					case 34:
						
						NextPanel = panel34;	
						
						nextCase = 35;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						if(LightningBool == true){
							CurrentMC= new WholeScene4L();
						}
						if(FireBool == true){
							CurrentMC= new WholeScene4();
						}
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 81;
						CurrentMC.y = 26;
						
						
						PanX = 81;
						PanY = 26;
						PanH = 876;
						PanW = 544;
					
						break;
					case 35:
						
						NextPanel = panel35;	
						
						nextCase = 36;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(0, false);

						
						CurrentMC= new TreesPath();
						newPanel = true;
						KillPanel();
						
						CurrentMC.x = 120;
						CurrentMC.y = 30;
						CurrentMC.width *= .45;
						CurrentMC.height *= .45;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
						
						break;
						
					case 36:
						if(DwarfBool = true){
							NextPanel = panel51;	
							
							nextCase = 51;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							
							CurrentMC= new ElfP1AA();
							newPanel = true;
							KillPanel();
							
							CurrentMC.x = 0;
							CurrentMC.y = 61;
							CurrentMC.width *= 1;
							CurrentMC.height *= 1;
						
							PanX = 0;
							PanY = 150;
							PanH = 720;
							PanW = 720;
							
							ElfBool = true;
							boolPage4 = false;
						}else{
							NextPanel = panel41;	
							
							nextCase = 41;
							transitioningDown = true;
							playFrame = 1;
							BtnDiscounter(0, false);

							
							CurrentMC= new DwarfP1();
							newPanel = true;
							KillPanel();
							
							CurrentMC.x = 287;
							CurrentMC.y = 455;
							CurrentMC.width *= 1;
							CurrentMC.height *= 1;
						
							PanX = -50;
							PanY = 103;
							PanH = 732;
							PanW = 804;
							
							DwarfBool = true;
					}
							boolPage1 = false;
							boolPage2 = false;
							boolPage3 = false;
							
					
					break;
					
					
					
					
					
					
										//444444444444444444444444444444444444444444444444444444444444444444444444444444444
					case 41:
						//NextPanel = panel42;
						//transitioningDown = true;
						nextCase = 41.1;
						caseNumber = nextCase

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP1a();
						BirthMC();
					
						CurrentMC.width *= .85;
						CurrentMC.height *= .85;
						CurrentMC.x = 323;
						CurrentMC.y = 498;
						
						DwarfBool = true;

						 //DefaultPanels(); 
						//DefaultMCValues();
						//statements;
						break;
					case 41.1:
						//NextPanel = panel42;
						//transitioningDown = true;
						nextCase = 41.2;
						caseNumber = nextCase

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP11();
						

						CurrentMC.width *= .85;
						CurrentMC.height *= .85;
						CurrentMC.x = 323;
						CurrentMC.y = 498;
						BirthMC();
						//DefaultPanels(); 
						//DefaultMCValues();
						//statements;
						break;
					
					case 41.2:
						//NextPanel = panel42;
						transitioningDown = true;
						nextCase = 41.2;
						//caseNumber = nextCase

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP11();

						
						CurrentMC.width *= .85;
						CurrentMC.height *= .85;
						CurrentMC.x = 323;
						CurrentMC.y = 498;
						
						 //DefaultPanels(); 
						//DefaultMCValues();
						//statements;
						break;

					case 42:
						NextPanel = panel42;
						transitioningDown = true;
						nextCase = 43;
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP2();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .9;
						CurrentMC.height *= .9;
						CurrentMC.x = 350;
						CurrentMC.y = 457;
					
						PanX = 0;
						PanY = 100;
						PanH = 720;
						PanW = 720;						
						//DefaultMCValues();
						//statements;
						break;
						
					case 43:
						NextPanel = panel43;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP3();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						//CurrentMC.width *= .85;
						//CurrentMC.height *= .85;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
					
						PanX = 0;
						PanY = 74;
						PanH = 730;
						PanW = 800;						
						//statements;
						break;

					case 44:
						NextPanel = panel44;
						transitioningDown = true;
						nextCase = 44.2;
						newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP4();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
					
						PanX = 0;
						PanY = 80;
						PanH = 710;
						PanW = 710;						
						//statements;
						break;

					case 44.2:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 44.3;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new TDwarfP41();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
						//statements;
						break;
					
					case 44.3:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 44.4;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new TDwarfP41();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
						//statements;
						break;
					
					case 44.4:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 44.5;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP421();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .8;
						CurrentMC.height *= .8;
						CurrentMC.x = 362;
						CurrentMC.y = 477;
						//statements;
						break;
					
					case 44.5:
						//NextPanel = panel44;
						//transitioningDown = true;
						nextCase = 45;
						caseNumber = nextCase;
						//newPanel = true;
						KillPanel();
						CurrentMC = new DwarfP422();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 1;
						
						CurrentMC.width *= .95;
						CurrentMC.height *= .95;
						CurrentMC.x = 340;
						CurrentMC.y = 469;
						addBeer();
						//statements;
						break;
					
					case 45:
						NextPanel = panel45;
						transitioningDown = true;
						nextCase = 15;
						newPanel = true;
						KillPanel();

						CurrentMC = new DwarfP5Bad();
						BtnDiscounter(24, false);
						playFrame = 2;
							CurrentMC.x = 345;
							CurrentMC.y = 504;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						
							PanX = -50;
							PanY = 103;
							PanH = 732;
							PanW = 804;
						 //DefaultMask(); 
						//statements;
						break;
					case 46:
					
					break;
					
					///555555555555555555555555555555555555555555555555555555555555555555555555
					case 51:
						NextPanel = panel52;
						transitioningDown = true;
						nextCase = 52;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new ElfP2AA();
					
							CurrentMC.x = 0;
							CurrentMC.y = 0;
							//CurrentMC.width *= .85;
							//CurrentMC.height *= .85;
						
							PanX = 0;
							PanY = 94;
							PanH = 720;
							PanW = 720;

						 //DefaultPanels(); DefaultMCValues();
						//statements;
						break;

					case 52:
						//NextPanel = panel;
						//transitioningDown = true;
						nextCase = 15;
						caseNumber = nextCase
						newPanel = true;
						KillPanel();

						CurrentMC = new ElfP3B();
						BtnDiscounter(24, false);
						playFrame = 1;
							CurrentMC.x = 30;
							CurrentMC.y = 180;
							CurrentMC.width *= .85;
							CurrentMC.height *= .85;
						BirthMC();
						addDagger();
						
						//statements;
						break;
						
					case 53:

						//statements;
						break;


					
					////////////////////////////////////////////////////////////////////////////
					
					
					case 70:
						NextPanel = endPanel1;
						transitioningDown = true;
						nextCase = 70.1;
						//newPanel = true;
						
						caseNumber = nextCase;
						KillPanel();
						CurrentMC = new WolfEnd();
						
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 124;
						PanY = 186;
						PanH = 852;
						PanW = 666;
					
						
						break;
					case 70.1:
						//NextPanel = endPanel1;
						//transitioningDown = true;
						nextCase = 71;
						//newPanel = true;
						
						caseNumber = nextCase;
						KillPanel();
						CurrentMC = new WolfBChoice();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
					
						
						break;
					case 71:
						//NextPanel = endPanel1;
						//transitioningDown = true;
						nextCase = 72;
						
						newPanel = true;
						caseNumber = nextCase;
						KillPanel();
						CurrentMC = new WolfCChoice();
						BirthMC();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
						
						BirthMC();
					
						
						break;
					case 72:
						//NextPanel = endPanel1;
						//transitioningDown = true;
						nextCase = 72;
						newPanel = true;
						
						KillPanel();
						CurrentMC = new WolfDChoice();
						
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						
						//DefaultMCValues();
						CurrentMC.x = 10;
						CurrentMC.y = -145;
						CurrentMC.width *= .65;
						CurrentMC.height *= .65;
					
						PanX = 120;
						PanY = 30;
						PanH = 876;
						PanW = 682;
						BirthMC();
						
						break;
				}
			}

		}
		private function update(e: Event): void {
			//trace(movieClipHolder.length);
			if (boolPage1 == false) {
				if (Mask1.x < 800) {
					Mask1.x += 40;
				} else {
					if (boolPage2 == false) {
						if (Mask2.x > -800) {
							Mask2.x -= 40;
						} else {
							if (boolPage3 == false) {
								if (Mask3.y > -1000) {
									Mask3.y -= 50;
								} else {
									if (boolPage4 == false) {
										if (Mask4.x < 800) {
											Mask4.x += 40;
										} else {
											if (boolPage5 == false) {
												if (Mask5.x > -800) {
													Mask5.x -= 40;
												} else {

												}

											}

										}

									}
								}
							}
						}
					}

				}
			}

			if (transitioningUp == true) {
				if (transitionCounter < transitionTime) {
					transitionCounter++


					transImage.width += transitionScaleX;
					transImage.height += transitionScaleY;
					transImage.x -= transitionPosX;
					transImage.y -= transitionPosY;

				} else {

					transitionCounter = 0;
					transitioningUp = false;
					caseNumber = nextCase;

					//Create Child of the movieclip
					if (newPanel == true) {
						BirthMC();
						newPanel = false;
					} else {
						gotoAndPlay(playFrame);
						
						
					}

				}
			}
			if (transitioningDown == true) {
				if (transitionCounter < transitionTime) {
					transitionCounter++;

					transImage.width -= transitionScaleX;
					transImage.height -= transitionScaleY;
					transImage.x += transitionPosX;
					transImage.y += transitionPosY;




				} else {
					//transImage.alpha = 0;
					removeChild(transImage);
					CurrentPanel = NextPanel;
					scaleMath();
					transitionCounter = 0;
					transitioningUp = true;
					transitioningDown = false;
					BirthTrans();

				}

			}

			//More Code for buttons to become clickable after being clicked (if they are clicked before the transition is complete it can mess things up, I can fix that later.
			if (redBtnClickable == false) {
				if (redDisCounter == 0) {

					redButton.gotoAndStop(1)
					redBtnClickable = true;


				} else {
					redDisCounter--;
					redButton.gotoAndStop(2)
				}
			}
			if (bluBtnClickable == false) {
				if (bluDisCounter == 0) {

					bluButton.gotoAndStop(1)
					bluBtnClickable = true;
				} else {
					bluDisCounter--;
					bluButton.gotoAndStop(2)
				}
			}



		}
	}
}