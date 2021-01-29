package{
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.system.*;
	import flash.utils.*;
	
	public class Game extends MovieClip{
		
		public var conteneur:MovieClip=new MovieClip;
		public var monPad:Pad=new Pad();
		public var monLieux:Lieux=new Lieux();
		public var gestionChargement:Chargement=new Chargement();
		public var mesSounds:Sounds=new Sounds();
		public var monMenuStart:MenuStart=new MenuStart();
		public var maGrille:Grille=new Grille();
		public var monCadre:Cadre=new Cadre();
		public var monVoileNoir:VoileNoir=new VoileNoir();
		public var monCache:CacheDialogue=new CacheDialogue();
		public var monInventaire:Inventaire=new Inventaire();
		public var monJourNuit:JourNuit=new JourNuit();
		public var frameRateSound:Timer=new Timer(33);
		
		public var lieuxXML:XML=new XML();
		public var listePnjXML:XML=new XML();
		public var cineXML:XML=new XML();
		
		public var cartesNiveaux:Array=new Array();
		public var carte_ligne_depart:int=0;
		public var carte_colonne_depart:int=0;
		
		public var typeNiveau:String="";
		
		public var porteLaterale:Boolean=false;
		public var sonPorte:Boolean=false;
		
		public var changementDecorCine:Boolean=false;
		public var chargementTotalEffetue:Boolean=false;
		public var chargementNouveauDecorEffectue:Boolean=false;
		
		public var changementDecorDepart:Boolean=true;
		public var changementDecorDial:Boolean=false;
		public var changementDecorPorte:Boolean=false;
		public var changementDecorPorteArrive:Boolean=false;
		public var changementDecorMort:Boolean=false;
		
		public var padBloque:Boolean=true;
		
		public var herosMort:Boolean=false;
		public var herosSens:int=1;
		public var herosSensPorte:int=0;
		public var herosVitesse:Array=new Array();
		
		public var positionDecor:Array=new Array();
		
		public var retourDecor:Array=new Array();
		
		public var memoireInventaire:Array=new Array();
		public var memoireItems:Array=new Array();
		public var memoireMonstres:Array=new Array();
		public var memoirePnj:Array=new Array();
		
		public var piecesMemoire:int=0;
		public var cleMemoire:Array=new Array();
		public var armeMemoire:int=0;
		
		public var armePerte:Boolean=false;
		public var objetPerte:Boolean=false;
		public var typeMort:int=0;
		
		public var pauseJeu:Boolean=false;
		
		public var testEnCours:Boolean=false;
		public var menuEnCours:Boolean=false;
		public var cineEnCours:Boolean=false;
		public var inventaireEnCours:Boolean=false;
		public var dialoguesEnCours:Boolean=false;
		public var plateformeEnCours:Boolean=true;
		
		public var monFPScounter:FPScounter=new FPScounter;
		
		public var tableauSon:Array=[false,false,false,false,false];
		
		public function Game(){
	
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addChild(gestionChargement);
			
			stage.addChild(conteneur);
			//stage.addChild(monJourNuit);
			stage.addChild(monCache);
			stage.addChild(monInventaire);
			stage.addChild(monVoileNoir);
			stage.addChild(monCadre);
			
			stage.addEventListener(KeyboardEvent.KEY_UP,toucheRelacher);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,toucheAppuyer);
			stage.addEventListener(Event.ENTER_FRAME,runTotal);
						
			stage.addEventListener("ouvre_porte",ouvrePorte);
			stage.addEventListener("ouvre_porteLaterale",ouvrePorteLaterale);
			stage.addEventListener("changement_decorDial",fchangementDecorDial);
			stage.addEventListener("changement_decor",fchangementDecorCine);
			
			stage.addEventListener("DialogueStart",dialogueStart);
			stage.addEventListener("DialogueStop",dialogueStop);
			stage.addEventListener("inventaireAffiche",inventAffiche);
			
			stage.addEventListener("ouvreCoffre",ouvreCoffre);
			stage.addEventListener("fermeCoffre",fermeCoffre);
			
			stage.addEventListener("cinematique_termine",cinematique_termine);
			
			stage.addEventListener("chargementTotalTermine",chargementTotalTermine);
			stage.addEventListener("chargementTotalCarteTermine",chargementTotalCarteTermine);
			
			stage.addEventListener("clickBoutonStart",menuStartOut);
			
			stage.addEventListener("mort_tombe",mortTombe);
			stage.addEventListener("mort_eau",mortEau);
			stage.addEventListener("mort_monstre",mortMonstre);
			stage.addEventListener("MORT",mort);
			
		}
//APPUIE TOUCHES===========================================================================================
		public function toucheAppuyer(evt:KeyboardEvent):void{
			monPad.appuie(evt);
		}
		public function toucheRelacher(evt:KeyboardEvent):void{
			monPad.relache(evt);
		}
//CHARGEMENT DONNEE===========================================================================================
		public function chargementTotalTermine(evt:Event){
			lieuxXML=gestionChargement.donneesLieux;
			listePnjXML=gestionChargement.donneesListePNJ;
			cineXML=gestionChargement.donneesCine;
			
			monLieux.creerLieux(lieuxXML);
			gestionChargement.chargerCartes(monLieux.nomLieux());
		}
		public function chargementTotalCarteTermine(evt:Event){
			charger_carte(monLieux.donnee_niveau);
			chargementTotalEffetue=true;
		}	
//RUN TOTAL====================================================================================================
		public function runTotal(e:Event){
			if(chargementTotalEffetue==true){
				if(chargementNouveauDecorEffectue==true){
					if(menuEnCours==true){runMenu();}
					if(cineEnCours==true){runCine();}
					if(inventaireEnCours==true){runInventaire();}
					if(dialoguesEnCours==true){runDialogues();}
					if(plateformeEnCours==true){runPlateforme();}
					//runJourNuit();
					runTest();
					runCamera();
					tableauSon=[menuEnCours,cineEnCours,inventaireEnCours,dialoguesEnCours,plateformeEnCours];
					runSound();
					run();
				}
			}
		}
	//RUN..................................................................
		public function run(){
		//init inentaire memoire-------------------------------------------------------------------------
			if(memoireInventaire.length<100){for(var n:int=0;n<100;n++){memoireInventaire[n]=0;}}
		//test-------------------------------------------------------------------------------------------
			if(monPad.touches()[3]==1&&monPad.touches()[10]==1&&monPad.touches()[5]==1){testEnCours=true;}
			if(monPad.touches()[3]==-1&&monPad.touches()[10]==1&&monPad.touches()[5]==1){testEnCours=false;}
			
			if(cineEnCours==true||dialoguesEnCours==true){
				changementLieux();			
			}
			if(cineEnCours==false){
				if(Cinematique(conteneur.getChildByName("Cine")) is MovieClip){conteneur.removeChild(Cinematique(conteneur.getChildByName("Cine")));}
			}
			if(monVoileNoir.image>=58&&Decor(conteneur.getChildByName("Decor")).touche_sol==true){monInventaire.run(monPad.touches(),dialoguesEnCours);}
			else{monInventaire.run([0,0,0,0,0,0],false)}
			
			if(monInventaire.affiche==true){
				inventaireEnCours=true;
				interagir();
			}else{
				inventaireEnCours=false;
			}
			if(cineEnCours==false&&dialoguesEnCours==false&&inventaireEnCours==false){
				plateformeEnCours=true;retourDecor[6]=0;
				changementLieux();
				interagir();
			}else{
				plateformeEnCours=false;
			}
			function changementLieux(){
				if(sonPorte==true){retourDecor[7]=0;sonPorte=false;}
				changerDecor();
				afficherVoileNoir();
			}
			function interagir(){
				functionRetourDecor();
				if(objetPerte==true){perteObjet();}
			}
		}	
	//RUN JOUR NUIT.........................................................
		public function runJourNuit(){
			monJourNuit.run();
		}
	//RUN TEST.........................................................
		public function runTest(){
			if(testEnCours==true){
				if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").alphaTest==0){
					stage.addChild(maGrille);
					stage.addChild(monFPScounter);monVoileNoir.alpha=0.3;
				}
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").alphaTest=1;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").alphaTest=1;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").alphaTest=1;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").alphaTest=1;
				monCadre.alpha=0;
			}
			if(testEnCours==false){
				if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").alphaTest==1){
					stage.removeChild(maGrille);
					stage.removeChild(monFPScounter);monVoileNoir.alpha=0.3;
				}
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").alphaTest=0;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").alphaTest=0;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").alphaTest=0;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").alphaTest=0;
				monCadre.alpha=1;
			}
		}
	//RUN MENU.........................................................
		public function runMenu(){}
	//RUN CINE.........................................................
		public function runCine(){
			Cinematique(conteneur.getChildByName("Cine")).run();
			if(monVoileNoir.image>=30){
				Cinematique(conteneur.getChildByName("Cine")).voileOuvert=true;
			}else{
				Cinematique(conteneur.getChildByName("Cine")).voileOuvert=false;
			}
			Heros(conteneur.getChildByName("Heros")).afficherHerosCine(Cinematique(conteneur.getChildByName("Cine")).afficher);
			Decor(conteneur.getChildByName("Decor")).deplacerDecorCine(Cinematique(conteneur.getChildByName("Cine")).deplacer);
			Heros(conteneur.getChildByName("Heros")).conteneur.x=MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("N0").conteneur.x;
			Heros(conteneur.getChildByName("Heros")).conteneur.y=MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("N0").conteneur.y;
		}
	//RUN INVENTAIRE....................................................
		public function runInventaire(){
			monCache.alpha=1;
			if(monInventaire.positionHeros!=0){retourDecor[6]=monInventaire.positionHeros;}
			Heros(conteneur.getChildByName("Heros")).afficherHeros([],retourDecor,monInventaire.inventaireRetour);
			Decor(conteneur.getChildByName("Decor")).inertie=0;
			Decor(conteneur.getChildByName("Decor")).elanDG=0;
			
			if(herosMort==true){monInventaire.invtVisible=false;}
		}
	//RUN DIALOGUES....................................................
		public function runDialogues(){
			monCache.alpha=1;
			Heros(conteneur.getChildByName("Heros")).afficherHeros([],retourDecor,monInventaire.inventaireRetour);
			Decor(conteneur.getChildByName("Decor")).inertie=0;
			Decor(conteneur.getChildByName("Decor")).elanDG=0;
			
			if(monInventaire.invtAlpha<=0){
				MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").invtActif=false;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").dialogues_PNJ(monPad.touches());
			}
			if(monInventaire.invtAlpha>=1){
				MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").invtActif=true;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").dialogues_PNJ([0,0,0,monInventaire.reponceItem,1,0]);
			}
		}
	//RUN PLATEFORMES....................................................
		public function runPlateforme(){
			monCache.alpha=0;
			Heros(conteneur.getChildByName("Heros")).afficherHeros(monPad.touches(),retourDecor,monInventaire.inventaireRetour);
			Decor(conteneur.getChildByName("Decor")).deplacerDecor(monPad.touches(),retourDecor);
		}		
	//RUN CAMERA.........................................................
		public function runCamera(){
			if(inventaireEnCours==true||dialoguesEnCours==true){
				conteneur.scaleX=2;
				conteneur.scaleY=2;
				conteneur.x=-480;
				conteneur.y=-540;
			}else{
				Decor(conteneur.getChildByName("Decor")).maCamera.run();
				if(conteneur.getChildByName("Cine")  is MovieClip==true){
					Cinematique(conteneur.getChildByName("Cine")).x=-(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX);
					Cinematique(conteneur.getChildByName("Cine")).y=-(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY);
				}
				conteneur.x=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX);
				conteneur.y=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY);
				MovieClip(conteneur.getChildByName("Decor")).conteneurFond.x=-(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX);
				MovieClip(conteneur.getChildByName("Decor")).conteneurFond.y=-(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY);
				MovieClip(conteneur.getChildByName("Decor")).fondN2.x=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX)/2;
				MovieClip(conteneur.getChildByName("Decor")).fondN2.y=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY)/2;
				MovieClip(conteneur.getChildByName("Decor")).fondN3.x=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX)/4;
				MovieClip(conteneur.getChildByName("Decor")).fondN3.y=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY)/4;
				if((MovieClip(conteneur.getChildByName("Decor")).maCamera.zoomCam)!=1){
					MovieClip(conteneur.getChildByName("Decor")).conteneurFond.scaleX=(1/(MovieClip(conteneur.getChildByName("Decor")).maCamera.zoomCam));
					MovieClip(conteneur.getChildByName("Decor")).conteneurFond.scaleY=(1/(MovieClip(conteneur.getChildByName("Decor")).maCamera.zoomCam));
				}else{
					MovieClip(conteneur.getChildByName("Decor")).conteneurFond.scaleX=1;
					MovieClip(conteneur.getChildByName("Decor")).conteneurFond.scaleY=1;
				}
				monVoileNoir.x=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX);
				monVoileNoir.y=(MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY);
				monVoileNoir.scaleY=monVoileNoir.scaleX=(MovieClip(conteneur.getChildByName("Decor")).maCamera.zoomCam);
				conteneur.scaleY=conteneur.scaleX=(MovieClip(conteneur.getChildByName("Decor")).maCamera.zoomCam);
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").zoomCam[0]=MovieClip(conteneur.getChildByName("Decor")).maCamera.zoomCam;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").zoomCam[1]=MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamX;
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").zoomCam[2]=MovieClip(conteneur.getChildByName("Decor")).maCamera.decalageCamY;
			}
		}
	//RUN SOUND.........................................................
		public function runSound(){
			
			mesSounds.gestionSon(MovieClip(conteneur.getChildByName("Heros")).tableauSon,
								MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").tableauSon,
								MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").tableauSon,
								monInventaire.tableauSon,
								MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").tableauSon,
								MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").tableauSon,
								tableauSon,
								monPad.touches(),
								retourDecor
								);
		}
