package{
	
	import flash.display.*;	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	public class DecorN1 extends MovieClip{
		
		public var carteNiveau:Array=new Array;
		
		public var conteneur:Sprite=new Sprite;
		public var dossier:String;
		public var fichier:String;
		
		
		private var premiere_ligne:Number=0;
		private var premiere_colonne:Number=0;
		private var derniere_ligne:Number=0;
		private var derniere_colonne:Number=0;
		private var carte_ligne:Number=0;
		private var carte_colonne:Number=0;
		
		public var carte_ligne_depart:Number=0 ;
		public var carte_colonne_depart:Number=0 ;
		
		private var decalage_Fond_x:int=0;
		private var decalage_Fond_y:int=0;
		private var briqueL:int=64;
		private var briqueH:int=64;
		private var nbCol:int=21;
		private var nbLign:int=14;
		public var vitesseDG:int;
		public var vitesseHB:int;
		
		public var tableauSon:Array=[[false,false,false,false,false,false,false],
									[false,false,false,false,false,false,false],
									[false,false,false,false,false,false,false],
									[false,false,false,false,false,false,false],
									[false,false,false,false,false,false,false]];
		public var nC:int=0;
		public var sonsZone:int=0;
		public var volumeSon:int=0;
		public var mesCases:Cases=new Cases;
		
		public dynamic function DecorN1 (pCarte:Array,pcarte_ligne_depart,pcarte_colonne_depart){
			
			carteNiveau=pCarte;
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart; 
			
			tableauSon=[[false,false,false,false,false,false,false],
						[false,false,false,false,false,false,false],
						[false,false,false,false,false,false,false],
						[false,false,false,false,false,false,false],
						[false,false,false,false,false,false,false]];
			
			creerNiveau();
			
			addChild(conteneur);
			
		}
		private function creerNiveau(){
			for(var L:Number=0;L<nbLign;L++){
				for(var C:Number=0;C<nbCol;C++){
					var brique:LibraryN1=new LibraryN1();
					
					brique.name="brique_"+L+"_"+C;
					brique.x=(briqueL*C)-briqueL*3;
					brique.y=(briqueH*L)-briqueH;
					brique.gotoAndStop(carteNiveau[L+carte_ligne_depart][C+carte_colonne_depart-2]);
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
					
				if (decalage_Fond_x<-(briqueL-1)){deplace_fond_gauche();decalage_Fond_x=0;}
				if (decalage_Fond_x>(briqueL-1)){deplace_fond_droite();decalage_Fond_x=0;}
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
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne+n+carte_ligne_depart)][(carte_colonne-1+carte_colonne_depart-2)]);
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
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne+n+carte_ligne_depart)][(carte_colonne+nbCol+carte_colonne_depart-2)]);

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
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne-1+carte_ligne_depart)][(carte_colonne+n+carte_colonne_depart-2)]);
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
   					MovieClip(conteneur.getChildByName(brique)).gotoAndStop(carteNiveau[(carte_ligne+nbLign+carte_ligne_depart)][(carte_colonne+n+carte_colonne_depart-2)]);
   					colonne+=1;
				}
				if(premiere_ligne==nbLign-1){premiere_ligne=0;}
				else {premiere_ligne=premiere_ligne+1;}

				carte_ligne+=1;
				
			}
		
		public function testerSons(){
			var nb:int=0;
				for (var L:int=0; L<5; L++) {
					for (var C:int=0; C<7; C++) {nC++;
						if ((tester_case(carte_ligne+(carte_ligne_depart+6)+L,carte_colonne+(carte_colonne_depart-2+5)+C)==400)){
							tableauSon[L][C]=true;nb--;
						}else{
							tableauSon[L][C]=false;nb++;
						}
					}
				}
				if(nC>34){
					if(nb==35){sonsZone=0;}else{sonsZone=1;}
					nC=0;
				}
				if(tableauSon[2][3]==true){
					volumeSon=4;
				}else{
					if(tableauSon[1][2]==true||tableauSon[1][3]==true||tableauSon[1][4]==true||
						tableauSon[2][2]==true||tableauSon[2][4]==true||
						tableauSon[3][2]==true||tableauSon[3][3]==true||tableauSon[3][4]==true){
						volumeSon=3;
					}else{
						if(tableauSon[0][1]==true||tableauSon[0][2]==true||tableauSon[0][3]==true||tableauSon[0][4]==true||tableauSon[0][5]==true||
							tableauSon[1][1]==true||tableauSon[1][5]==true||
							tableauSon[2][1]==true||tableauSon[2][5]==true||
							tableauSon[3][1]==true||tableauSon[3][5]==true||
							tableauSon[4][1]==true||tableauSon[4][2]==true||tableauSon[4][3]==true||tableauSon[4][4]==true||tableauSon[4][5]==true){
							volumeSon=2;
						}else{
							if(tableauSon[0][0]==true||tableauSon[0][6]==true||
								tableauSon[1][0]==true||tableauSon[1][6]==true||
								tableauSon[2][0]==true||tableauSon[2][6]==true||
								tableauSon[3][0]==true||tableauSon[3][6]==true||
								tableauSon[4][0]==true||tableauSon[4][6]==true){
								volumeSon=1;
							}else{
								volumeSon=0;
							}
						}
					}
				}
		}
		public function tester_case(ligne:int,colonne:int):int{
			var pligne:int=ligne;
			var pcolonne:int=colonne;
			var control:int;
			var decorControl:int=mesCases.tester_case(pligne,pcolonne+2,carteNiveau);
			control=decorControl;
			return(control);
		}
	}
}