package{
	
	import flash.display.*;	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	public class DecorN2 extends MovieClip{
		
		public var carteNiveau:Array=new Array;
		
		public var conteneur:Sprite=new Sprite;
		public var dossier:String;
		public var fichier:String;
		
		
		private var premiere_ligne:Number=0;
		private var premiere_colonne:Number=0;
		private var derniere_ligne:Number=0;
		private var derniere_colonne:Number=0;
		
		public var carte_ligne_depart:Number=0;
		public var carte_colonne_depart:Number=0;
		
		public var decalage_Fond_x:int=0;
		public var decalage_Fond_y:int=0;
		
		private var carte_ligne:Number=0 ;
		private var carte_colonne:Number=0 ;
		
		private var briqueL:int=192;
		private var briqueH:int=128;
		private var nbCol:int=9;
		private var nbLign:int=8;
		public var vitesseDG:int=4;
		public var vitesseHB:int=4;
		
		public dynamic function DecorN2 (pCarte:Array,
										 pcarte_ligne_depart:int,pcarte_colonne_depart:int){
			carteNiveau=pCarte;
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart;			
			
			creerNiveau();
			
			addChild(conteneur);
			
		}
		private function creerNiveau(){
			for(var L:Number=0;L<nbLign;L++){
				for(var C:Number=0;C<nbCol;C++){
					var brique:LibraryN2=new LibraryN2();
					
					brique.name="brique_"+L+"_"+C;
					brique.x=(briqueL*C)-briqueL*2;
					brique.y=(briqueH*L)-briqueH;
					brique.gotoAndStop(carteNiveau[L+carte_ligne_depart][C+carte_colonne_depart-1]);
					
					conteneur.addChild(brique);
				}
			}
		}
		public function deplacer(controlesX:int,controlesY:int){
			
			var controlesD:Array=new Array;
			controlesD[0]=controlesX;
			controlesD[1]=controlesY;
			
			if(controlesD[0]!=0){
					
				conteneur.x+=controlesD[0]*vitesseDG;
				decalage_Fond_x+=controlesD[0]*vitesseDG;
					
				if (decalage_Fond_x<=-(briqueL-1)){deplace_fond_gauche();decalage_Fond_x=0;}
				if (decalage_Fond_x>=(briqueL-1)){deplace_fond_droite();decalage_Fond_x=0;}
			}
			if(controlesD[1]!=0){
					
				conteneur.y+=controlesD[1]*vitesseHB;
				decalage_Fond_y+=controlesD[1]*vitesseHB;

				if (decalage_Fond_y<-(briqueH-1)){deplace_fond_haut();decalage_Fond_y=0;}
				if (decalage_Fond_y>(briqueH-1)){deplace_fond_bas();decalage_Fond_y=0;}
			}
				
		}
		
		public function deplace_fond_droite () {
			
				if (premiere_colonne==0){derniere_colonne=nbCol-1;}
				else {derniere_colonne=premiere_colonne-1;}

				if (premiere_ligne==0){derniere_ligne=nbLign-1;}
				else {derniere_ligne=premiere_ligne-1;}

				var ligne:Number=premiere_ligne;
				var brique:String;
				var premiere_brique:String;

				for (var n:Number=0; n<nbLign; n++) {
   					if (ligne==nbLign){ligne=0;}
   					brique="brique_"+ligne+"_"+derniere_colonne;
   					premiere_brique="brique_"+ligne+"_"+premiere_colonne;
  					conteneur.getChildByName(brique).x=conteneur.getChildByName(premiere_brique).x-briqueL;
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne+n+carte_ligne_depart)][(carte_colonne-1+carte_colonne_depart-1)]);
   					ligne+=1;
				}

				if(premiere_colonne==0){premiere_colonne=nbCol-1;}
				else {premiere_colonne=premiere_colonne-1;}

				carte_colonne-=1;
				
				
			}

		public function deplace_fond_gauche () {

				if (premiere_colonne==0){derniere_colonne=nbCol-1;}
				else {derniere_colonne=premiere_colonne-1;}

				if (premiere_ligne==0){derniere_ligne=nbLign-1;}
				else {derniere_ligne=premiere_ligne-1;}

				var ligne:Number=premiere_ligne;
				var brique:String;
				var derniere_brique:String;

				for (var n:Number=0; n<nbLign; n++) {
   					if (ligne==nbLign){ligne=0;}
   					brique="brique_"+ligne+"_"+premiere_colonne;
   					derniere_brique="brique_"+premiere_ligne+"_"+derniere_colonne;
  				 	conteneur.getChildByName(brique).x=conteneur.getChildByName(derniere_brique).x+briqueL;	
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne+n+carte_ligne_depart)][(carte_colonne+nbCol+carte_colonne_depart-1)]);

   					ligne+=1;
				}

				if(premiere_colonne==nbCol-1){premiere_colonne=0;}
				else {premiere_colonne=premiere_colonne+1;}

				carte_colonne+=1;
				

			}
			
		public function deplace_fond_bas() {
								
				if (premiere_colonne==0){derniere_colonne=nbCol-1;}
				else {derniere_colonne=premiere_colonne-1;}

				if (premiere_ligne==0){derniere_ligne=nbLign-1;}
				else {derniere_ligne=premiere_ligne-1;}

				var colonne:Number=premiere_colonne;
				var brique:String;
				var premiere_brique:String;

				for (var n:Number=0; n<nbCol; n++) {
					if (colonne==nbCol){colonne=0;}
					brique="brique_"+derniere_ligne+"_"+colonne;
					premiere_brique="brique_"+premiere_ligne+"_"+premiere_colonne;
					conteneur.getChildByName(brique).y=conteneur.getChildByName(premiere_brique).y-briqueH;
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne-1+carte_ligne_depart)][(carte_colonne+n+carte_colonne_depart-1)]);
					colonne+=1;
				}

				if(premiere_ligne==0){premiere_ligne=nbLign-1;}
				else {premiere_ligne=premiere_ligne-1;}

				carte_ligne-=1;
				

			}

		public function deplace_fond_haut () {

				if (premiere_colonne==0){derniere_colonne=nbCol-1;}
				else {derniere_colonne=premiere_colonne-1;}

				if (premiere_ligne==0){derniere_ligne=nbLign-1;}
				else {derniere_ligne=premiere_ligne-1;}

				var colonne:Number=premiere_colonne;
				var brique:String;
				var derniere_brique:String;

				for (var n:Number=0; n<nbCol; n++) {
					if (colonne==nbCol){colonne=0;}
					brique="brique_"+premiere_ligne+"_"+colonne;
					derniere_brique="brique_"+derniere_ligne+"_"+premiere_colonne;
					conteneur.getChildByName(brique).y=conteneur.getChildByName(derniere_brique).y+briqueH;	
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne+nbLign+carte_ligne_depart)][(carte_colonne+n+carte_colonne_depart-1)]);
   					colonne+=1;
				}
				if(premiere_ligne==nbLign-1){premiere_ligne=0;}
				else {premiere_ligne=premiere_ligne+1;}

				carte_ligne+=1;
				
			}
	}
}