//VOILE NOIR=============================================================================================================
		public function afficherVoileNoir(){
			if(Cinematique(conteneur.getChildByName("Cine")) is MovieClip){
			   if(Cinematique(conteneur.getChildByName("Cine")).cineInitialized==false&&monVoileNoir.image<29){monVoileNoir.ouvrirAutorise=false;}else{monVoileNoir.ouvrirAutorise=true;}
			}
			if(monVoileNoir.image<33){block_decor();}
			if(monVoileNoir.image>=41){if(herosMort==false){deblock_decor();}}
			if(monVoileNoir.image<=59&&monVoileNoir.sens==-1&&monPad.controlPad==false){monPad.block();}
			if(monVoileNoir.image==59&&monVoileNoir.sens==1){monPad.deblock();}
			if(monVoileNoir.image<=58){
				monVoileNoir.afficher();
			}
		}
//EVENT====================================================================================================================================================
	//EVENT DIALOGUE................................................................................................ 
		public function dialogueStart(evt:Event){
			Heros(conteneur.getChildByName("Heros")).alpha=0;
			dialoguesEnCours=true;
		}
		public function dialogueStop(evt:Event){
			Heros(conteneur.getChildByName("Heros")).alpha=1;
			dialoguesEnCours=false;
		}
		public function fchangementDecorDial(evt:Event){
			changementDecorDial=true;
			monVoileNoir.fermer();
		}
	//EVENT INVENTAIRE...............................................................................................
		public function inventAffiche(evt:Event){
			if(dialoguesEnCours==true){
				monInventaire.itemsPNJ=MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").itemsPNJ;
				
				if(MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").donneObjet==true){
					monInventaire.donneObjet=true;
				}
				if(MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").demandeObjet==true){
					monInventaire.demandeObjet=true;
				}
				if(MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").magasinObjet==true){
						monInventaire.magasinObjet=true;
					if(MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").magasinObjetVente==true){
						monInventaire.magasinVente=true;
					}else{
						monInventaire.magasinVente=false;
					}
				}
				monInventaire.affiche=true;
			}
		}
	//EVENT ITEMS......................................................................................................
		public function ouvreCoffre(evt:Event){
			monInventaire.retourObjet=MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").retourObjet;
			monInventaire.ouvreCoffre=true;
		}
		public function fermeCoffre(evt:Event){
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").initialisationCoffre=monInventaire.initialisationCoffre;
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").modifierObjetCoffre();
		}
	//EVENT MORT.........................................................................................................
		public function mortTombe(evt:Event){
			typeMort=1;
			herosMort=true;
			mort();
		}
		public function mortEau(evt:Event){
			typeMort=10;
			herosMort=true;
			mort();
		}
		public function mortMonstre(evt:Event){
			var equipement:Boolean=false;
			for(var n:int;n<5;n++){
				if(monInventaire.inventaireRetour[n]!=0){equipement=true;}
			}
			if(equipement==false){
				typeMort=11;
				herosMort=true;
				mort();
			}
			if(equipement==true){
				pertUnObjet();
				objetPerte=true;
			}
		}
		public function mort(){
			retourDecor[6]=9;
			retourDecor[10]=typeMort;
			if(changementDecorMort==false){
				MovieClip(conteneur.getChildByName("Decor")).mort=false;
				MovieClip(conteneur.getChildByName("Decor")).mortTombe=false;
				changementDecorMort=true;
				
				monVoileNoir.fermer();
			}
			herosMort=false;
		}
	//EVENT PORTE............................................................................................................
		public function ouvrePorte(evt:Event){
			changementDecorPorte=true;
			porteLaterale=false;
			monVoileNoir.fermer();
		}
		public function ouvrePorteLaterale(evt:Event){
			changementDecorPorte=true;
			porteLaterale=true;
			monVoileNoir.fermer();
		}
	//EVENT CINMATIQUE........................................................................................................
		public function fchangementDecorCine(evt:Event){
			changementDecorCine=true;
			monVoileNoir.fermer();
		}
		public function cinematique_termine(evt:Event){
			cineEnCours=false;
			MovieClip(conteneur.getChildByName("Decor")).cineEnCours=false;
			typeNiveau="";
		}
	//EVENT MENU............................................................................................................
		public function menuStartOut(evt:Event){
			pauseJeu=false;
			herosMort=false;
			monVoileNoir.ouvrir();
			stage.removeChild(monMenuStart);
			Mouse.hide();
		}
