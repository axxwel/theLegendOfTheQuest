package{
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Mouse;
	
	public class MenuStart extends MovieClip{
		
		public var conteneur:Sprite=new Sprite;
		
		public var monFond:Fond=new Fond();
		public var departJeuTexte:DepartJeuTexte=new DepartJeuTexte();
		public var departJeuBoule:DepartJeuBoule=new DepartJeuBoule();
		public var boutonDepart:BoutonDepartJeu=new BoutonDepartJeu();
		
		public var menuIn:Boolean=true;
		public var menu:Boolean;
		
		public var appuie:Boolean=false;
		
		public var pauseJeu:Boolean=true;
		
		public function MenuStart(){
			conteneur.addChild(monFond);
			conteneur.addChild(departJeuTexte);
			conteneur.addChild(departJeuBoule);
			conteneur.addChild(boutonDepart);
			
			boutonDepart.alpha=0;
			monFond.gotoAndStop(1);
			departJeuBoule.gotoAndStop(1);
			addChild(conteneur);
			
			boutonDepart.addEventListener(MouseEvent.MOUSE_OVER,boutonOver);
			boutonDepart.addEventListener(MouseEvent.MOUSE_OUT,boutonOut);
			boutonDepart.addEventListener(MouseEvent.CLICK,boutonJouer);
		}
		public function boutonOver(evt:Event){departJeuBoule.gotoAndStop(2);}
		public function boutonOut(evt:Event){departJeuBoule.gotoAndStop(1);}
		public function boutonJouer(evt:Event){departJeuBoule.gotoAndStop(3);
			stage.dispatchEvent(new Event("clickBoutonStart"));
			removeChild(conteneur);
		}
	}
}