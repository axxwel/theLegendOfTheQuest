package{

	import flash.display.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.IOErrorEvent;
	import flash.events.*;
	import flash.utils.*;	
	
	public class Pnj extends MovieClip{
		public var alphaTest:int=0;
		
		public var carteDecor:Array=new Array();
		public var carte_ligne_depart:Number=0 ;
		public var carte_colonne_depart:Number=0 ;
		public var conteneurPNJ:Sprite=new Sprite();
		
		public var chargementTermine:Boolean=false;
		
		public var vitesseDG:int;
		public var vitesseHB:int;
		public var mesCases:Cases=new Cases;
		
		public var cartePnj:Array=new Array;
		public var dossier:String;
		public var fichier:String;
		
		public var chargeur:URLLoader;
		public var donnee_PNJ_XML:XML;
		
		public var proprietePNJ:Array=new Array;
		public var proprieteHeros:Array=new Array;
		
		public var monHerosHitTest:HitTestGros=new HitTestGros;
		
		public var blockHeros:Boolean=false;
		
		public var conteneurDial:Sprite=new Sprite();
		public var monDialogue:Dialogues=new Dialogues();
		public var dialoguesFin:Boolean=false;
		public var dialogueAutorise:Boolean=true;
		
		public var memoirePnj:Array=new Array();
		public var tableauMemoire:Array=new Array();
		
		public var dialogueDecor:int=-1;;
		
		public function Pnj(pnomMonde,pnomLieux:String,pCartes:Array,pcarte_ligne_depart:int,pcarte_colonne_depart:int,pListePnjXML:XML,ptype:String,pidType:int):void{
			
			carteDecor=pCartes[0];
			cartePnj=pCartes[5];
			dossier=pnomMonde;
			fichier=pnomLieux;
			donnee_PNJ_XML=pListePnjXML;
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart;
			if(ptype=="dial"){dialogueDecor=pidType;}else{dialogueDecor=-1;}
			
			monHerosHitTest.alpha=0;
			monHerosHitTest.x=460;
			monHerosHitTest.y=465;
			
			addChild(monHerosHitTest);
			addChild(conteneurPNJ);
			
			monDialogue.name="Dial";
			conteneurDial.addChild(monDialogue);
			
		}
		public function startPnj(){creerPropriete_Pnj();}
		public function creerPropriete_Pnj():void{
			var proprietePNJ_temp:Array=new Array;
			var n:int=0;
			for(var L:Number=0;L<cartePnj.length;L++){
				for(var C:Number=0;C<cartePnj[L].length;C++){
					if(cartePnj[L][C]==682){proprietePNJ_temp[n]=[0,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(0),0,4,memoire(0)];n++}
					if(cartePnj[L][C]==683){proprietePNJ_temp[n]=[1,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(1),0,4,memoire(1)];n++}
					if(cartePnj[L][C]==684){proprietePNJ_temp[n]=[2,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(2),0,4,memoire(2)];n++}
					if(cartePnj[L][C]==685){proprietePNJ_temp[n]=[3,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(3),0,4,memoire(3)];n++}
					if(cartePnj[L][C]==686){proprietePNJ_temp[n]=[4,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(4),0,4,memoire(4)];n++}
					if(cartePnj[L][C]==687){proprietePNJ_temp[n]=[5,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(5),0,4,memoire(5)];n++}
					if(cartePnj[L][C]==688){proprietePNJ_temp[n]=[6,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(6),0,4,memoire(6)];n++}
					if(cartePnj[L][C]==689){proprietePNJ_temp[n]=[7,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(7),0,4,memoire(7)];n++}
					if(cartePnj[L][C]==690){proprietePNJ_temp[n]=[8,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(8),0,4,memoire(8)];n++}
					if(cartePnj[L][C]==691){proprietePNJ_temp[n]=[9,C*64-carte_colonne_depart*64-64,L*64-carte_ligne_depart*64-64,affichage(9),0,4,memoire(9)];n++}
					
				}
			}	
			proprietePNJ=proprietePNJ_temp;
			initialiserPNJ();
			chargementTermine=true;
		}
		public function initialiserPNJ(){
			
			for (var n:Number=0; n<proprietePNJ.length; n++){
				var PNJ_temp:MovieClip=new MovieClip;
				PNJ_temp.name="PNJ"+n;
				PNJ_temp.x=proprietePNJ[n][1];
				PNJ_temp.y=proprietePNJ[n][2];
				
				var testPNJtemp:HitTestPetit=new HitTestPetit();
				testPNJtemp.name="PNJtest"+n;
				
				testPNJtemp.x=proprietePNJ[n][1]+12;
				testPNJtemp.y=proprietePNJ[n][2]+12;
				
				testPNJtemp.alpha=alphaTest;
				
				var personage:MovieClip=new MovieClip;
				personage.name="perso";
				
				var pieds_temp:Mouvement_pieds=new Mouvement_pieds();
				pieds_temp.y=10;
				pieds_temp.name="pieds";
				pieds_temp.gotoAndStop(1);
				MovieClip(MovieClip(pieds_temp.getChildAt(0)).getChildAt(0)).gotoAndStop(proprietePNJ[n][3][0]);
				MovieClip(MovieClip(pieds_temp.getChildAt(0)).getChildAt(1)).gotoAndStop(proprietePNJ[n][3][0]);
				
				var habit_bas_temp:PNJdetails_habit_bas=new PNJdetails_habit_bas();
				habit_bas_temp.y=10;
				habit_bas_temp.name="habit_bas";
				habit_bas_temp.gotoAndStop(proprietePNJ[n][3][1]);
				
				var habit_haut_temp:PNJdetails_habit_haut=new PNJdetails_habit_haut();
				habit_haut_temp.y=10;
				habit_haut_temp.name="habit_haut";
				habit_haut_temp.gotoAndStop(proprietePNJ[n][3][2]);
				
				var habit_haut_details_temp:PNJdetails_habit_haut_details=new PNJdetails_habit_haut_details();
				habit_haut_details_temp.y=10;
				habit_haut_details_temp.name="habit_details_haut";
				habit_haut_details_temp.gotoAndStop(proprietePNJ[n][3][2]);
				
				var visage_temp:PNJdetails_visage=new PNJdetails_visage();
				visage_temp.y=-32;
				visage_temp.name="visage";
				visage_temp.gotoAndStop(proprietePNJ[n][3][3]);
				
				var oeil_temp:PNJdetails_oeil=new PNJdetails_oeil();
				oeil_temp.y=-32;
				oeil_temp.name="oeil";
				oeil_temp.gotoAndStop(proprietePNJ[n][3][4]);
				
				var casque_temp:PNJdetails_casque=new PNJdetails_casque();
				casque_temp.y=-32;
				casque_temp.name="casque";
				casque_temp.gotoAndStop(proprietePNJ[n][3][5]);
				
				var sourcil_temp:PNJdetails_sourcil=new PNJdetails_sourcil();
				sourcil_temp.y=-32;
				sourcil_temp.name="sourcil";
				sourcil_temp.gotoAndStop(proprietePNJ[n][3][6]);
				
				var main_temp:Poing=new Poing();
				main_temp.y=43;
				main_temp.x=16;
				main_temp.name="main";
				main_temp.gotoAndStop(1);
				
				var habit_bras_temp:Mouvement_bras=new Mouvement_bras();
				habit_bras_temp.x=12;
				habit_bras_temp.y=28;
				habit_bras_temp.name="habit_bras";
				habit_bras_temp.gotoAndStop(1);
				MovieClip(MovieClip(habit_bras_temp.getChildAt(0)).getChildAt(0)).gotoAndStop(proprietePNJ[n][3][8]);
				
				personage.addChild(pieds_temp);
				personage.addChild(habit_bas_temp);
				personage.addChild(habit_haut_temp);
				personage.addChild(habit_haut_details_temp);
				personage.addChild(visage_temp);
				personage.addChild(oeil_temp);
				personage.addChild(casque_temp);
				personage.addChild(sourcil_temp);
				personage.addChild(main_temp);
				personage.addChild(habit_bras_temp);
				
				PNJ_temp.addChild(personage);
				
				
				if(proprietePNJ[n][3][10]==0){
					if(PNJ_temp.x>460){personage.scaleX=-1;personage.x=64;}
					if(PNJ_temp.x<460){personage.scaleX=1;}
				}
				if(proprietePNJ[n][3][10]==-1){personage.scaleX=-1;personage.x=64}
				if(proprietePNJ[n][3][10]==1){personage.scaleX=1;}
				
				conteneurPNJ.addChild(testPNJtemp);conteneurPNJ.addChild(PNJ_temp);
			}
		}
		public function affichage(idPNJ:int):Array{
			var affichage_temp:Array=new Array;
			var pied:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@pied;
			var habit_bas:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@habit_bas;
			var habit_haut:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@habit_haut;
			var visage:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@visage;
			var oeil:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@oeil;
			var casque:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@casque;
			var sourcil:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@sourcil;
			var main:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@main;
			var habit_bras:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@habit_bras;
			var attitude:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@attitude;
			var sens:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@sens;
			var herosDemon:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).@heros_demon;
			
			affichage_temp[0]=pied+1;
			affichage_temp[1]=habit_bas+1;
			affichage_temp[2]=habit_haut+1;
			affichage_temp[3]=visage;
			affichage_temp[4]=oeil+1;
			affichage_temp[5]=casque+1;
			affichage_temp[6]=sourcil;
			affichage_temp[7]=main+1;
			affichage_temp[8]=habit_bras+1;
			affichage_temp[9]=attitude;
			affichage_temp[10]=sens;
			affichage_temp[100]=herosDemon;
			
			return(affichage_temp);
		}
		
		public function reflechir(n:int){
			var nomTest:String="PNJtest"+n;
			var nom:String="PNJ"+n;
			
			var caseTest:int=tester_case(carte_ligne_depart+2+conteneurPNJ.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurPNJ.getChildByName(nom).x/64);
		
			if (caseTest==600){
				proprietePNJ[n][4]=2;
				MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso").scaleX=-1;
				MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso").x=64;
			}
			if (caseTest==601){
				proprietePNJ[n][4]=1;
				MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso").scaleX=1;
				MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso").x=0;
			}
			if (caseTest==602){proprietePNJ[n][4]=3;}
			if (caseTest==603){proprietePNJ[n][4]=4;}
			
			if(donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==proprietePNJ[n][0]).secance.(@numero==proprietePNJ[n][6][1]).@block==1){
				conteneurPNJ.getChildByName(nomTest).x=proprietePNJ[n][1]-32;
				conteneurPNJ.getChildByName(nomTest).width=64;
				conteneurPNJ.getChildByName(nomTest).y=proprietePNJ[n][2]-108;
				conteneurPNJ.getChildByName(nomTest).height=128;
			}else{
				conteneurPNJ.getChildByName(nomTest).x=proprietePNJ[n][1]+12;
				conteneurPNJ.getChildByName(nomTest).width=20;
				conteneurPNJ.getChildByName(nomTest).y=proprietePNJ[n][2]+12;
				conteneurPNJ.getChildByName(nomTest).height=20;
			}
		}
		public function deplacer_Pnj(control:Array,controlesDecor:Array){
			for (var n:Number=0; n<proprietePNJ.length; n++){
				var nom:String="PNJ"+n;
				if((conteneurPNJ.getChildByName(nom).y%64==0)&&(conteneurPNJ.getChildByName(nom).x%64==0)){reflechir(n);}
				avancer_PNJ(n);
			}
			interagir_Pnj(control,controlesDecor);
			if(dialogueDecor>=0){dialogueStart(dialogueDecor);dialogueDecor=-1;}
		}
		public function interagir_Pnj(control:Array,controlDecor:Array){
			monHerosHitTest.alpha=alphaTest;
			monHerosHitTest.x=460+controlDecor[0]*vitesseDG;
			blockHeros=false;
			for (var n:Number=0; n<proprietePNJ.length; n++){
				var nomTest:String="PNJtest"+n;
				var nom:String="PNJ"+n;
				conteneurPNJ.getChildByName(nomTest).alpha=alphaTest;
				var type:int=proprietePNJ[n][0];
				var sens:int=0;
				var appuie:Boolean=false;
				var blockage:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==type).secance.(@numero==proprietePNJ[n][6][1]).@block;
				conteneurPNJ.getChildByName(nomTest).alpha=alphaTest;
				
				if((control[3]==true)&&dialogueAutorise==true){appuie=true;}
				if(control[3]==false){dialogueAutorise=true;}
				if(monHerosHitTest.hitTestObject(conteneurPNJ.getChildByName(nomTest))&&blockage==1){
					blockHeros=true;
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("habit_bras")).gotoAndStop(7);
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("main")).gotoAndStop(7);
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("visage")).gotoAndStop(4);
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("sourcil")).gotoAndStop(3);
				}else{
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("habit_bras")).gotoAndStop(1);
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("main")).gotoAndStop(1);
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("visage")).gotoAndStop(afficherAttitude(n)[0]);
					MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("sourcil")).gotoAndStop(afficherAttitude(n)[1]);
				}
				if(monHerosHitTest.hitTestObject(conteneurPNJ.getChildByName(nomTest))&&controlDecor[1]==2&&appuie==true){
					dialogueStart(n);
				}
			}
		}
		public function dialogueStart(n:int){
			dialogueAutorise=false;
			conteneurPNJ.alpha=0;
				
			monDialogue.donnee_PNJ_XML=donnee_PNJ_XML;
			monDialogue.proprieteHeros=proprieteHeros;
			monDialogue.proprietePNJ=proprietePNJ[n];
			monDialogue.fichier=fichier;
			monDialogue.numeroSecance=proprietePNJ[n][6][1];
			monDialogue.initialiserPNJ(proprietePNJ[n][0]);
			monDialogue.stopDial=false;
			addChild(conteneurDial);
				
			stage.dispatchEvent(new Event("DialogueStart"));
			dialoguesFin=false;
		}
		public function dialogues_PNJ(control:Array){
			monDialogue.run(control);
			if(monDialogue.stopDial==true){
				conteneurPNJ.alpha=1;removeChild(conteneurDial);dialoguesFin=true;
			}
			
			if(dialoguesFin==true){
				for(var n:int=0;n<monDialogue.tableauSecance.length;n++){
					var fPnj:String=monDialogue.tableauSecance[n][0];
					var nPnj:int=monDialogue.tableauSecance[n][1];
					var sPnj:int=monDialogue.tableauSecance[n][2];
					miseEnMemoire(fPnj,nPnj,sPnj);
				}
				stage.dispatchEvent(new Event("DialogueStop"));
			}
		}
		public function avancer_PNJ(n:Number){
			var nom:String="PNJ"+n;
			var nomTest:String="PNJtest"+n;
			
			var sens:Number=proprietePNJ[n][4];
			var vitesse:Number=proprietePNJ[n][5];
			MovieClip(MovieClip(MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("pieds")).getChildAt(0)).getChildAt(0)).gotoAndStop(proprietePNJ[n][3][0]);
			MovieClip(MovieClip(MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("pieds")).getChildAt(0)).getChildAt(1)).gotoAndStop(proprietePNJ[n][3][0]);
			MovieClip(MovieClip(MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("habit_bras")).getChildAt(0)).getChildAt(0)).gotoAndStop(proprietePNJ[n][3][8]);
			if(sens!=0){
				switch(sens){
					case 1:
						conteneurPNJ.getChildByName(nomTest).x+=vitesse;
						conteneurPNJ.getChildByName(nom).x+=vitesse;
						MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("pieds")).gotoAndStop(2);
						break;
					case 2:
						conteneurPNJ.getChildByName(nomTest).x-=vitesse;
						conteneurPNJ.getChildByName(nom).x-=vitesse;
						MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("pieds")).gotoAndStop(2);
						break;
					case 3:
						conteneurPNJ.getChildByName(nomTest).y-=vitesse;
						conteneurPNJ.getChildByName(nom).y-=vitesse;
					break;
					case 4:
					conteneurPNJ.getChildByName(nomTest).y+=vitesse;
						conteneurPNJ.getChildByName(nom).y+=vitesse;
					break;
				}
			}else{
				MovieClip(MovieClip(MovieClip(conteneurPNJ.getChildByName(nom)).getChildByName("perso")).getChildByName("pieds")).gotoAndStop(1);
			}
		}
		public function deplacer(controlesX:int,controlesY:int){
			
			var controlesD:Array=new Array;
			controlesD[0]=controlesX;
			controlesD[1]=controlesY;
			
			if(controlesD[0]!=0){
				conteneurPNJ.x+=controlesD[0]*vitesseDG;
			}
			if(controlesD[1]!=0){
				conteneurPNJ.y+=controlesD[1]*vitesseHB;
			}
		}
		public function afficherAttitude(n:int):Array{
			var sortie:Array=[1,1];
			var typeVisage:int=(proprietePNJ[n][3][3]-1)*4;
			var typeSourcil:int=(proprietePNJ[n][3][6]-1)*4;
			var attitude:int=proprietePNJ[n][3][9];
			var attVisage:int=Math.ceil(attitude/4)+1;
			var attSourcil:int=((attitude-1)-((attVisage-2)*4))+2;
			sortie[0]=attVisage+typeVisage;
			sortie[1]=attSourcil+typeSourcil;
			return(sortie);
		}
		public function tester_case(ligne:int,colonne:int):int{
			var pligne:int=ligne;
			var pcolonne:int=colonne;
			var control:int=mesCases.tester_case(pligne,pcolonne,cartePnj);
			return(control);
		}
		public function miseEnMemoire(fichierPnj:String,nPnj:int,nSecance:int){
			if(nSecance!=0){
				for(var n:int=0;n<memoirePnj.length;n++){
					if(memoirePnj[n][0]==dossier&&memoirePnj[n][1]==fichierPnj&&memoirePnj[n][2]=="Pnj"&&memoirePnj[n][3][0]==nPnj){
						memoirePnj.splice(n,1,[dossier,fichierPnj,"Pnj",[nPnj,nSecance]])
					}else{
						memoirePnj.push([dossier,fichierPnj,"Pnj",[nPnj,nSecance]]);
					}
				}
				if(memoirePnj.length==0){memoirePnj.push([dossier,fichier,"Pnj",[nPnj,nSecance]]);}
			}
			for (var nP:Number=0; nP<proprietePNJ.length; nP++){
				var type:int=proprietePNJ[nP][0];
				if(type==nPnj){proprietePNJ[nP][6]=memoire(nPnj);}
			}
		}
		public function memoire(nPnj:int):Array{
			var memoireTemp:Array=new Array;
			memoireTemp[0]=nPnj;
			
			for(var n:int=0;n<memoirePnj.length;n++){
				if(memoirePnj[n][0]==dossier&&memoirePnj[n][1]==fichier&&memoirePnj[n][2]=="Pnj"&&memoirePnj[n][3][0]==nPnj){
					memoireTemp[1]=memoirePnj[n][3][1];
				}else{memoireTemp[1]=0;}
				
			}
			if(memoirePnj.length==0){memoireTemp[1]=0;}
			
			
			return(memoireTemp);
		}
	}
}