//==============================================================================================================================================================
		public function sonOuvrePorte(){retourDecor[7]=1;sonPorte=true;}
		public function sonFermePorte(){retourDecor[7]=2;sonPorte=true;}
		
//FUNCTION RETOUR=============================================================================================
		public function functionRetourDecor(){
	//RETOUR ITEM.....................................................................
		//INVENTAIRE-----------------------------------------------------------------------
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").inventaireRetour=
			monInventaire.inventaireRetour;
		//PIECES---------------------------------------------------------------------------
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").pieces[0]==true){
				monInventaire.modifierInvt(10,MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").pieces[1]+1);
			}
		//CLE------------------------------------------------------------------------------
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").cle[0]==true){
				monInventaire.modifierInvt(11,MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").cle[1]+1);
			}
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").serrureOuvrir[0]==true){
				monInventaire.suprimerCle(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").serrureOuvrir[1]);
			}
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").tableauCle=monInventaire.tableauCle;
		//ARME UTILISE----------------------------------------------------------------------
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").armePlus==true){
				monInventaire.modifierInvt(3,MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").armeUtilise)
			}
		//ITEMS-----------------------------------------------------------------------------
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").itemPlus==true){
				monInventaire.modifierInvt(4,MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").itemUtilise)
			}
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").itemUtilise=monInventaire.inventaireRetour[4];
		//HABITS----------------------------------------------------------------------------
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").habitPlus==true){
				monInventaire.modifierInvt(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").habitPris[0],
										   MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").habitPris[1])
			}
	//RETOUR MONSTRES.....................................................................
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").inventaire=
			monInventaire.inventaireRetour;
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").objetMonstre[0]==true){
				var obj:Array=MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").objetMonstre;
				monInventaire.modifierInvt(obj[1],obj[2]+1);
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").modifierObjet(obj[3],obj[1],monInventaire.inventaireRetour[obj[1]]);
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").objetMonstre=[false,0,0];
			}
	//RETOUR SONS..........................................................................
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").armeUtilise=
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").armeUtilise=
			MovieClip(conteneur.getChildByName("Heros")).armeUtilise=
			MovieClip(conteneur.getChildByName("Heros")).heros.getChildByName("Armes").nouvelleArme=
			MovieClip(conteneur.getChildByName("Heros")).armeUtilise=monInventaire.inventaireRetour[3];
			
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").proprieteHeros=monInventaire.inventaireRetour;
			
			herosVitesse[0]=Decor(conteneur.getChildByName("Decor")).vitesseDG;
			herosVitesse[1]=Decor(conteneur.getChildByName("Decor")).vitesseHB;		
			positionDecor[0]=(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("N0").conteneur.x);
			positionDecor[1]=(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("N0").conteneur.y);
			
			herosSens=Heros(conteneur.getChildByName("Heros")).herosSens;
	//RETOUR DECOR...........................................................................
			Decor(conteneur.getChildByName("Decor")).inventaire=monInventaire.inventaireRetour;
			
			if (Decor(conteneur.getChildByName("Decor")).blockDG==true||
				Decor(conteneur.getChildByName("Decor")).arretDG==true){retourDecor[0]=0;}else{
				if (Decor(conteneur.getChildByName("Decor")).droite==true){retourDecor[0]=1;herosSens=1}
				if (Decor(conteneur.getChildByName("Decor")).gauche==true){retourDecor[0]=-1;herosSens=-1}
			}
			if (Decor(conteneur.getChildByName("Decor")).arretHB==true&&Decor(conteneur.getChildByName("Decor")).hauteur_saut_min==0){retourDecor[1]=0;}else{
				if (Decor(conteneur.getChildByName("Decor")).peurTombe==true){retourDecor[1]=4;}else{
					if (Decor(conteneur.getChildByName("Decor")).haut==true){retourDecor[1]=1;}
					if (Decor(conteneur.getChildByName("Decor")).bas==true){retourDecor[1]=-1;monPad.retourTouches[2]=0;}
				}
			}
			if (Decor(conteneur.getChildByName("Decor")).blockHB==true){retourDecor[1]=3;}
			if (Decor(conteneur.getChildByName("Decor")).touche_sol==true){
				if (Decor(conteneur.getChildByName("Decor")).iTouche_sol==true){retourDecor[1]=5;}else{retourDecor[1]=2;}
			}
			MovieClip(conteneur.getChildByName("Heros")).vitesseDG=Decor(conteneur.getChildByName("Decor")).vitesseDG;
			MovieClip(conteneur.getChildByName("Heros")).vitesseHB=Decor(conteneur.getChildByName("Decor")).vitesseHB;
			MovieClip(conteneur.getChildByName("Heros")).decorSens=Decor(conteneur.getChildByName("Decor")).decorSens;
			
			if (Decor(conteneur.getChildByName("Decor")).echelles==true){retourDecor[5]=1;}
			if (Decor(conteneur.getChildByName("Decor")).echelles==false){retourDecor[5]=0;}
			
			if (Decor(conteneur.getChildByName("Decor")).cours==true){
				if (Decor(conteneur.getChildByName("Decor")).coursFin==true){retourDecor[4]=2;}else{retourDecor[4]=1;}
			}
			if (Decor(conteneur.getChildByName("Decor")).cours==false){
				if (Decor(conteneur.getChildByName("Decor")).derapageCours==false){retourDecor[4]=0;}else{retourDecor[4]=3;}
			}
			if (Decor(conteneur.getChildByName("Decor")).derapage==true){retourDecor[3]=1;}else{retourDecor[3]=0;}
			if (Decor(conteneur.getChildByName("Decor")).cogne==true){retourDecor[6]=4;}
			
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").herosSens=Heros(conteneur.getChildByName("Heros")).herosSens;
			
			if(MovieClip(conteneur.getChildByName("Decor")).interactionDecor[0]==true){retourDecor[6]=MovieClip(conteneur.getChildByName("Decor")).interactionDecor[1]+100;}
	//RETOUR ARMES==========================================================================
			Decor(conteneur.getChildByName("Decor")).controlHitTestArmes(MovieClip(conteneur.getChildByName("Heros")).armeHitTest);
			MovieClip(conteneur.getChildByName("Heros")).conteneur.getChildByName("Projectiles").cartes=cartesNiveaux[1];
			MovieClip(conteneur.getChildByName("Heros")).conteneur.getChildByName("Projectiles").carte_ligne_depart=carte_ligne_depart;
			MovieClip(conteneur.getChildByName("Heros")).conteneur.getChildByName("Projectiles").carte_colonne_depart=carte_colonne_depart;
			MovieClip(conteneur.getChildByName("Heros")).conteneur.getChildByName("Projectiles").positionDecor=positionDecor;
			MovieClip(conteneur.getChildByName("Heros")).conteneur.getChildByName("Projectiles").deplacerDecor();
			MovieClip(conteneur.getChildByName("Heros")).conteneur.getChildByName("Projectiles").toucheMonstre=
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").armeTouche;
			
	//RETOUR SONS===========================================================================
		//SONS ZONE-----------------------------------------------------------
			mesSounds.sonsZone=MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("N1").sonsZone;
			mesSounds.volumeSonZone=MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("N1").volumeSon;
		
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").porteOuvrir==true){sonOuvrePorte()}
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").porteFermer==true){sonFermePorte()}
			
			if(herosMort==true){
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").mort=true;
				if (Decor(conteneur.getChildByName("Decor")).touche_sol==true){
					monPad.block();
					if(monVoileNoir.image<33){block_decor();}
				}
			}
		//HEROS AFFAIBLI--------------------------------------------------------
			var herosAffaibli:Boolean=false;
			if(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").herosAffaibli[1]!=0){
				MovieClip(conteneur.getChildByName("Heros")).herosAffaibli[0]=true;
				MovieClip(conteneur.getChildByName("Heros")).herosAffaibli[1]=
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").herosAffaibli[1];
				MovieClip(conteneur.getChildByName("Decor")).blockVitesseMarche=4;
				
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").herosAffaibli[1]=0;
			}
			if(MovieClip(conteneur.getChildByName("Heros")).herosAffaibli[0]==false){
				MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").herosAffaibli=[false,0];
				MovieClip(conteneur.getChildByName("Decor")).blockVitesseMarche=0;
				monPad.deblockToucheNum();
			}else{
				monPad.blockToucheNum(3,5,1);
			}
		}
