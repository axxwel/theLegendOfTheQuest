package{
	import flash.display.*
	
	public class Horizon extends MovieClip{
		
		public var monImageHorizon:imageHorizon=new imageHorizon();
		public var controlesD:Array=new Array;
		public var conteneur:Sprite=new Sprite;
		public var numeroHorizon:int;
		
		public dynamic function Horizon (pnumeroHorizon:int){
			
			monImageHorizon.width=1920;
			monImageHorizon.height=1280;
			monImageHorizon.x=-256;
			monImageHorizon.y=-256;
			numeroHorizon=pnumeroHorizon;
			monImageHorizon.gotoAndStop(numeroHorizon);
		
			conteneur.addChild(monImageHorizon);
			addChild(conteneur);
		}
	}
}