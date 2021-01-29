package{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class JourNuit extends MovieClip{
		public var monCache:jourNuitCache=new jourNuitCache();
		public var maLumiere:jourNuitMask=new jourNuitMask();
		public var tempsAlpha:Number=1;	
		
		
		public var startM:Boolean=false;
		
		public var tempsJourEnSec:int=60;
		public var heures:int=0;
		public var minute:int=0;
		public var minuteur:Timer=new Timer(1000,60);
		public var coef:Number=1/120;
		
		public function JourNuit(){
			monCache.blendMode = BlendMode.LAYER;
			maLumiere.blendMode = BlendMode.ERASE;
			monCache.alpha=1;
			addChild(monCache);
			monCache.addChild(maLumiere);
			minuteur.addEventListener(TimerEvent.TIMER_COMPLETE,minuteurTopMinute);
			
		}
		private function minuteurTopMinute(evt:TimerEvent){
			minute+=1;
			if(minute==60){minute=0;heures+=1;}
			if(heures==24){heures=0;}
			if(heures>=4&&heures<6){tempsAlpha-=coef;}
			if(heures>=18&&heures<20){tempsAlpha+=coef;}
		}
		public function run(){
			if(startM==false){minuteur.start();startM=false;}
			
			monCache.alpha=tempsAlpha;
			trace(heures,minute,monCache.alpha);
			
		}
	}
	
}
		