//MORT============================================================================================================================================
		public function perteObjet(){
			if(changementDecorMort==true){
				objetPerte=false;
			}
			if(retourDecor[10]!=2&&changementDecorMort==false){
				var sens:int=-herosSens;
				
				var minuteur:Timer=new Timer(500,5);
				minuteur.addEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
				minuteur.start();
				MovieClip(conteneur.getChildByName("Decor")).touche_sol=true;
				MovieClip(conteneur.getChildByName("Decor")).saut_autorise=true;
				monPad.control(sens,1,0,0,0);
				retourDecor[10]=2;
			}else{
				monPad.unControl();
				monPad.blockToucheNum(3,4,5);
				if(herosSens!=0){sens=herosSens}
			}
			function minuteurStop(evt:TimerEvent){
				if(changementDecorMort==false){
					monPad.unControl();
					retourDecor[10]=0;
					objetPerte=false;
				}
				removeMinuteur();
			}
			function removeMinuteur(){
				minuteur.removeEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
			}
			
		}
		public function pertUnObjet(){
			var objetPerdu:Boolean=false;
			while(objetPerdu==false){
				var objet:int=Math.round(Math.random()*4);
				if(monInventaire.inventaireRetour[objet]!=0){
					MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").monstreObjetPris[0]=true;
					MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").monstreObjetPris[1]=objet;
					MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").monstreObjetPris[2]=monInventaire.inventaireRetour[objet];
					monInventaire.modifierInvt(objet);
						
					objetPerdu=true;
				}
			}
		}
