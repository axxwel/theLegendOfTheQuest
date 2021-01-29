package{

	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Pad {
		public var sens:int=0;
		public var saut:int=0;
		public var hautBas:int=0;
		public var atack:int=0;
		public var inventaire:int=0;
		public var test:int=0;
		public var mouse:Boolean=false;
		
		private var right:Boolean=false;
		private var left:Boolean=false;
		private var up:Boolean=false;
		private var down:Boolean=false;
		private var space:Boolean=false;
		private var fight:Boolean=false;
		private var toucheX:Boolean=false;
		private var testT:Boolean=false;
		
		private var menu:Boolean=false;
	
		public var retourTouches:Array=new Array(0,0,0,0);
		public var blockPad:Boolean=false;
		public var blockTouche:Array=[false];
		public var controlsens:int=0;
		public var controlsaut:int=0;
		public var controlhautBas:int=0;
		public var controlatack:int=0;
		public var controlinventaire:int=0;
		public var controlPad=false;
		
		public dynamic function Pad():void {
			
		}
		public function appuie(evt){
			switch(evt.keyCode){
				case Keyboard.RIGHT: right=true;break;
				case 68: right=true;break;
				
				case Keyboard.LEFT: left=true;break;
				case 81: left=true;break;
				
				case Keyboard.UP: up=true;break;
				case 90: up=true;break;
				
				case Keyboard.DOWN: down=true;break;
				case 83: down=true;break;
				
				case Keyboard.SPACE: space=true;break;
				
				case 191: fight=true;break;
				case 17: fight=true;break;
				
				case 27: menu=true;break;
				
				case 96: toucheX=true;break;
				case 88: toucheX=true;break;
				
				case 103: testT=true;break; 
				
				default:break;
			}
		}
		public function relache(evt){
			switch(evt.keyCode){
				case Keyboard.RIGHT: right=false;break;
				case 68: right=false;break;
				
				case Keyboard.LEFT: left=false;break;
				case 81: left=false;break;
				
				case Keyboard.UP: up=false;break;
				case 90: up=false;break;
				
				case Keyboard.DOWN: down=false;break;
				case 83: down=false;break;
				
				case Keyboard.SPACE: space=false;break;
				
				case 191: fight=false;break;
				case 17: fight=false;break;
				
				case 27: menu=false;break;
				
				case 96: toucheX=false;break;
				case 88: toucheX=false;break; 
				
				case 103: testT=false;break; 
				default:break;
			}
			
		}
		public function souris(pmouseX:int,pmouseY:int):Boolean{
			//if(pmouseX>900||pmouseX<60||pmouseY>600||pmouseY<40){mouse=false}else{mouse=true}
			mouse=true;
			return (mouse);
		}
		public dynamic function touches():Array{			
			if(blockPad==true&&controlPad==false){
				sens=0;saut=0;hautBas=0;atack=0;
			}
			if(controlPad==true&&blockPad==false){
				sens=controlsens;
				saut=controlsaut;
				hautBas=controlhautBas;
				atack=controlatack;
				inventaire=controlinventaire;
			}
			if(blockPad==false&&controlPad==false){
				
				if(right==false&&left==false){sens=0;}
				if(right==true&&left==false){sens=1;}
				if(left==true&&right==false){sens=-1;}
				
				if(up==false&&down==false){hautBas=0;}
				if(up==true&&down==false){hautBas=1;}
				if(down==true&&up==false){hautBas=-1;}
				
				if(space==true){saut=1;}
				if(space==false){saut=0;}
				
				if(fight==true){atack=1;}
				if(fight==false){atack=0;}
				
				if(toucheX==true){inventaire=1;}
				if(toucheX==false){inventaire=0;}
			}
			if(testT==true){test=1;}
			if(testT==false){test=0;}
			
			retourTouches[0]=sens;
			retourTouches[1]=saut;
			retourTouches[3]=hautBas;
			retourTouches[4]=atack;		
			retourTouches[5]=inventaire;
			retourTouches[10]=test;
			
			if(blockTouche[0]==true){
				for(var i:int=0;i<blockTouche.length;i++){
					if(blockTouche[i]>=0){retourTouches[blockTouche[i]]=0;}
				}
			}
			return (retourTouches);
			controlPad=false;
		}
		public dynamic function echap():Boolean{
			var control:Boolean=false;
			if(menu==true){control=true}
			if(menu==false){control=false}
			return (control);
		}
		public dynamic function control(psens:int=0,psaut:int=0,phautBas:int=0,patack:int=0,pinventaire:int=0){
			controlPad=true;
			controlsens=psens;
			controlsaut=psaut;
			controlhautBas=phautBas;
			controlatack=patack;
			controlinventaire=pinventaire;
			
		}
		public dynamic function unControl(){
			controlsens=0;
			controlsaut=0;
			controlhautBas=0;
			controlatack=0;
			controlinventaire=0;
			controlPad=false;
		}
		public dynamic function blockToucheNum(toucheN1:int=-1,toucheN2:int=-1,toucheN3:int=-1){
			blockTouche[0]=true;
			blockTouche[1]=toucheN1;
			blockTouche[2]=toucheN2;
			blockTouche[3]=toucheN3;
		}
		public dynamic function deblockToucheNum(){blockTouche=[false];}
		public dynamic function block(){blockPad=true;}
		public dynamic function deblock(){blockPad=false;}
	}
}