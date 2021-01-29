package{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.*;
	
	public class Projectiles extends MovieClip{
		
		public var cartes:Array=new Array();
		public var carte_ligne_depart:Number=0;
		public var carte_colonne_depart:Number=0;
		public var positionDecor:Array=new Array();
		
		public var mesCases:Cases=new Cases;
		
		public var projectileSens:int=0;
		
		public var conteneurProjectiles:MovieClip=new MovieClip();
		public var liste_projectiles:Array=new Array();
		public var numero_projectile:int=0;
		
		public var hauteur:int=0;
		public var longueur:int=0;
		public var positionX:int=0;
		public var positionY:int=0;
		public var projectileActif:Boolean=false;
		
		public var toucheMonstre:Boolean=false;
		
		public function Projectiles():void{
			addChild(conteneurProjectiles);
		}
		public function creer(pforceLance:int=0){
			var forceLance:int=pforceLance*20;
			var projectileTemp:Fleche=new Fleche;
			
			hauteur=projectileTemp.width;
			longueur=projectileTemp.height;
			projectileTemp.name="Projectile"+numero_projectile;
			projectileTemp.scaleX=projectileSens;
			projectileTemp.x=-conteneurProjectiles.x;
			projectileTemp.y=-conteneurProjectiles.y;
			
			conteneurProjectiles.addChild(projectileTemp);
			var arrayTemp:Array=[numero_projectile,projectileSens,forceLance];
			liste_projectiles.push(arrayTemp);
			numero_projectile+=1;
			projectileActif=true;
		}
		public function deplacerDecor(){
			conteneurProjectiles.x=positionDecor[0];
			conteneurProjectiles.y=positionDecor[1];
		}
		public function deplacer(){
			var vitesseProjectile:Number=16;
			var force:Number=0;
			var nom:String="";
			var caseX:int=0;
			var caseY:int=0;
			for ( var n:Number=0;n<liste_projectiles.length;n++){
				nom="Projectile"+liste_projectiles[n][0];
				caseX=(conteneurProjectiles.getChildByName(nom).x+conteneurProjectiles.getChildByName(nom).width/2)/64+carte_colonne_depart+8+projectileSens;
				caseY=(conteneurProjectiles.getChildByName(nom).y)/64+carte_ligne_depart+8;
				
				if (tester_case(caseY,caseX)!=2&&toucheMonstre==false){
					if((liste_projectiles[n][2])>0){
						conteneurProjectiles.getChildByName(nom).x+=vitesseProjectile*projectileSens;
						
						liste_projectiles[n][2]-=vitesseProjectile/2;
						positionX=conteneurProjectiles.getChildByName(nom).x+positionDecor[0];
						positionY=conteneurProjectiles.getChildByName(nom).y+positionDecor[1];
						projectileActif=true;
						if((liste_projectiles[n][2])<50){projectileActif=false;
							conteneurProjectiles.getChildByName(nom).y+=vitesseProjectile;
							conteneurProjectiles.getChildByName(nom).rotation+=(vitesseProjectile/2)*projectileSens;
						}
					}else{
						liste_projectiles.splice(n,1);conteneurProjectiles.removeChild(conteneurProjectiles.getChildByName(nom));
						positionX=0;
						positionY=0;
					}
				}else{
					projectileActif=false;
					conteneurProjectiles.getChildByName(nom).y+=vitesseProjectile;
					liste_projectiles[n][2]=0;
					liste_projectiles.splice(n,1);conteneurProjectiles.removeChild(conteneurProjectiles.getChildByName(nom));
					positionX=0;
					positionY=0;
				}
			}
		}
		public function suprimerTout(){
			while(conteneurProjectiles.numChildren>0){
				conteneurProjectiles.removeChildAt(0);
			}
		}
		
		public function tester_case(pligne:int=0,pcolonne:int=0):int{
			var control:int=0;
			var carteDecor:Array=cartes[0];
			var carteMonstres:Array=cartes[4];
			var carteItems:Array=cartes[5];
				
			var ligne:int=pligne;
			var colonne:int=pcolonne;
				
			var itemControl:int=mesCases.tester_case(pligne,pcolonne,carteItems);
			var monstreControl:int=mesCases.tester_case(pligne,pcolonne,carteMonstres);
			var decorControl:int=mesCases.tester_case(pligne,pcolonne,carteDecor);
				
			if(itemControl==110||itemControl==111){control=2;}else{control=decorControl;}
				
			return(control);
		}
	}
}