//BLOCK PAD===========================================================================================================
		public function deblock_decor(){
			mesSounds.deblock();
			MovieClip(conteneur.getChildByName("Decor")).deblock();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").deblock();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").deblock();
		} 
		public function block_decor(){
			mesSounds.block();
			MovieClip(conteneur.getChildByName("Decor")).block();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").block();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").block();
		}
//CHANGEMENT DE DECOR=====================================================================================================
		public function changerDecor(){
	//DEPART CHANGEMENT----------------------------------------------------
			if(changementDecorDepart==true){
				stage.addChild(monMenuStart);
				retourDecor[10]=0;
				block_decor();
				monPad.block();
				changementDecorDepart=false;
			}
	//PORTE CHANGEMENT-----------------------------------------------------
			if(changementDecorPorteArrive==true){
				retourDecor[6]=0;
				if(porteLaterale==false){
					if(monVoileNoir.image==34){sonFermePorte();changementDecorPorteArrive=false;}
				}
				if(porteLaterale==true){
					if(monVoileNoir.image>=34){monPad.control(herosSensPorte,0,0,0);}
					if(monVoileNoir.image>=53&&monVoileNoir.sens==1){monPad.unControl();changementDecorPorteArrive=false;}
				}
			}
			if(changementDecorPorte==true){
				if(monVoileNoir.image==43){
					if(porteLaterale==false){sonOuvrePorte();}
				}
				if(monVoileNoir.image==30){
					miseEnMemoire();
					changementDecor();
					retourDecor[6]=2;
				}
				if(monVoileNoir.image>=30){
					if(porteLaterale==true){herosSensPorte=herosSens;monPad.control(herosSens,0,0,0);}
					if(porteLaterale==false){retourDecor[6]=3;}
				}
				if(monVoileNoir.image<25){
					retourDecor[6]=1;
					monVoileNoir.ouvrir();
					changementDecorPorteArrive=true;
					changementDecorPorte=false;
				}
			}
	//DIAL CHANGEMENT----------------------------------------------------
			if(changementDecorDial==true){
				if(monVoileNoir.image==31){
					MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").forceSuivant=true;
					Decor(conteneur.getChildByName("Decor")).nomLieux=MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").porteChange[0];
					Decor(conteneur.getChildByName("Decor")).numeroPorte=MovieClip(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj")).conteneurDial.getChildByName("Dial").porteChange[1];
					changementDecorPorte=true;
					changementDecorDial=false;
				}
			}
	//CINE CHANGEMENT------------------------------------------------------
			if(changementDecorCine==true){
				if(monVoileNoir.image==31){
					changementDecorPorte=true;
					changementDecorCine=false;
				}
			}
	//MORT CHANGEMENT------------------------------------------------------
			if(changementDecorMort==true){
				if(monVoileNoir.image==35){mortMemoire();changementDecor();}
				if(monVoileNoir.image<41){retourDecor[6]=3;}
				if(monVoileNoir.image<20){monVoileNoir.ouvrir();retourDecor[10]=0;changementDecorMort=false;}
			}
		}
//CHANGEMENT DECOR================================================================================================
		public function changementDecor(){
			chargementNouveauDecorEffectue=false;
			var nomLieuxDepart:String;
			var numeroPorte:int;
			
			if(typeNiveau=="cine"){
				nomLieuxDepart=Cinematique(conteneur.getChildByName("Cine")).nomNiveauArrive;
				numeroPorte=Cinematique(conteneur.getChildByName("Cine")).numeroPorteArrive;
				MovieClip(conteneur.getChildByName("Decor")).cineEnCours=cineEnCours=false;
				conteneur.removeChild(Cinematique(conteneur.getChildByName("Cine")));
				typeNiveau="";
			}
			else{
				nomLieuxDepart=Decor(conteneur.getChildByName("Decor")).nomLieux;
				numeroPorte=Decor(conteneur.getChildByName("Decor")).numeroPorte;
			}
			conteneur.removeChild(Decor(conteneur.getChildByName("Decor")));
			conteneur.removeChild(Heros(conteneur.getChildByName("Heros")));

			System.gc();
			if(changementDecorPorte==true){monLieux.changerLieux(nomLieuxDepart,numeroPorte);}
			
			charger_carte(monLieux.donnee_niveau);
		}
//CHARGEMENT CARTE=========================================================================================================
		public function charger_carte(plevel:Array){
			var nomNiveau=plevel[0];
			carte_ligne_depart=plevel[1]-8;
			carte_colonne_depart=plevel[2]-8;
			var decorN=plevel[3];
			var numeroHorizon=plevel[4];
			var controlZoom=plevel[5];
			var controlCam=plevel[6];
			var type=plevel[7];
			var idType=plevel[8];
			for(var n:int=0;n<gestionChargement.cartesLieux.length;n++){
				if(gestionChargement.cartesLieux[n][0][1]==nomNiveau){
					cartesNiveaux=gestionChargement.cartesLieux[n];
				}
			}
			var monHeros:Heros=new Heros(type,idType);
			var monDecor:Decor=new Decor(carte_colonne_depart,
										 carte_ligne_depart,
										 numeroHorizon,
										 controlZoom,
										 controlCam,
										 type,
										 idType,
										 cartesNiveaux,
										 listePnjXML
										 );
			
			conteneur.addChild(monDecor);
			monDecor.name="Decor";
			conteneur.addChild(monHeros);
			monHeros.name="Heros";
			
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").memoireMonstres=memoireMonstres;
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").memoirePnj=memoirePnj;
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").memoireItems=memoireItems;
			
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("PlateformeSpeciale").startPlateformes();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").startMonstres();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").startPnj();
			MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").startItems();
			
			if(type=="cine"){
				MovieClip(conteneur.getChildByName("Decor")).cineEnCours=cineEnCours=true;
				var niveauCine:Array=[nomNiveau,decorN,numeroHorizon,carte_ligne_depart+8,carte_colonne_depart+8,controlZoom,controlCam];
				var maCinematique=new Cinematique(cineXML,idType,niveauCine);
				maCinematique.name="Cine";
				conteneur.addChild(maCinematique);
				typeNiveau=type;
			}else{
				MovieClip(conteneur.getChildByName("Decor")).cineEnCours=cineEnCours=false;;
			}
			chargementNouveauDecorEffectue=true;
		}
