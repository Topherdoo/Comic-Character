package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;



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



		}

		//Creates an image copy
		private function BirthTrans(): void {
			transImage = CurrentPanel;
			addChild(transImage);

		}

		//Adds children MCs
		public function BirthMC(): void {
			
			//KillPanel();
			
			movieClipHolder.push(CurrentMC);
			addChild(CurrentMC);
			CurrentMC.gotoAndPlay(playFrame);
			//			
		}

		//Use this for sizing if your panel fits in the frame
		private function DefaultMCValues(): void {
			CurrentMC.x = 14;
			CurrentMC.y = 14;
			CurrentMC.height = 900;
			CurrentMC.width = 690;
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
			transitionScaleX = ((690) - (CurrentPanel.width)) / transitionTime;
			transitionScaleY = ((900) - (CurrentPanel.height)) / transitionTime;
			transitionPosX = ((previousPosX) - (20)) / transitionTime;
			transitionPosY = ((previousPosY) - (20)) / transitionTime;
		}
		//Kill old panel, before assigning new one
		private function KillPanel(): void {
			removeChild(movieClipHolder[0]);
			movieClipHolder.length = 0;
			newPanel = true;
		}
		
		private function DefaulltMask():void{
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
		}

		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		//Cases for red button, then blue button

		public function redClick(e: MouseEvent) {
			trace("RED");
			if (redBtnClickable == true) {
				switch (caseNumber) {

					case 11:
						// first panel code
						CurrentPanel = panel11;
						NextPanel = panel12;
						BirthTrans();
						scaleMath();
						nextCase = 11.5;
						transitioningUp = true;
						playFrame = 1;
						BtnDiscounter(0, false);
						newPanel = true;


						CurrentMC = new TestPanel();
						//newPanel = true;
						CurrentMC.height *= 0.45;
						CurrentMC.width *= 0.6;
						CurrentMC.x = 50
						break;

					case 11.5:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel13;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 12
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(24, false);
						KillPanel();
						newPanel = true;
						CurrentMC = new TestPanel2();
						//use newPanel = true,whenever you need to make a new panel
						

						//set these values to make your panel fit. 
						CurrentMC.y = -80;
						CurrentMC.x = 100;
						CurrentMC.height *= .65;
						CurrentMC.width *= .65;



						break;

					
					case 12:
						NextPanel = panel14;
						transitioningDown = true;
						nextCase = 13.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 12.5:
						NextPanel = panel14;
						transitioningDown = true;
						nextCase = 13;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 13:
						NextPanel = panel15;
						transitioningDown = true;
						nextCase = 14;
						KillPanel();
						newPanel = true;
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 13.5:
						NextPanel = panel21;
						transitioningDown = true;
						nextCase = 21;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 14:
						NextPanel = panel21;
						transitioningDown = true;
						nextCase = 21;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						boolPage1 = false;
						break;
					
					//2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
					case 21:
						NextPanel = panel22;
						transitioningDown = true;

						nextCase = 22;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 22:
						NextPanel = panel23;
						transitioningDown = true;
						nextCase = 23;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;
					
					case 22.5:
						NextPanel = panel23;
						transitioningDown = true;
						nextCase = 24;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 23:
						NextPanel = panel25;
						transitioningDown = true;
						nextCase = 24;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 23.5:
						NextPanel = panel25;
						transitioningDown = true;
						nextCase = 21;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 24:
						NextPanel = panel41;
						transitioningDown = true;
						nextCase = 41;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage2 = false;
						//statements;
						break;
					//33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
					
					case 31:
						
						NextPanel = panel32;	
						
						nextCase = 32;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(254, false);

						
						CurrentMC= new WholeScene2();
						newPanel = true;
						KillPanel();
						CurrentMC.height*=0.45;
						CurrentMC.width*=0.6;
						CurrentMC.x = 50
						break;

					case 32:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel33;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 32.5;
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(53, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new WholeScene3();
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;
						CurrentMC.y = -80;
						CurrentMC.x = 100;
						CurrentMC.height *=.65;
						CurrentMC.width *=.65;
						


						break;

					case 32.5:
						//NextPanel = testPanel4;
						//transitioningDown = true;
						nextCase = 34.5
						transitioningDown = true;
						BtnDiscounter(24, false);
						
						playFrame = 77;
						movieClipHolder.gotoAndPlay(78);
						BtnDiscounter(54, false);
						//KillPanel();
						//CurrentMC = new WholeScene3();
						
						CurrentMC.height *=.9;
						CurrentMC.width *=.9;
						//statements;
						break;
					
					case 33:
						NextPanel = panel35;
						transitioningDown = true;
						nextCase = 34.5
						newPanel = true;
						KillPanel();
						CurrentMC = new WholeScene4();
						BtnDiscounter(24, false);
						playFrame = 5;
						//statements;
						break;
					
					case 34:
						NextPanel = panel34;
						transitioningDown = true;
						nextCase = 365
						newPanel = true;
						KillPanel();
						CurrentMC = new WholeScene4();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;
					
					case 34.5:
						NextPanel = panel41;
						transitioningDown = true;
						nextCase = 41;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage3 = false;
						
						//statements;
						break;
					
										//444444444444444444444444444444444444444444444444444444444444444444444444444444444
					case 41:
						NextPanel = panel42;
						transitioningDown = true;
						nextCase = 42.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 42:
						NextPanel = panel44;
						transitioningDown = true;
						nextCase = 43.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;
					case 42.5:
						NextPanel = panel44;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 43:
						NextPanel = panel46;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 43.5:
						NextPanel = panel46;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 44:
						NextPanel = panel51;
						transitioningDown = true;
						nextCase = 11;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage2 = false;
						boolPage3 = false;
						boolPage4 = false;
						//statements;
						break;
					
					///555555555555555555555555555555555555555555555555555555555555555555555555
					case 51:
						NextPanel = panel52;
						transitioningDown = true;
						nextCase = 52.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 52:
						NextPanel = panel54;
						transitioningDown = true;
						nextCase = 53.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;
						case 52.5:
						NextPanel = panel54;
						transitioningDown = true;
						nextCase = 54;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 53:
						NextPanel = panel56;
						transitioningDown = true;
						nextCase = 54;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 53.5:
						NextPanel = panel56;
						transitioningDown = true;
						nextCase = 54;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 54:
						NextPanel = panel11;
						transitioningDown = true;
						nextCase = 11;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage2 = false;
						boolPage3 = false;
						boolPage4 = false;
						//statements;
						break;
					
					////////////////////////////////////////////////////////////////////////////
				}
			}

		}

		private function bluClick(e: MouseEvent) {
			trace("blu");
			if (bluBtnClickable == true) {
				switch (caseNumber) {

					case 11:
						// first panel code
						CurrentPanel = panel11;
						NextPanel = panel12;
						BirthTrans();
						scaleMath();
						nextCase = 11.5;
						transitioningUp = true;
						playFrame = 1;
						
						CurrentMC = new WholeScene3();
						BtnDiscounter(0, false);


						CurrentMC = new TestPanel();
						newPanel = true;
						CurrentMC.height *= 0.45;
						CurrentMC.width *= 0.6;
						CurrentMC.x = 50
						break;

					case 11.5:
						//Next Panel sets up the next panel, when transition down is set to true the code will take us to the NextPanel and the NextPanel becomes the CurrentPanel
						NextPanel = panel13;
						transitioningDown = true;
						//nextCase gets set to caseNumber for the switch statement.
						nextCase = 12;
						//selects which frame to play, assuming the first frame is set to stop()
						playFrame = 1;
						//disables the button for a number of frames.  Insert the number of frames of the animation, and false to disable both buttons.  Can also enable the buttons if you put (0, true) for the parenthesis
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						
						CurrentMC = new TestPanel2();
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;

						//set these values to make your panel fit. 
						CurrentMC.y = -80;
						CurrentMC.x = 100;
						CurrentMC.height *= .65;
						CurrentMC.width *= .65;



						break;

					case 12:
						NextPanel = panel14;
						transitioningDown = true;
						nextCase = 13.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 12.5:
						NextPanel = panel16;
						transitioningDown = true;
						nextCase = 13.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 13:
						NextPanel = panel16;
						transitioningDown = true;
						nextCase = 14.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 13.5:
						NextPanel = panel31;
						transitioningDown = true;
						nextCase = 31;
						newPanel = true;
						KillPanel();

						CurrentMC = new WholeScene1();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;
					case 14:
						NextPanel = panel21;
						transitioningDown = true;
						nextCase = 31;
						newPanel = true;
						KillPanel();

						CurrentMC = new WholeScene1();
						BtnDiscounter(24, false);
						playFrame = 2;
						//CurrentMC.height *= .25;
						//CurrentMC.width *= .25;

						boolPage1 = false;
						boolPage2 = false;
						//statements;
						break;
					//222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
					case 21:
						NextPanel = panel22;
						transitioningDown = true;
						nextCase = 22.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 22:
						NextPanel = panel24;
						transitioningDown = true;
						nextCase = 23.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;
					case 22.5:
						NextPanel = panel24;
						transitioningDown = true;
						nextCase = 24;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 23:
						NextPanel = panel26;
						transitioningDown = true;
						nextCase = 24;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 23.5:
						NextPanel = panel26;
						transitioningDown = true;
						nextCase = 24;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 24:
						NextPanel = panel51;
						transitioningDown = true;
						nextCase = 51;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage2 = false;
						boolPage3 = false;
						boolPage4 = false;
						//statements;
						break;
					
					//33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
					
					case 31:
						
						NextPanel = panel32;	
						
						nextCase = 32;
						transitioningDown = true;
						playFrame = 1;
						BtnDiscounter(254, false);

						
						CurrentMC= new WholeScene2();
						newPanel = true;
						KillPanel();
						CurrentMC.height*=0.72;
						CurrentMC.width*=0.72;
						CurrentMC.x = 50
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
						
						
						//use newPanel = true,whenever you need to make a new panel
						newPanel = true;
						
						KillPanel();
						CurrentMC = new WholeScene3();
						CurrentMC.y = -80;
						CurrentMC.x = 100;
						//CurrentMC.height *=.8
						//CurrentMC.width *=.8;
						


						break;

					//case 32.5:
					//	//NextPanel = testPanel4;
					//	//transitioningDown = true;
					//	nextCase = 34.5
					//	
					//	BtnDiscounter(24, false);
					//	
					//	playFrame = 77;
					//	//movieClipHolder.gotoAndPlay(78);
					//	BtnDiscounter(54, false);
					//	//KillPanel();
					//	//CurrentMC = new WholeScene3();
					//	
					//	CurrentMC.height *=.9;
					//	CurrentMC.width *=.9;
					//	//statements;
					//	break;
					
					case 33:
						NextPanel = panel35;
						transitioningDown = true;
						nextCase = 34.5
						newPanel = true;
						
						KillPanel();
						CurrentMC = new WholeScene4();
						BtnDiscounter(24, false);
						playFrame = 77;
						CurrentMC.x = 50
						//statements;
						break;
					
					case 34:
						NextPanel = panel34;
						transitioningDown = true;
						nextCase = 34.5
						newPanel = true;
						
						KillPanel();
						CurrentMC = new WholeScene3();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;
					
					case 34.5:
						NextPanel = panel51;
						transitioningDown = true;
						nextCase = 51;
						newPanel = true;
						
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						boolPage3 = false;
						boolPage4 = false;
						break;
					//444444444444444444444444444444444444444444444444444444444444444444444444444444444
					case 41:
						NextPanel = panel42;
						transitioningDown = true;
						nextCase = 42.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 42:
						NextPanel = panel44;
						transitioningDown = true;
						nextCase = 43.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;
					case 42.5:
						NextPanel = panel44;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 43:
						NextPanel = panel46;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 43.5:
						NextPanel = panel46;
						transitioningDown = true;
						nextCase = 44;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 44:
						NextPanel = panel51;
						transitioningDown = true;
						nextCase = 11;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage2 = false;
						boolPage3 = false;
						boolPage4 = false;
						//statements;
						break;
					
					///555555555555555555555555555555555555555555555555555555555555555555555555
					case 51:
						NextPanel = panel52;
						transitioningDown = true;
						nextCase = 52.5;

						playFrame = 1;
						BtnDiscounter(24, false);
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();

						CurrentMC.height *= .9;
						CurrentMC.width *= .9;
						//statements;
						break;

					case 52:
						NextPanel = panel54;
						transitioningDown = true;
						nextCase = 53.5;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;
					case 52.5:
						NextPanel = panel54;
						transitioningDown = true;
						nextCase = 54;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel2();
						BtnDiscounter(24, false);
						playFrame = 1;
						//statements;
						break;

					case 53:
						NextPanel = panel56;
						transitioningDown = true;
						nextCase = 54;
						newPanel = true;
						KillPanel();
						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						//statements;
						break;

					case 53.5:
						NextPanel = panel56;
						transitioningDown = true;
						nextCase = 54;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage1 = false;
						//statements;
						break;
					case 54:
						NextPanel = panel11;
						transitioningDown = true;
						nextCase = 11;
						newPanel = true;
						KillPanel();

						CurrentMC = new TestPanel();
						BtnDiscounter(24, false);
						playFrame = 2;
						boolPage2 = false;
						boolPage3 = false;
						boolPage4 = false;
						//statements;
						break;
					
					////////////////////////////////////////////////////////////////////////////
				}

			}



		}
		private function update(e: Event): void {
			trace(movieClipHolder.length);
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
					CurrentPanel = NextPanel
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