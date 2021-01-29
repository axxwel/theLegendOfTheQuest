package{

	import flash.display.*;
	import flash.text.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Dialogues extends MovieClip{
		
		public var fichier:String;
		public var conteneur:Sprite=new Sprite;
		public var conteneurTexte:Sprite=new Sprite;
		
		public var numeroPNJ:int=0;	
		public var proprietePNJ:Array=new Array;	
		public var donnee_PNJ_XML:XML;
		public var tableau_texte:Array=new Array;
		
		public var tableauReponse:Array=[0,0,0,0];
		
		public var invtActif:Boolean=false;
		
		public var autoriseCurseur:Boolean=true;
		
		public var proprieteHeros:Array=new Array;
		
		public var miseEnFormeTexte:TextFormat=new TextFormat();
		
		public var texte:String="";
		public var texteAffiche:String="";
		
		private var timer:Timer=new Timer(30);
		private var timerFin:int=0;
		
		private var longueurTexte:int;
		private var nouveauTexte:Boolean=true;
		
		public var stopDial:Boolean=false;
		public var appuieStopDial:Boolean=false;
		public var appuieFinDial:Boolean=false;
		public var numeroDial:int=0;
		public var nombreDial:int=0;
		public var nombreDialAffiche:int=0;
		public var dialEfface:int=0;
		public var appuieSuivant:Boolean=false;
		public var appuieFin:Boolean=false;
		public var reponseVal:Boolean=true;
		public var finDial:Boolean=false;
		public var reponseChoisi:int=0;
		
		public var finAffiche:Boolean=true;
		public var memoireDial:Array=new Array;
		
		public var numeroSecance:int=0;
		public var tableauSecance:Array=new Array();
		
		public var forceSuivant:Boolean=false;
				
		public var id:int=0;
		public var idParle:int=0;
		public var attitudeH:int=0;
		public var attitudeP:int=0;
		public var attRep1:int=0;
		public var txtRep1:String="";
		public var attRep2:int=0;
		public var txtRep2:String="";
		public var itemsPNJ:Array=new Array;
		public var donneObjet:Boolean=false;
		public var demandeObjet:Boolean=false;
		public var magasinObjet:Boolean=false;
		public var magasinObjetVente:Boolean=false;
		public var tenueCheck:Boolean=false;
		public var tenueDemande:Array=new Array;
		public var porteChange:Array=[0,0];
		public var itemInit:Boolean=true;
		
		public var tableauSon:Array=[false,""];
		
		public function Dialogues():void{
			
			initialiserDial();
			miseEnFormeTexte.size=8;
			miseEnFormeTexte.font="Comic Sans MS";
			miseEnFormeTexte.color=0x000000;
			miseEnFormeTexte.bold=true;
			addChild(conteneur);
			addChild(conteneurTexte);
		}
		public function initialiserDial(){
			
			for (var n:Number=0; n<2; n++){
				var personage:MovieClip=new MovieClip;
				personage.name="perso"+n;
				
				var pieds_temp:Mouvement_pieds=new Mouvement_pieds();
				pieds_temp.y=10;
				pieds_temp.name="pieds";
				pieds_temp.gotoAndStop(1);
				MovieClip(MovieClip(pieds_temp.getChildAt(0)).getChildAt(0)).gotoAndStop(2);
				MovieClip(MovieClip(pieds_temp.getChildAt(0)).getChildAt(1)).gotoAndStop(2);
				
				var habit_bas_temp:PNJdetails_habit_bas=new PNJdetails_habit_bas();
				habit_bas_temp.y=10;
				habit_bas_temp.name="habit_bas";
				habit_bas_temp.gotoAndStop(2);
				
				var habit_haut_temp:PNJdetails_habit_haut=new PNJdetails_habit_haut();
				habit_haut_temp.y=10;
				habit_haut_temp.name="habit_haut";
				habit_haut_temp.gotoAndStop(2);
				
				var habit_haut_details_temp:PNJdetails_habit_haut_details=new PNJdetails_habit_haut_details();
				habit_haut_details_temp.y=10;
				habit_haut_details_temp.name="habit_details_haut";
				habit_haut_details_temp.gotoAndStop(2);
				
				var visage_temp:PNJdetails_visage=new PNJdetails_visage();
				visage_temp.y=-32;
				visage_temp.name="visage";
				visage_temp.gotoAndStop(5);
				
				var oeil_temp:PNJdetails_oeil=new PNJdetails_oeil();
				oeil_temp.y=-32;
				oeil_temp.name="oeil";
				oeil_temp.gotoAndStop(2);
				
				var casque_temp:PNJdetails_casque=new PNJdetails_casque();
				casque_temp.y=-32;
				casque_temp.name="casque";
				casque_temp.gotoAndStop(2);
				
				var sourcil_temp:PNJdetails_sourcil=new PNJdetails_sourcil();
				sourcil_temp.y=-32;
				sourcil_temp.name="sourcil";
				sourcil_temp.gotoAndStop(2);
				
				var main_temp:PNJdetails_main=new PNJdetails_main();
				main_temp.y=10;
				main_temp.name="main";
				main_temp.gotoAndStop(2);
				
				var habit_bras_temp:Mouvement_bras=new Mouvement_bras();
				habit_bras_temp.x=12;
				habit_bras_temp.y=28;
				habit_bras_temp.name="habit_bras";
				habit_bras_temp.gotoAndStop(1);
				MovieClip(MovieClip(habit_bras_temp.getChildAt(0)).getChildAt(0)).gotoAndStop(2);
				
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
				
				conteneur.addChild(personage);
				
			}
			conteneur.getChildByName("perso0").scaleX=1.25;
			conteneur.getChildByName("perso1").scaleX=-1.25;
			conteneur.getChildByName("perso0").scaleY=conteneur.getChildByName("perso1").scaleY=1.25;
			conteneur.getChildByName("perso0").x=372;
			conteneur.getChildByName("perso1").x=592;
			conteneur.getChildByName("perso1").y=conteneur.getChildByName("perso0").y=436;
			
		}
		public function initialiserPNJ(n:int){
			if(proprietePNJ[3][100]==1){
				MovieClip(conteneur.getChildByName("perso0")).alpha=0;
				ajouterDemon();
			}else{
				supprimerDemon();
				MovieClip(conteneur.getChildByName("perso0")).alpha=1;
				MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("habit_haut")).gotoAndStop(proprieteHeros[0]);
				MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("habit_details_haut")).gotoAndStop(proprieteHeros[0]);
				MovieClip(MovieClip(MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("habit_bras")).getChildAt(0)).getChildAt(0)).gotoAndStop(proprieteHeros[0]);
				MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("habit_bas")).gotoAndStop(proprieteHeros[1]);
				MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("pieds")).gotoAndStop(1);
				MovieClip(MovieClip(MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("pieds")).getChildAt(0)).getChildAt(0)).gotoAndStop(proprieteHeros[2]);
				MovieClip(MovieClip(MovieClip(MovieClip(conteneur.getChildByName("perso0")).getChildByName("pieds")).getChildAt(0)).getChildAt(1)).gotoAndStop(proprieteHeros[2]);
			}
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("pieds")).gotoAndStop(1);
			MovieClip(MovieClip(MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("pieds")).getChildAt(0)).getChildAt(0)).gotoAndStop(proprietePNJ[3][0]);
			MovieClip(MovieClip(MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("pieds")).getChildAt(0)).getChildAt(1)).gotoAndStop(proprietePNJ[3][0]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("habit_bas")).gotoAndStop(proprietePNJ[3][1]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("habit_haut")).gotoAndStop(proprietePNJ[3][2]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("habit_details_haut")).gotoAndStop(proprietePNJ[3][2]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("visage")).gotoAndStop(proprietePNJ[3][3]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("oeil")).gotoAndStop(proprietePNJ[3][4]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("casque")).gotoAndStop(proprietePNJ[3][5]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("sourcil")).gotoAndStop(proprietePNJ[3][6]);
			MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("main")).gotoAndStop(proprietePNJ[3][7]);
			MovieClip(MovieClip(MovieClip(MovieClip(conteneur.getChildByName("perso1")).getChildByName("habit_bras")).getChildAt(0)).getChildAt(0)).gotoAndStop(proprietePNJ[3][8]);
			
			numeroPNJ=n;
			nombreDial=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==n).secance.(@numero==numeroSecance).dialogue.length();
		}
		public function recupererTexte(idPNJ:int,idDial:int,idSecance:int){
			
			var idPersonage:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@personage;
			var attitudeHeros:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@attitude_heros;
			var attitudePersonage:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@attitude_perso;
			var textePersonage:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@texte;
			var reponse1:Number=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@reponse1;
			var reponse2:Number=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@reponse2;
			var attitudeReponse1:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@attitude_reponse1;
			var texteReponse1:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@texte_reponse1;
			var attitudeReponse2:int=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@attitude_reponse2;
			var texteReponse2:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@texte_reponse2;
			var itemDonne:Number=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@itemDonne;
			var itemDemande:Number=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@itemDemande;
			var magasinAchat:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@magasinAchat;
			var magasinVente:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@magasinVente;
			var secance:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@secance;
			var suivant:Number=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@suivant;
			var checkTenue:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@checkTenue;
			var changeDecor:String=donnee_PNJ_XML.lieux.(@nom==fichier).pnj.(@numero==idPNJ).secance.(@numero==idSecance).dialogue.(@numero==idDial).@changeDecor;
			
			while(tableau_texte.length>0){tableau_texte.splice(0,1);}
			
			tableau_texte[0]=idPersonage;
			tableau_texte[1]=attitudeHeros;
			tableau_texte[2]=attitudePersonage;
			tableau_texte[3]=textePersonage;
			tableau_texte[4]=reponse1;
			tableau_texte[5]=reponse2;
			tableau_texte[6]=attitudeReponse1;
			tableau_texte[7]=texteReponse1;
			tableau_texte[8]=attitudeReponse2;
			tableau_texte[9]=texteReponse2;
			tableau_texte[10]=itemDonne;
			tableau_texte[11]=itemDemande;
			tableau_texte[12]=magasinAchat;
			tableau_texte[13]=magasinVente;
			tableau_texte[14]=secance;
			tableau_texte[15]=suivant;
			tableau_texte[16]=checkTenue;
			tableau_texte[17]=changeDecor;
			
			id=tableau_texte[0];
			attitudeH=tableau_texte[1];
			attitudeP=tableau_texte[2];
			texte=tableau_texte[3].toUpperCase();
			
//question reponce==========================================================================
			if(tableau_texte[4]!=0){
				
				var rep1Start:int=Math.floor(tableau_texte[4])
				var rep1Stop:int=Math.round((tableau_texte[4]-rep1Start)*10);
				var rep2Start:int=Math.floor(tableau_texte[5])
				var rep2Stop:int=Math.round((tableau_texte[5]-rep2Start)*10);
								
				tableauReponse[0]=rep1Start;
				tableauReponse[1]=rep1Stop;
				tableauReponse[2]=rep2Start;
				tableauReponse[3]=rep2Stop;
				
				if(tableau_texte[10]==0&&tableau_texte[11]==0&&tableau_texte[16]==""){
					attRep1=tableau_texte[6]
					txtRep1=tableau_texte[7].toUpperCase();
					attRep2=tableau_texte[8]
					txtRep2=tableau_texte[9].toUpperCase();
				}
			}else{
				tableauReponse=[0,0,0,0];
			}
//item donne===============================================================================	
			if(tableau_texte[10]!=0){
				var cTdon:int=Math.floor(tableau_texte[10])
				var tPdon:int=Math.round((tableau_texte[10]-cTdon)*100);
				attRep1=4;
				attRep2=15;
				itemsPNJ[0]=cTdon;
				itemsPNJ[1]=tPdon;
				itemInit=true;
				donneObjet=true;
			}
//item demande===============================================================================
			if(tableau_texte[11]!=0){
				var cTdem:int=Math.floor(tableau_texte[11])
				var tPdem:int=Math.round((tableau_texte[11]-cTdem)*100);
				attRep1=1;
				attRep2=8;
				itemsPNJ[0]=cTdem;
				itemsPNJ[1]=tPdem;
				itemInit=true;
				demandeObjet=true;
			}
//magasin========================================================================
			if(tableau_texte[12]!=""||tableau_texte[13]!=""){
				if(tableau_texte[12]!=""){
					magasinObjetVente=false;
					itemsPNJ=decodeObjet(magasinAchat);
				}
				if(tableau_texte[13]!=""){
					magasinObjetVente=true;
					itemsPNJ=decodeObjet(magasinVente);
				}
				if(tableau_texte[5]!=""){
					var rep2StartMag:int=Math.floor(tableau_texte[5])
					var rep2StopMag:int=Math.round((tableau_texte[5]-rep2StartMag)*10);
					tableauReponse[2]=rep2StartMag;
					tableauReponse[3]=rep2StopMag;
				}
				itemInit=true;
				magasinObjet=true;
			}
// NOT objet========================================================================
			if(tableau_texte[10]==0&&tableau_texte[11]==0&&tableau_texte[12]==""&&tableau_texte[13]==""){
				donneObjet=false;
				demandeObjet=false;
				magasinObjet=false;
				itemInit=false;
			}
//changement secance========================================================================
			if(tableau_texte[14]!=0){
				tableauSecance=decodeSecance(tableau_texte[14]);
				for(var s:int=0;s<tableauSecance.length;s++){
					var fPnj:String=tableauSecance[s][0];
					var nPnj:int=tableauSecance[s][1];
					var sPnj:int=tableauSecance[s][2];
					if(fPnj==fichier&&nPnj==numeroPNJ){numeroSecance=sPnj;}
				}
			}
//force suivant======================================================================
			if(tableau_texte[15]!=0){
				forceSuivant=true;
			}else{forceSuivant=false;}
//check tenue========================================================================
			if(tableau_texte[16]!=""){
				tenueDemande=decodeObjet(checkTenue);
				tenueCheck=true;
			}else{tenueCheck=false;}
//change decor========================================================================
			if(tableau_texte[17]!=""){
				porteChange=decodePorte(changeDecor);
			}else{porteChange=[0,0];}
		}