//FUNCTION MEMOIRE=============================================================================================================
		public function miseEnMemoire(){
			piecesMemoire=monInventaire.nombrePieces;
			for(var nC:int=0;nC<monInventaire.tableauCle.length;nC++){
				cleMemoire[nC]=monInventaire.tableauCle[nC];
			}
			memoireItems=(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Items").memoireItems);
			memoireMonstres=(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Monstres").memoireMonstres);
			memoirePnj=(MovieClip(conteneur.getChildByName("Decor")).conteneur.getChildByName("Pnj").memoirePnj);
			
			for(var nInvt:int;nInvt<monInventaire.inventaireRetour.length;nInvt++){
				memoireInventaire[nInvt]=monInventaire.inventaireRetour[nInvt];
			}
			for(var nI:int=0; nI<memoireItems.length; nI++){
				if(memoireItems[nI][0]=="Jour"&&memoireItems[nI][1]==monLieux.donnee_niveau[0]&&memoireItems[nI][2]=="Items"){
					memoireItems[nI][4]=true;
				}
			}
			for(var nM:int=0; nM<memoireMonstres.length; nM++){
				if(memoireMonstres[nM][0]=="Jour"&&memoireMonstres[nM][1]==monLieux.donnee_niveau[0]&&memoireMonstres[nM][2]=="Monstres"){
					memoireMonstres[nM][4]=true;
				}
			}
			for(var nP:int=0; nP<memoirePnj.length; nP++){
				if(memoirePnj[nP][0]=="Jour"&&memoirePnj[nP][1]==monLieux.donnee_niveau[0]&&memoirePnj[nP][2]=="Pnj"){
					memoirePnj[nP][4]=true;
				}
			}
		}
		public function mortMemoire(){
			monInventaire.nombrePieces=piecesMemoire;
			monInventaire.tableauCle=[];
			for(var nC:int=0;nC<cleMemoire.length;nC++){
				monInventaire.tableauCle[nC]=cleMemoire[nC];
			}
			var nI:int=memoireItems.length-1;
			for(var nInvt:int;nInvt<memoireInventaire.length;nInvt++){
				monInventaire.modifierInvt(nInvt,memoireInventaire[nInvt],false);
			}
			while(nI>=0){
				if(memoireItems[nI][0]=="Jour"&&memoireItems[nI][1]==monLieux.donnee_niveau[0]&&memoireItems[nI][2]=="Items"&&memoireItems[nI][4]==false){memoireItems.splice(nI,1);}
				nI--;
			}
			for(var nM:Number=0; nM<memoireMonstres.length; nM++){
				var monstre:int=memoireItems[nM];
				if(memoireMonstres[monstre][0]==("Jour")
					&&memoireMonstres[monstre][1]==monLieux.donnee_niveau[0]
					&&memoireMonstres[monstre][2]=="Monstres"
					&&memoireMonstres[monstre][4]==false){
					memoireMonstres.splice(monstre,1);
				}
			}
		}
	}
}