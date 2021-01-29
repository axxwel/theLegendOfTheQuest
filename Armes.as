package{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.*;
	
	public class Armes extends MovieClip{
		
		public var herosSens:int=1;
		
		public var conteneurArmes:MovieClip=new MovieClip();
		
		public var herosArme0:MovieClip=new Poing();
		public var herosArme1:MovieClip=new Epee();
		public var herosArme2:MovieClip=new Arc();
		public var herosArme3:MovieClip=new Marteau();
		
		public var projectilesActif:Boolean=false;
		public var proprieteProjectile:Array=new Array();
		
		public var lanceAutorise:Boolean=true;
		
		public var bouclier:Boolean=false;
		
		public var forceFleche:int=0;
		
		public var armeUtilise:int=0;
		public var nouvelleArme:int=0;
		
		private var appuieTouche:Boolean=false;
		private var herosAtack:int=0;
		
		private var attack_effectue:Boolean;
		public var attack_time:int=0;
		private var attack_time_max:int=0;
		
		public var attack:int=0;
		public var frappe:Boolean=false;
		public var frappeForce:int=0;
		
		public function Armes():void{
			addChild(conteneurArmes);
			
			herosArme0.name="herosArme"+0;
			herosArme1.name="herosArme"+1;
			herosArme2.name="herosArme"+2;
			herosArme3.name="herosArme"+3;
			
			herosArme0.alpha=1;
			herosArme1.alpha=0;
			herosArme2.alpha=0;
			herosArme3.alpha=0;
			
			conteneurArmes.addChild(herosArme0);
			conteneurArmes.addChild(herosArme1);
			conteneurArmes.addChild(herosArme2);
			conteneurArmes.addChild(herosArme3);
		}
		public function changerArme(){
			if(armeUtilise!=nouvelleArme){
				MovieClip(conteneurArmes.getChildByName("herosArme"+nouvelleArme)).alpha=1;
				MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).alpha=0;
				armeUtilise=nouvelleArme;
			}
		}
//AFFICHAGE==========================================================================================================================================
		public function afficherArme(image:int,pattack:Boolean=false){
			attaque(pattack);
			changerArme();
			var nom:String="herosArme"+armeUtilise;
			switch(armeUtilise){
				case 0:
					bouclier=false;
					if(attack==0){MovieClip(conteneurArmes.getChildByName(nom)).gotoAndStop(image);}
				break;
				case 1:
					bouclier=false;
					if(attack==0){MovieClip(conteneurArmes.getChildByName(nom)).gotoAndStop(image);}
				break;
				case 2:
					bouclier=false;
					if(attack==0){MovieClip(conteneurArmes.getChildByName(nom)).gotoAndStop(image);}
				break;
				case 3:
					bouclier=false;
					if(attack==0){MovieClip(conteneurArmes.getChildByName(nom)).gotoAndStop(image);}
				break;
				default:
					bouclier=true;
				break;
			}
		}
//ATTAQUE===================================================================================================================================================
		public function attaque(pcontrol:Boolean){
			var control=pcontrol;
			projectilesActif=false;
			
			if(control==1){appuieTouche=true;}else{appuieTouche=false;}
			switch(armeUtilise){
	//POING================================================================================================================================
				case 0:
					attack_time_max=10;
					attackTiming(control);
					if(attack_time<=attack_time_max){
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=1;frappeForce=0;}
					}
					if(attack_time>attack_time_max){
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=0;attack_effectue=false;}
					}
					if(attack==1){MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(3);}
					if(attack==1&&attack_time>=6){frappe=true;}else{frappe=false;}
				break;
	//EPEE================================================================================================================================
				case 1:
					attack_time_max=10;
					attackTiming(control);
					if(attack_time<=attack_time_max){
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=1;frappeForce=0;}
					}
					if(attack_time>attack_time_max){
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=0;attack_effectue=false;}
					}
					if(attack==1){MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(3);}
					if(attack==1&&attack_time>=6){frappe=true;}else{frappe=false;}
				break;
	//ARC================================================================================================================================
				case 2:
					projectilesActif=true;
					var pfrappe:Boolean=false;
					attack_time_max=10;
					attackTiming(control);
					if(attack_time<=attack_time_max){//sort Fleche
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=1;MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(3);}
					}
					if(attack_time>attack_time_max){
						if(forceFleche<attack_time_max){forceFleche=attack_time-attack_time_max;}
						if(control==1){
							if(forceFleche<10){attack=2;MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(10);}
							else{attack=2;MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(11);}
						}else{
							MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(12);
							
							pfrappe=true;frappeForce=forceFleche;
							forceFleche=0;attack=0;
							attack_effectue=false;
						}
					}
					if(pfrappe==true){frappe=true;}else{frappe=false;}
				break;
	//MARTEAU================================================================================================================================
				case 3:
					attack_time_max=15;
					attackTiming(control);
					if(attack_time<=attack_time_max){
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=1;frappeForce=0;}
					}
					if(attack_time>attack_time_max){
						if(attack_effectue==false){attack=0;}
						if(attack_effectue==true){attack=0;attack_effectue=false;}
					}
					if(attack==1){MovieClip(conteneurArmes.getChildByName("herosArme"+armeUtilise)).gotoAndStop(3);}
					if(attack==1&&attack_time>=11){frappe=true;}else{frappe=false;}
				break;
			}
		}
//ATTACK TIME=================================================================================================================================================
		public function attackTiming(control:Boolean){
			if((control==1)&&(attack_effectue==false)){
				attack_effectue=true;
				attack_time+=1;
			}
			if((control==1)&&(attack_effectue==true)){
				attack_time+=1;
			}
			if((control==0)&&(attack_effectue==true)){
				attack_time+=1;
			}
			if((control==0)&&(attack_effectue==false)){
				attack_time=0;
			}
		}
//HIT TEST====================================================================================================================================================
		public function hitTestArme():Array{
			
			var retourArray:Array=new Array;
			var hitTestAttack:Boolean=false;
			var longueurArme:int=15;
			var hitTestScaleX:int=1;
			var hitTestScaleY:int=1;
			var hitTestX:int=460;
			var hitTestY:int=464+longueurArme;
			
			switch(armeUtilise){
				case 0:
					longueurArme=20;
					if(herosSens!=0){hitTestX=464+(longueurArme*herosSens);}
					hitTestY=484;
					if(frappe==true){hitTestAttack=true;}else{hitTestAttack=false;}
				break;
				case 1:
					longueurArme=47;
					if(herosSens!=0){hitTestX=464+(longueurArme*herosSens);}
					hitTestY=484;
					if(frappe==true){hitTestAttack=true;}else{hitTestAttack=false;}
				break;
				case 2:
					hitTestX=proprieteProjectile[1];
					hitTestY=proprieteProjectile[2];
					if(proprieteProjectile[0]==true){hitTestAttack=true;}else{hitTestAttack=false;}
				break;
				case 3:
					longueurArme=57;
					if(herosSens!=0){hitTestX=464+(longueurArme*herosSens);}
					hitTestY=484;
					if(frappe==true){hitTestAttack=true;}else{hitTestAttack=false;}
				break;
			}
			retourArray[0]=hitTestAttack;
			retourArray[1]=hitTestScaleX;
			retourArray[2]=hitTestScaleY;
			retourArray[3]=hitTestX;
			retourArray[4]=hitTestY;
			
			return(retourArray);
		}
	}
}