//RUN=============================================================================================================================================================
		public function run(control:Array):void{
			if(stopDial==false){
				var choix:int=0
				if(invtActif==false&&finAffiche==true&&tableauReponse[0]!=0){choix=deplacementCurseur(control[3]);}
				if(invtActif==true){choix=control[3];}
				if(choix==1){reponseChoisi=1;}
				if(choix==-1){reponseChoisi=-1;}
				if(control[4]==1){appuieStopDial=true;}
				if(invtActif==false&&control[4]==0&&appuieStopDial==true){appuieSuivant=true;appuieStopDial=false;}else{appuieSuivant=false;}
				if(invtActif==false&&finAffiche==true){
					if(control[5]==1){appuieFinDial=true;}
					if(control[5]==0&&appuieFinDial==true){
						tableauReponse=[0,0,0,0];
						finDial=true;
						appuieFinDial=false;
					}
				}
				
				if(nouveauTexte==true&&nombreDial>numeroDial){
					if(memoireDial.length!=0){
						for(var nDial:int=0;nDial<memoireDial.length;nDial++){
							if(numeroDial==nDial&&memoireDial[nDial]==false){numeroDial+=1;}
							if(numeroDial+1>nombreDial){finDial=true;}
						}
					}
					recupererTexte(numeroPNJ,numeroDial,numeroSecance);
					if(tenueCheck==false){
						afficherTexte();
						afficherPerso();
						nombreDialAffiche+=1;
					}
					texteAffiche="";
					finAffiche=false;
					nouveauTexte=false;
					
					if(porteChange[0]!=""){
						stage.dispatchEvent(new Event("changement_decorDial"));
					}
				}
				if(finAffiche==true){
					if(donneObjet==true){donnerItem();}
					if(demandeObjet==true){demanderItem();}
					if(magasinObjet==true){ouvrirMagasin();}
				}
				if(tableauReponse[0]!=0){
					if(tenueCheck==true){tenueChecking();}else{
						if(donneObjet==false&&demandeObjet==false){questionReponse();}else{questionReponseItem();}
					}
				}else{
					if(tableauReponse[2]!=0){
						if(magasinObjet==true){questionReponseMagasin();}
					}else{
						reponseVal=true;
					}
				}
				if(finAffiche==true&&((appuieSuivant==true&&reponseVal==true)||forceSuivant==true)){
					if(numeroDial+1<nombreDial){
						if(tenueCheck==false){
							if(nombreDialAffiche>=2){effacerBulle(dialEfface);}
							idParle=id+1;
							monterBulle(numeroDial);
							dialEfface=numeroDial;
						}
						if(tableauReponse[0]!=0){
							if(reponseChoisi==1){
								for(var n1:int=tableauReponse[2];n1<=tableauReponse[3];n1++){
									memoireDial[n1]=false;
								}
								numeroDial=tableauReponse[0];
							}
							if(reponseChoisi==-1){
								for(var n2:int=tableauReponse[0];n2<=tableauReponse[1];n2++){
									memoireDial[n2]=false;
								}
								numeroDial=tableauReponse[2];
							}
						}else{
							numeroDial+=1;
						}
						reponseChoisi=0;
						nouveauTexte=true;
					}else{
						finDial=true;
					}
					appuieSuivant=false;
				}
				if(finDial==true){
					while(conteneurTexte.numChildren != 0) {conteneurTexte.removeChildAt(0);}
					while(memoireDial.length>0){memoireDial.splice(0,1);}
					finAffiche=false;
					nouveauTexte=true;
					nombreDialAffiche=0;
					dialEfface=0;
					idParle=0;
					nombreDial=0;
					numeroDial=0;
					stopDial=true;
					finDial=false;
				}
			}
		}
		public function afficherPerso(){
			for (var n:Number=0; n<2; n++){
				var typeVisage:int=0;
				var typeSourcil:int=0;
				var attitude:int;
				if(n==0){
					if(tableauReponse[0]!=0){
						if(reponseChoisi==-1){attitude=attRep1;}
						if(reponseChoisi==1){attitude=attRep2;}
						if(reponseChoisi==0){attitude=attitudeH;}
					}else{attitude=attitudeH;}
				}else{
					typeVisage=(proprietePNJ[3][3]-1)*4;
					typeSourcil=(proprietePNJ[3][6]-1)*4;
					attitude=attitudeP;
				}
				var idPerso:String="perso"+n;
				var attVisage:int=((attitude-1)/4)+2;
				var attSourcil:int=((attitude-1)-((attVisage-2)*4))+2;
				MovieClip(MovieClip(conteneur.getChildByName(idPerso)).getChildByName("visage")).gotoAndStop(attVisage+typeVisage);
				MovieClip(MovieClip(conteneur.getChildByName(idPerso)).getChildByName("sourcil")).gotoAndStop(attSourcil+typeSourcil);
			}
		}
		public function afficherTexte(){
			
			var monTexte:TextField=new TextField;
			monTexte.name="texte"+numeroDial;
			monTexte.height=32;
			monTexte.width=174;
			monTexte.y=374;
			monTexte.wordWrap=true;
			monTexte.setTextFormat(miseEnFormeTexte);
				
			var maBulle:Cases_dialogues=new Cases_dialogues();
			maBulle.name="bulle"+numeroDial;
			maBulle.scaleX=maBulle.scaleY=1/3;
			maBulle.y=372;
			
			if(tableauReponse[0]!=0&&donneObjet==false&&demandeObjet==false){monTexte.x=372;maBulle.x=364;maBulle.gotoAndStop(1);}else{
				if(id==0){
					if(idParle==1){
						monTexte.x=420;maBulle.x=412;maBulle.gotoAndStop(7);
					}else{
						monTexte.x=372;maBulle.x=364;maBulle.gotoAndStop(2);
					}
				}
				if(id==1){
					if(idParle==2){
						monTexte.x=372;maBulle.x=364;maBulle.gotoAndStop(6);
					}else{
						monTexte.x=420;maBulle.x=412;maBulle.gotoAndStop(4);
					}
				}
			}
			if(texte!=""){
				conteneurTexte.addChild(maBulle);
				conteneurTexte.addChild(monTexte);
			}
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, typeWriter);
		}
		public function typeWriter(evt:Event){
			var nomTexte:String="texte"+numeroDial;
			var nomBulle:String="bulle"+numeroDial;
			var lettre_temp:String="";
			
			if(texteAffiche.length<texte.length){
				lettre_temp=texte.substr(texteAffiche.length, 1);
				sonLettre(lettre_temp);
				texteAffiche=texteAffiche+lettre_temp;
				if(appuieSuivant==true){texteAffiche=texte;appuieSuivant=false;}
				TextField(conteneurTexte.getChildByName(nomTexte)).text= String(texteAffiche);
				TextField(conteneurTexte.getChildByName(nomTexte)).setTextFormat(miseEnFormeTexte);
			}else{
				tableauSon=[false,""];
				if(timerFin>=5){finAffiche=true;timerFin=0;}else{timerFin+=1;}
			}
		}
		public function questionReponseItem(){
			afficherPerso();
			if(reponseChoisi!=0&&appuieSuivant==true){reponseVal=true;}
		}
		public function questionReponseMagasin(){
			afficherPerso();
			if(reponseChoisi==-1&&appuieSuivant==true){
				for(var n:int=0;n<memoireDial.length;n++){
					memoireDial[n]=true;
				}
				tableauReponse[0]=numeroDial+1;
				tableauReponse[1]=numeroDial+1;	
				reponseVal=true;
			}
		}
		public function tenueChecking(){
			if(proprieteHeros[0]==tenueDemande[0][0]&&
				proprieteHeros[1]==tenueDemande[0][1]&&
				proprieteHeros[2]==tenueDemande[0][2]){
				reponseChoisi=-1}else{reponseChoisi=1;}
			forceSuivant=true;
			finAffiche=true;
		}
		public function questionReponse(){
			if(reponseVal==true){
				var maReponse1:TextField=new TextField;
				maReponse1.name="Rep1";
				var maReponse2:TextField=new TextField;
				maReponse2.name="Rep2";
				var maPuce:Puce=new Puce();
				maPuce.scaleX=0.5;
				maPuce.scaleY=0.5;
				maPuce.name="Puce";
				
				maPuce.alpha=0.5;
				maPuce.gotoAndStop(1);
				maPuce.x=448;
				maPuce.y=382;
				maReponse1.x=474;
				maReponse1.y=374;
				maReponse2.x=474;
				maReponse2.y=388
				
				maReponse1.alpha=maReponse2.alpha=0.5;
				maReponse1.height=maReponse2.height=16;
				maReponse1.width=maReponse2.width=70;
				maReponse1.wordWrap=maReponse2.wordWrap=true;
				
				maReponse1.text=String(txtRep1);
				maReponse2.text=String(txtRep2);
				
				maReponse1.setTextFormat(miseEnFormeTexte);
				maReponse2.setTextFormat(miseEnFormeTexte);
				
				conteneurTexte.addChild(maPuce);
				conteneurTexte.addChild(maReponse1);
				conteneurTexte.addChild(maReponse2);
				
				reponseChoisi=0;
				reponseVal=false;
			}
			if(reponseChoisi!=0){
				MovieClip(conteneurTexte.getChildByName("Puce")).x=452;
				MovieClip(conteneurTexte.getChildByName("Puce")).gotoAndStop(1);
			}
			if(reponseChoisi==-1){
				MovieClip(conteneurTexte.getChildByName("Puce")).y=388;
				MovieClip(conteneurTexte.getChildByName("Puce")).alpha=1;
				TextField(conteneurTexte.getChildByName("Rep1")).alpha=0.5;
				TextField(conteneurTexte.getChildByName("Rep2")).alpha=1;
				afficherPerso();
			}
			if(reponseChoisi==1){
				MovieClip(conteneurTexte.getChildByName("Puce")).y=374;
				MovieClip(conteneurTexte.getChildByName("Puce")).alpha=1;
				TextField(conteneurTexte.getChildByName("Rep1")).alpha=1;
				TextField(conteneurTexte.getChildByName("Rep2")).alpha=0.5;
				afficherPerso();
			}
			if(reponseChoisi!=0&&appuieSuivant==true){
				var nomTexte:String="texte"+numeroDial;
				var texteRep:String;
				if(reponseChoisi==1){texteRep=texte+"  "+txtRep1;}
				if(reponseChoisi==-1){texteRep=texte+"  "+txtRep2;}
				TextField(conteneurTexte.getChildByName(nomTexte)).text=String(texteRep);
				TextField(conteneurTexte.getChildByName(nomTexte)).setTextFormat(miseEnFormeTexte);
				conteneurTexte.removeChild(MovieClip(conteneurTexte.getChildByName("Puce")));
				conteneurTexte.removeChild(TextField(conteneurTexte.getChildByName("Rep1")));
				conteneurTexte.removeChild(TextField(conteneurTexte.getChildByName("Rep2")));
				reponseVal=true;
			}			
		}
		public function donnerItem(){
			if(itemInit==true){
				stage.dispatchEvent(new Event("inventaireAffiche"));
				itemsPNJ=[];
				itemInit=false;
			}
		}
		public function demanderItem(){
			if(itemInit==true){
				stage.dispatchEvent(new Event("inventaireAffiche"));
				itemsPNJ=[];
				itemInit=false;
			}
		}
		public function ouvrirMagasin(){
			if(itemInit==true){
				stage.dispatchEvent(new Event("inventaireAffiche"));
				itemsPNJ=[];
				itemInit=false;
			}
		}
		private function monterBulle(n:int){
			var nomTexte:String="texte"+n;
			var nomBulle:String="bulle"+n;
			
			MovieClip(conteneurTexte.getChildByName(nomBulle)).y=328;
			TextField(conteneurTexte.getChildByName(nomTexte)).y=330;
			if(idParle==1){
				MovieClip(conteneurTexte.getChildByName(nomBulle)).x=364;
				TextField(conteneurTexte.getChildByName(nomTexte)).x=372;
			}
			if(idParle==2){
				MovieClip(conteneurTexte.getChildByName(nomBulle)).x=412;
				TextField(conteneurTexte.getChildByName(nomTexte)).x=420;
			}
			if(id==0){MovieClip(conteneurTexte.getChildByName(nomBulle)).gotoAndStop(3);}
			if(id==1){MovieClip(conteneurTexte.getChildByName(nomBulle)).gotoAndStop(5);}
			
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,typeWriter);
			
			texteAffiche="";
			finAffiche=false;
		}
		private function effacerBulle(dialEff:int){
			
			var bulleEfface:String;
			var texteEfface:String;
			bulleEfface="bulle"+(dialEff);
			texteEfface="texte"+(dialEff);
				
			conteneurTexte.removeChild(conteneurTexte.getChildByName(bulleEfface));
			conteneurTexte.removeChild(conteneurTexte.getChildByName(texteEfface));
		}
		private function decodeObjet(code:String):Array{
			var tableauRetour:Array=new Array();
			
			var tableauTemp1:Array=new Array();
			var tableauTemp2:Array=new Array();
			
			tableauTemp1=code.split("!");
			for(var E:int=0;E<tableauTemp1.length;E++){
				tableauTemp2[E]=tableauTemp1[E].split(",");
				tableauRetour[E]=[];
				for(var P:int=0;P<tableauTemp2[E].length;P++){
					var nombre:int=int(tableauTemp2[E][P]);
					tableauRetour[E][P]=nombre;					
				}
			}
			return(tableauRetour);
		}
		private function decodeSecance(code:String):Array{
			var tableauRetour:Array=new Array();
			
			var tableauTemp1:Array=new Array();
			
			tableauTemp1=code.split("!");
			for(var E:int=0;E<tableauTemp1.length;E++){
				tableauRetour[E]=tableauTemp1[E].split(",");
			}
			return(tableauRetour);
		}
		private function decodePorte(code:String):Array{
			var tableauRetour:Array=new Array();
			tableauRetour=code.split(",");
			return(tableauRetour);
		}
		private function deplacementCurseur(control:int):int{
			var curseur:int=0;
			var deplacement:int=0;
			
			if(control==0){autoriseCurseur=true;}
			
			if(control!=0){
				if(control==1){curseur=1;}
				if(control==-1){curseur=-1;}
			}
			if(curseur!=0&&autoriseCurseur==true){deplacement=curseur;autoriseCurseur=false;}
			
			return(deplacement);
		}
		public function sonLettre(lettre:String){
			var control:String="";
			tableauSon=[false,""];
			switch(lettre){
				case "A": control="a";break;
				case "Á": control="a";break;
				case "À": control="a";break;
				
				case "E": control="e";break;
				case "É": control="e";break;
				case "È": control="e";break;
				case "Ê": control="e";break;
				case "Ë": control="e";break;
				
				case "I": control="i";break;
				case "Î": control="i";break;
				case "Ï": control="i";break;
				
				case "O": control="o";break;
				
				case "U": control="u";break;
				case "Ú": control="u";break;
				case "Ù": control="u";break;
				
			}
			if(control!=""){tableauSon=[true,control];}
		}
//DEMON====================================================================================================================================
		private function ajouterDemon(){
			var demonMC:DepartJeuBouleAnimate=new DepartJeuBouleAnimate();
			demonMC.name="demon";
			demonMC.scaleX=0.75;
			demonMC.scaleY=0.75;
			demonMC.x=54;
			demonMC.y=195;
			conteneur.addChild(demonMC);
		}
		private function supprimerDemon(){
			if(MovieClip(conteneur.getChildByName("demon")) is DisplayObject==true){conteneur.removeChild(MovieClip(conteneur.getChildByName("demon")));}
		}
	}
}