package{
	
	import flash.display.*;	
	import flash.utils.*;
	import flash.events.*;
	
	
	public class Decor extends MovieClip{
		
		public var chargementTermine:Boolean=false;
		
		public var conteneur:MovieClip=new MovieClip;
		public var conteneurFond:Sprite=new Sprite;
		public var fondN2:Sprite=new Sprite;
		public var fondN3:Sprite=new Sprite;
		
		public var maCamera:CameraGestion=new CameraGestion();
		
		public var numeroHorizon:int;
		
		public var nomLieux:String;
		public var nomMonde:String;
		
		public var cartes:Array=new Array();
		public var carteDecor:Array;
		
		private var premiere_ligne:Number=0;
		private var premiere_colonne:Number=0;
		private var derniere_ligne:Number=0;
		private var derniere_colonne:Number=0;
		private var carte_ligne:Number=0 ;
		private var carte_colonne:Number=0 ;
		
		public var mesCases:Cases=new Cases;
		
		private var carte_ligne_depart:Number=0;
		private var carte_colonne_depart:Number=0;
		private var carte_ligne_departN2:Number=0;
		private var carte_colonne_departN2:Number=0;
		private var carte_ligne_departN3:Number=0;
		private var carte_colonne_departN3:Number=0;
		
		public var decalage_x_departN2:int=0;
		public var decalage_y_departN2:int=0;
		public var decalage_x_departN3:int=0;
		public var decalage_y_departN3:int=0;
		
		public var departN2_x:int=0
		public var departN2_y:int=0
		public var departN3_x:int=0
		public var departN3_y:int=0
		
		public var decorDroite:Boolean=false;
		public var decorGauche:Boolean=false;
		public var decorHaut:Boolean=false;
		public var decorBas:Boolean=false;
		
		public var decalage_Fond_x:Number=0;
		public var decalage_Fond_y:Number=0;
		private var decalage_x:int=0;
		private var decalage_y:int=0;
	
		public var vitesseDG:uint=4;
		public var vitesseHB:uint=4;
//valeur Camera======================================================			
		public var controlZoom:int=0;
		public var controlCam:int=0;
//valeur Elan et DG======================================================	
		public var inertie:int=1
		public var elanDG:int=0;
		public var elanDG_max:int=64;
		private var tempsHaut:Number=0;
		private var sensDG:int=0;
//valeur DoubleTouch=====================================================
		private var timeTouch:int=0;
		private var noTouch:Boolean=true;
		private var touch:Boolean=false;
		private var lTouch:Boolean=false;
		private var dTouch:Boolean=false;
		private var sensTouch:int=0;
//valeur Cours===========================================================
		public var cours:Boolean=false;
		public var coursFin:Boolean=false;
		public var derapageCours=false;
		public var derapage=false;
		private var derapageTime:int=0;
		private var sensCours:int=0;
		private var longueurCours:int=0;
		private var longueurCoursSaut:int=0;
//valeur Cogne==========================================================
		public var cogne:Boolean=false;
//valeur Attack==========================================================
		public var attack:Boolean=false;
//valeur Vitesse=========================================================
		public var vitesseMarche:int=0;
		private var longueurCours_max:int=16;
		private var vitesseTresRapide:int=32;
		public var vitesseRapide:int=16;
		public var vitesseLente:int=8;
		public var vitesseTresLente:int=4;
		public var blockVitesseMarche:int=0;
//=======================================================================
		public var decorSens:Array=new Array();
		public var herosSens:int=0;
		private var droiteGauche:int=0;
		private var hautBas:int=0;
		private var saut:Boolean=false;
		private var saut_lance:Boolean=false;
//valeur saut============================================================
		
		private var recupTombe:int=0;
		private var recup_effectue:Boolean=false;
		
		public var tombe:Boolean=false;
		public var ptombe:Boolean=false;
		public var saute:Boolean=false;
		
		private var acrocheEchelles:Boolean=false;
		private var hauteur_saut_max:Number=0;
		public var hauteur_saut_min:Number=0;
		private var hauteur_tombe_max:Number=0;
		private var hauteur_saut:Number=0;
		private var hauteur_tombe:Number=0;
		private var depfond_y:int=0;
		private var saut_actif:Boolean=false;
		
//valeur plateformeSpe============================================================
		private var decalageY_PS:int=0;
		private var sens_PS:int=0;	
		private var vitesse_PS:int=0;
		private var touchePSpe:Boolean=false;
//Valeur Sons=========================================================================
		public var sonsZone:int=0;
//Valeur Sons=========================================================================
		public var inventaire:Array=new Array();
//==================================================================================
		private var block_time:int=0;
		
		private var appuie_saut_effectue:Boolean=true;
		public var saut_autorise:Boolean=true;
		private var bas_autorise:Boolean=false;
		
		public var decorDG:Boolean=false;
		public var decorHB:Boolean=false;
		
		public var touche_sol:Boolean=false;
		public var iTouche_sol:Boolean=false;
		
		public var echelles:Boolean=false;
		public var arretDG:Boolean=true;
		public var droite:Boolean=false;
		public var gauche:Boolean=false;
		public var arretHB:Boolean=true;
		public var blockHB:Boolean=false;
		public var blockDG:Boolean=false;
		public var haut:Boolean=true;
		public var bas:Boolean=true;
		
		public var peurTombe:Boolean;
		private var tomber_mort:int=0;
		public var mort:Boolean=false;
		public var mortTombe:Boolean=false;
		
		private var porte_ouverte:Boolean=true;
		private var porte_laterale_ouverte:Boolean=false;
		public var numeroPorte:int=0;
		
		public var numeroObjet:int=0;
		public var interactionDecor:Array=[false,0];
		
		public var blocker:Boolean=false;
		
		public var blockHeros:Boolean=false;
		
		public var cineEnCours:Boolean=false;
		
		public var controles:Array=new Array();
		public var retourDecor:Array=new Array();
		
		public function Decor (pcarte_colonne_depart:int,
							   pcarte_ligne_depart:int,
							   pnumeroHorizon:int,
							   pcontrolZoom:int,
							   pcontrolCam:int,
							   ptype:String,
							   pidType:int,
							   pCartes:Array,
							   plistePNJ:XML){
				cartes=pCartes[1];
				carteDecor=cartes[0];
				nomMonde=pCartes[0][0];
				nomLieux=pCartes[0][1];
				carte_ligne_depart=pcarte_ligne_depart;
				carte_colonne_depart=pcarte_colonne_depart;
				
				numeroHorizon=pnumeroHorizon;
				controlZoom=pcontrolZoom;
				controlCam=pcontrolCam;
				var type=ptype;
				var idType=pidType;		
//Depart Camera===================================================================
			if(controlCam==1){maCamera.decalageX=-128;maCamera.decalageX_colonne=4;maCamera.decalageY=-128;}
			if(controlCam==2){maCamera.decalageX=128;maCamera.decalageX_colonne=-4;maCamera.decalageY=-128;}
			if(controlCam==3){maCamera.decalageX=-128;maCamera.decalageX_colonne=4;maCamera.decalageY=0;}
			if(controlCam==4){maCamera.decalageX=128;maCamera.decalageX_colonne=-4;maCamera.decalageY=0;}
			
			fondN2.name="fondN2";
			fondN3.name="fondN3";
		
			var monHorizon:Horizon=new Horizon(numeroHorizon);
			
			var mesMonstres:Monstres=new Monstres(nomMonde,nomLieux,cartes,carte_ligne_depart,carte_colonne_depart,type,idType);
			mesMonstres.name="Monstres";
			
			var mesItems:Items=new Items(nomMonde,nomLieux,cartes,carte_ligne_depart,carte_colonne_depart);
			mesItems.name="Items";
			
			var mesPnj:Pnj=new Pnj(nomMonde,nomLieux,cartes,carte_ligne_depart,carte_colonne_depart,plistePNJ,type,idType);
			mesPnj.name="Pnj";
			
			var mesPlateformeSpeciale:PlateformeSpeciale=new PlateformeSpeciale(nomMonde,nomLieux,cartes,carte_ligne_depart,carte_colonne_depart);
			mesPlateformeSpeciale.name="PlateformeSpeciale";
			
			var monDecorN0:DecorN0=new DecorN0(cartes[0],carte_ligne_depart,carte_colonne_depart);
			monDecorN0.name="N0";
			
			var monDecorN1:DecorN1=new DecorN1(cartes[1],carte_ligne_depart,carte_colonne_depart);
			monDecorN1.name="N1";
			
			carte_ligne_departN2=(Math.ceil(carte_ligne_depart/4));
			carte_colonne_departN2=(Math.ceil(carte_colonne_depart/6));
			var monDecorN2:DecorN2=new DecorN2(cartes[2],carte_ligne_departN2,carte_colonne_departN2);
			monDecorN2.name="N2";
			
			carte_ligne_departN3=(Math.ceil(carte_ligne_depart/20));
			carte_colonne_departN3=(Math.ceil(carte_colonne_depart/30));
			var monDecorN3:DecorN3=new DecorN3(cartes[3],carte_ligne_departN3,carte_colonne_departN3);
			monDecorN3.name="N3";
			
			monHorizon.numeroHorizon=numeroHorizon;
//decalage depart=====================================================================
			
			mesPlateformeSpeciale.carte_ligne_depart=carte_ligne_depart;
			mesPlateformeSpeciale.carte_colonne_depart=carte_colonne_depart;
			
			mesMonstres.carte_ligne_depart=carte_ligne_depart;
			mesMonstres.carte_colonne_depart=carte_colonne_depart;
			
			mesItems.carte_ligne_depart=carte_ligne_depart;
			mesItems.carte_colonne_depart=carte_colonne_depart;
			
			mesPnj.carte_ligne_depart=carte_ligne_depart;
			mesPnj.carte_colonne_depart=carte_colonne_depart;
						
			if(controlZoom!=0){maCamera.zoomCamPas=16;maCamera.zoomIn=true;}else{maCamera.zoomIn=false;}
			
			conteneurFond.addChild(monHorizon);
			fondN3.addChild(monDecorN3);
			fondN2.addChild(monDecorN2);
			conteneurFond.addChild(fondN3);
			conteneurFond.addChild(fondN2);
			conteneur.addChild(conteneurFond);
			conteneur.addChild(monDecorN1);
			conteneur.addChild(monDecorN0);
			conteneur.addChild(mesPlateformeSpeciale);
			conteneur.addChild(mesItems);
			conteneur.addChild(mesPnj);
			conteneur.addChild(mesMonstres);
			conteneur.addChild(maCamera);
			
			addChild(conteneur);
		}
//deplacer decor========================================================================================================================
	//cine--------------------------------------------------------------
		public function deplacerDecorCine(deplacer){
			
			deplacerDecor(controles,retourDecor);
			var deplacerX:int=deplacer[0];
			var deplacerY:int=deplacer[1];
			vitesseDG=deplacer[2];
			vitesseHB=deplacer[3];
			
			if(deplacerX==1){deplace_fond_gauche ();}
			if(deplacerX==-1){deplace_fond_droite ();}
			if(deplacerY==1){deplace_fond_haut ();}
			if(deplacerY==-1){deplace_fond_bas ();}
			
			
		}
	//plateforme---------------------------------------------------------
		public function deplacerDecor(controles=0,controlesDecor=0){
			retourDecor=controlesDecor;
			decorSens=[0,0];
			if(cineEnCours==false){
				
				hautBas=controles[3];
				if((hautBas==-1&&touche_sol==true)||cogne==true){droiteGauche=0;}else{droiteGauche=controles[0];}
				saut=padSaute(controles[1]);
			
				function padSaute(pcontrol:int):Boolean{
					var control:Boolean=false;
					if(pcontrol==1){
						control=true;
					}else{
						control=false;
					}
					return(control);
				}
				runPlus();
				if(controlesDecor[6]==3){blocker=true;}
				
				if(blocker==false&&(maCamera.blocker==false)){run();}
			}
			if(cineEnCours==true){
				runPlus();
			}
//FONCTION RUN======================================================================================================RUN...................
			
			function run(){				
//controles Droite Gauche[0]............................................................................................DROITE GAUCHE.....
				if(sensHeros()!=0){
					if(sensHeros()==1){herosSens=1;allerDroite();
						arretDG=false;
						droite=true;
						gauche=false;
					}
					if(sensHeros()==-1){herosSens=-1;allerGauche();
						arretDG=false;
						droite=false;
						gauche=true;
					}
				}else{herosSens=0;arretDG=true;}
				
//controles Cours..............................................................................................................COURS......
				gestionVitesse();
				if(doubleTouch()==true&&cours==false&&inventaire[2]!=0){
					sensTouch=0;dTouch=false;
					longueurCours=0;sensCours=sensDG;cours=true;
				}
//controles Haut Bas[3]......................................................................................................HAUT BAS.....
				if((maCamera.decalageX<=-192||maCamera.decalageX>=192)&&porte_laterale_ouverte==false){
					numeroPorte=maCamera.numeroPorte;
					stage.dispatchEvent(new Event("ouvre_porteLaterale"));
					porte_laterale_ouverte=true;
				}
				interactionDecor=[false,0];
				if(hautBas!=0&&controlesDecor[10]!=2){
					if(hautBas==1){
						if(fEchelles()==true){
							arretHB=false;
							allerHaut();
						}else{
							if(Items(conteneur.getChildByName("Items")).porteFermeCle==false&&Items(conteneur.getChildByName("Items")).serrureOuvrir==true){porte_ouverte=true;}
							if(testerPorte()==true&&porte_ouverte==false&&touche_sol==true&&Items(conteneur.getChildByName("Items")).porteFermeCle==false){
								stage.dispatchEvent(new Event("ouvre_porte"));porte_ouverte=true;
							}
							else if(testerObjet()==true&&numeroObjet!=0&&touche_sol==true){
								interactionDecor=[true,numeroObjet];
							}
						}
					}
					if(hautBas==-1){
						if(fEchelles()==true){
							arretHB=false;
							allerBas();
						}
					}
				}else{
					arretHB=true;
					porte_ouverte=false;
					if((tester_echelles()==false||tester_echelles_fin()==false)&&droiteGauche!=0){echelles=false;}
				}
//controles de saut[1].........................................................................................................SAUT.......
				if(saut==true){
					if(blockHB==true){saut_autorise=false;}
					if((touche_sol==true||saut_actif==true)&&saut_autorise==true){
							sauter();touche_sol=false; 
							if(hauteur_saut<hauteur_saut_min){saut_lance=true;}
							if(hauteur_saut>hauteur_saut_min){saut_lance=false;if(blockDG==true){saut_autorise=false;}}
					}else{saut_autorise=false;hauteur_saut=0;saut_lance=false;saut_actif=false;tomber();}		
				}else{
					if(blockHB==true){saut_autorise=false;}
					if(hauteur_saut<=hauteur_saut_min&&saut_lance==true){sauter();}else{tomber();saut_autorise=false;}
					if(hauteur_saut>=hauteur_saut_min){saut_lance=false;saut_autorise=false;}
					if(touche_sol==true||fEchelles()==true){saut_autorise=true;hauteur_saut=0;saut_lance=false;}
				}
//controles BolockHeros..................................................................................................................
				if(Items(conteneur.getChildByName("Items")).blockPorte==true){blockHeros=true;}
				if(MovieClip(conteneur.getChildByName("Pnj")).blockHeros==true){blockHeros=true;}
				if((Items(conteneur.getChildByName("Items")).blockPorte==false&&
					MovieClip(conteneur.getChildByName("Pnj")).blockHeros==false)||
					(herosSens!=sensDG))
				{blockHeros=false;}
				if(blockHeros==true){blockDG=true;}
//controles se cogner........................................................................................................
				if((coursFin==true||cours==true)&&blockDG==true){
					blockHB=true
					seCogner();
				}
//controles attaque[4].......................................................................................................ATTACK.......
				if(controles[4]!=0){
					cours=false;
					elanDG=0;
					vitesseDG=4;
					inertie=0;
				}
//controles plateforme mouvante..............................................................................................ATTACK.......
				if(plateformeSpeciale()==true){
					if(touchePSpe==true){if(vitesse_PS>4){vitesseHB=vitesseLente;}else{vitesseHB=vitesseTresLente;}
						if(sens_PS==3){allerHaut();}
						if(sens_PS==4){allerBas();}
						if(sensHeros()==0){
							if(sens_PS==1){allerDroite();}
							if(sens_PS==2){allerGauche();}
						}
					}
				}
//controles escalier.............................................................................................................
				if(fEscalier()==true){allerHaut();
					if(decalage_Fond_x>0){
						if(decalage_Fond_y>=-decalage_Fond_x){
							vitesseDG=vitesseHB=vitesseTresLente;touche_sol=true;
						}
					}
				}
//function mort...............................................................................................................MORT..........
				if(tester_eau()==false){stage.dispatchEvent(new Event("mort_eau"));}
				if(tomber_mort>12){peurTombe=true;}else{peurTombe=false}
				if(tomber_mort>=24){mortTombe=true;}
				if(mortTombe==true&&touche_sol==true){stage.dispatchEvent(new Event("mort_tombe"));}
				if(droiteGauche==0&&hautBas==0&&saut==false&&tomber==false){arretHB=true;arretDG=true;}
				if(blockDG==true||droiteGauche==0){decorDG=false;}else{decorDG=true;}
				if(blockHB==true||(hautBas==0&&saut==false)){decorHB=false;}else{decorHB=true;}
				if(touche_sol==true&&cogne==false){blockHB=false;}
				
				if(Items(conteneur.getChildByName("Items")).porteCote==true){vitesseDG=vitesseTresLente;}
				
//son de zone...................................................................................................
				DecorN1(conteneur.getChildByName("N1")).testerSons();
			}
// RUN PLUS=========================================================================================================================================
			function runPlus(){
				
				maCamera.decalage_Fond_x=decalage_Fond_x;
				maCamera.decalage_Fond_y=decalage_Fond_y;
//CONTROLES CAMERA............................................................................................
				maCamera.carte=Monstres(conteneur.getChildByName("Monstres")).carteMonstres;
				maCamera.carte_ligne_depart=carte_ligne_depart;
				maCamera.carte_colonne_depart=carte_colonne_depart;
				maCamera.blockDG=blockDG;
				maCamera.carte_ligne=carte_ligne;
				maCamera.carte_colonne=carte_colonne;
				maCamera.saut=saut;
				maCamera.touche_sol=touche_sol;
				maCamera.arretDG=arretDG;
				maCamera.arretHB=arretHB;	
				
				Items(conteneur.getChildByName("Items")).deplacer_Items(controles,controlesDecor);
				PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).deplacer_Plateforme(controles,controlesDecor);
				Monstres(conteneur.getChildByName("Monstres")).deplacer_PNJ(controles,controlesDecor);
				Pnj(conteneur.getChildByName("Pnj")).deplacer_Pnj(controles,controlesDecor);
				Items(conteneur.getChildByName("Items")).monstreTouche=Monstres(conteneur.getChildByName("Monstres")).monstreTouche;
				Items(conteneur.getChildByName("Items")).touche_sol=touche_sol;
			}
		}
//GESTION DEPLACEMENT============================================================================================================
		public function sensHeros():int{
			var control:int;
			if(echelles==true||blockDG==true){elanDG=0;}
			
			if(elanDG>-elanDG_max/16&&elanDG<elanDG_max/16){inertie=1;}else{
				if(droiteGauche==0){inertie=2;}else{
					if(touche_sol==true){
						if(droiteGauche==sensDG){inertie=4;}else{inertie=3;}
					}else{
						if(droiteGauche==sensDG){inertie=2;}else{inertie=1;}
					}
				}
			}
			if(droiteGauche==1){elanDG+=inertie;}
			if(droiteGauche==-1){elanDG-=inertie;}
			if(droiteGauche==0){
				if(elanDG>0){elanDG-=inertie;}
				if(elanDG<0){elanDG+=inertie;}
			}
			if(elanDG<=-elanDG_max){elanDG=-elanDG_max;}
			if(elanDG>=elanDG_max){elanDG=elanDG_max;}
			if(elanDG>0){control=1;sensDG=1;}
			if(elanDG<0){control=-1;sensDG=-1;}
			if(elanDG==0){control=0;sensDG=0;}
			if(droiteGauche!=0&&droiteGauche!=sensDG&&touche_sol==true){derapage=true}else{derapage=false;}
			return(control);
		}
		public function doubleTouch():Boolean{
			var control:Boolean;
			if(touche_sol==true){
				if(droiteGauche==0&&touch==false){noTouch=true;}
				if(noTouch==true&&droiteGauche!=0){sensTouch=droiteGauche;timeTouch=0;touch=true;noTouch=false;}
				if(timeTouch<=7){timeTouch+=1;}
				if(touch==true&&timeTouch<=7){
					if(droiteGauche==0){lTouch=true;}
				}else{touch=false;lTouch=false;}
				if(lTouch==true&&droiteGauche==sensTouch&&timeTouch<=7){dTouch=true;}
				if(dTouch==true&&droiteGauche!=sensTouch){sensTouch=0;dTouch=false}
			}
			
			if(dTouch==true&&sensDG==sensTouch){control=true;}else{control=false;}
			return(control);
		}
//GESTION VITESSE==================================================================================================
		public function gestionVitesse(){
			elanDG_max=92+(longueurCours*8);
			if(mort==true){vitesseDG=0;}else{
				switch(inventaire[2]){//GESTION CHAUSURE.................
					case 2: longueurCours_max=32;break;
					default: longueurCours_max=16;break;
				}
				if(cours==true){
					if(sensCours!=droiteGauche||longueurCours>=longueurCours_max){
						derapageCours=true;
						elanDG=elanDG_max*sensCours;sensDG=sensCours;cours=false;
					}else{
						vitesseMarche=3;
						if(iTouche_sol==true){longueurCours=longueurCours_max;}
						if(touche_sol==false){longueurCoursSaut=longueurCours}else{longueurCoursSaut=0;longueurCours+=1;}
						if(longueurCours>longueurCours_max-longueurCours_max/2){coursFin=true;}else{coursFin=false;}
					}
				}
				if(cours==false){
					coursFin=false;
					if(derapageCours==true){
						if(elanDG!=0&&derapageTime<8){vitesseMarche=2;derapageTime+=1;}else{derapageTime=0;derapageCours=false;}
					}else{
						if(elanDG>-(elanDG_max-1)&&elanDG<(elanDG_max-1)){vitesseMarche=1;}else{vitesseMarche=2;}
						longueurCours=0;
					}
				}
				if(touchePSpe==true&&(sens_PS==1||sens_PS==2)){
					var sP:int=0;
					var sH:int=sensHeros();
					if(sens_PS==1){sP=1;}
					if(sens_PS==2){sP=-1;}
					if(sH!=0){
						if(sH==sP){
							if(vitesseMarche==1){vitesseMarche=2;}
						}
						if(sH!=sP){
							if(vitesseMarche==1){vitesseMarche=0;}
							if(vitesseMarche==2){vitesseMarche=1;}
						}
					}else{vitesseMarche=1;}
				}
//CORRECTION DECALAGE====================================================================================================================
				if(fEscalier()==true){vitesseMarche=1;}
				if(tombe==true){
					if(vitesseMarche==2){
						if(vitesseHB==vitesseRapide){vitesseDG=vitesseTresLente;}
						if(vitesseHB<=vitesseRapide){if(decalage_Fond_x%8!=0){vitesseDG=vitesseTresLente;}else{vitesseDG=vitesseLente;}}
					}else{vitesseDG=vitesseTresLente;}
					if(vitesseMarche==3){
						if(vitesseHB==vitesseRapide){vitesseDG=vitesseTresLente;}
						if(vitesseHB<=vitesseLente){if(decalage_Fond_x%8!=0){vitesseDG=vitesseTresLente;}else{vitesseDG=vitesseLente;}}
					}else{vitesseDG=vitesseTresLente;if(fEscalier()==true){vitesseMarche=1;}}
				}else{
					if(blockVitesseMarche!=0){vitesseDG=blockVitesseMarche}else{
						switch(vitesseMarche){
							case 0: vitesseDG=0; break;
							case 1: vitesseDG=vitesseTresLente; break;
							case 2: if(decalage_Fond_x%8!=0){vitesseDG=vitesseTresLente;}else{vitesseDG=vitesseLente;}; break;
							case 3: if(decalage_Fond_x%16!=0){vitesseDG=vitesseTresLente;}else{vitesseDG=vitesseRapide;}; break;
							case 4: if(decalage_Fond_x%32!=0){vitesseDG=vitesseTresLente;}else{vitesseDG=vitesseTresRapide;}; break;
						}
					}
				}
			}
		}
//FONCTION ESCALIER===================================================================================
		public function fEscalier():Boolean{
			var control:Boolean=false;
				if(tester_escalier(sensHeros())==true){control=true;touche_sol=true;}
			
			return(control);
		}
//FONCTION ECHELLES=================================================================================
		public function fEchelles():Boolean{
			var control:Boolean=false;
			if(touche_sol==true){echelles=false;}
			if(tombe==true){acrocheEchelles=true;}
			if(hautBas==1){acrocheEchelles=true;}
			if(tester_echelles_fin()==true&&hautBas==-1){
				echelles=true;
				tomber_mort=0;
				control=true;
				bas_autorise=true;
			}else{
				if(decalage_Fond_y<0){bas_autorise=false;}
				if(tester_echelles_fin()==true&&hautBas==1&&(saut==1||touche_sol==true)){echelles=false;}
				if(tester_echelles()==true&&acrocheEchelles==true&&retourDecor[10]!=2){
					if(touche_sol==false){echelles=true;}
					bas_autorise=false;
					tombe=false;
					tomber_mort=0;
					control=true;
				}
				if((tester_echelles()==false&&tester_echelles_fin()==false)){
					echelles=false;
					control=false;
					acrocheEchelles=false;
				}
			}
			return(control);
		}
//PLATEFORMES SPECIALES================================================================================================================
		public function plateformeSpeciale():Boolean{
			
			var control:Boolean=PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).touchePlateforme;
			decalageY_PS=PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).decalageY;
			sens_PS=PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).sensPlateforme;
			vitesse_PS=PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).vitessePlateforme;
			touchePSpe=PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).arretPlateforme;
			
			return(control);
		}
//GRAVITEE==================================================================================================================================
	//SAUTER======================================================================================
		public function sauter(){
			if(vitesseMarche==3){hauteur_saut_max=(longueurCoursSaut*2)+80;}else{hauteur_saut_max=(vitesseDG*4)+64;}
			hauteur_saut_min=64;
			hauteur_saut+=vitesseHB;
			if(hauteur_saut<=hauteur_saut_min+vitesseDG){
				if(decalage_Fond_y%16!=0){vitesseHB=vitesseTresLente;
				}else{vitesseHB=vitesseRapide;}
			}else{
				if(hauteur_saut>=hauteur_saut_min+vitesseDG){vitesseHB=vitesseTresLente;
				}else{if(decalage_Fond_y%8!=0){vitesseHB=vitesseTresLente;}else{vitesseHB=vitesseLente;}}
			}			
			if(fEchelles()==false){
				if(hauteur_saut<=hauteur_saut_max){saut_actif=true;saute=true;}
				else{saut_autorise=false;saute=false;}
				if(saute==true){allerHaut();}
			}
			if(blockHB==true||echelles==true){hauteur_tombe=0;}else{hauteur_tombe=hauteur_tombe_max=hauteur_saut;}
			
		}
	//TOMBER============================================================================================
		public function tomber(){
			if(touche_sol==false&&plateformeSpeciale()==false&&fEscalier()==false){
				if(blockHB==true||echelles==true){hauteur_tombe=hauteur_tombe_max=0;}
				if(hauteur_tombe>0){hauteur_tombe-=vitesseHB;
					if(hauteur_tombe>=hauteur_tombe_max-vitesseDG*6){
						if(hauteur_tombe>64&&hauteur_tombe>=(hauteur_tombe_max-vitesseDG)){
							vitesseHB=0;tempsHaut+=1;if(tempsHaut>(vitesseDG/8+longueurCoursSaut/8)||saut==false){hauteur_tombe-=vitesseDG/2;tempsHaut=0;}
						}else{
							if(hauteur_tombe>=(hauteur_tombe_max-vitesseDG*3)){
								vitesseHB=vitesseTresLente;
							}else{
								if(decalage_Fond_y%8!=0){vitesseHB=vitesseTresLente;}else{vitesseHB=vitesseLente;}
							}
						}
					}else{
						if(decalage_Fond_y%16!=0){vitesseHB=vitesseTresLente;}else{vitesseHB=vitesseRapide;}
					}
				}else{
					if(decalage_Fond_y%16!=0){vitesseHB=vitesseTresLente;}else{vitesseHB=vitesseRapide;}
					
				}
			}else if(plateformeSpeciale()==true){
				if(decalageY_PS<=8&&touchePSpe==false){
					if(sens_PS==0||sens_PS==1||sens_PS==2){vitesseHB=vitesseTresLente;}
					if(sens_PS==4){
						if(vitesse_PS==8){vitesseHB=vitesseRapide;}else{vitesseHB=vitesseLente;}
					}
					if(sens_PS==3){vitesseHB=0;}
					
				}
				else if(decalageY_PS>8){
					if(vitesse_PS==8){vitesseHB=vitesseRapide;}else{vitesseHB=vitesseLente;}
				}
			}
			if(echelles==true){if(decalage_Fond_y%8!=0){vitesseHB=vitesseTresLente;}else{vitesseHB=vitesseLente;}}
			if((tester_cases_Bas()==true&&decalage_Fond_y==0)||touchePSpe==false){touche_sol=false;}
			if((tester_cases_Bas()==false&&decalage_Fond_y==0)||touchePSpe==true){touche_sol=true;}
			if(touche_sol==false&&fEchelles()==false){bas_autorise=true;tombe=true;}
			if(touche_sol==true||fEchelles()==true){tombe=false;tomber_mort=0;}
			if(tombe==true){allerBas();ptombe=true;}
			if(ptombe==true&&(touche_sol==true||echelles==true)){ptombe=false;iTouche_sol=true;}else{iTouche_sol=false;}
		}
//COGNER=====================================================================================================
		public function seCogner(){
			cogne=true;
			cours=false;
			elanDG=0;
			vitesseDG=0;
			inertie=0;
			blockHB=true;
			var minuteur:Timer=new Timer(500,4);
			
			minuteur.addEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
			minuteur.start();
			
			function minuteurStop(evt:TimerEvent){
				elanDG=0;
				vitesseDG=0;
				inertie=0;
				cogne=false;
				blockHB=false;
				removeMinuteur();
			}
			function removeMinuteur(){
				minuteur.removeEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
			}
		}
//FUNCTION ATTACK==================================================================================================================================
		public function controlHitTestArmes(control:Array){
			Items(conteneur.getChildByName("Items")).controlHitTestArmes(control);
			Monstres(conteneur.getChildByName("Monstres")).controlHitTestArmes(control);
		}
//FUNCTION DEPLACEMENT DECOR==============================================================================================================
		public function allerDroite(){
			if(tester_cases_GD(1)==false||blockHeros==true){
				if(decalage_Fond_x==0){blockDG=true;gauche=false;}
				if(decalage_Fond_x<0){decalage_Fond_x+=vitesseDG;deplace_fond_gauche();maCamera.gestionCameraX(-1,vitesseDG);}
			}
			else{blockDG=false;
				decalage_Fond_x+=vitesseDG;
				if(decalage_Fond_x>63){decalage_Fond_x=0;carte_colonne+=1;}
				deplace_fond_gauche ();maCamera.gestionCameraX(-1,vitesseDG);
			}
		}
		public function allerGauche(){
			decorSens[0]=1;
			if(tester_cases_GD(-1)==false||blockHeros==true){
				if(decalage_Fond_x==0){blockDG=true;droite=false;}
				if(decalage_Fond_x>0){decalage_Fond_x-=vitesseDG;deplace_fond_droite();maCamera.gestionCameraX(1,vitesseDG);}
			}
			else{blockDG=false;
				decalage_Fond_x-=vitesseDG;
				if(decalage_Fond_x<-63){decalage_Fond_x=0;carte_colonne-=1;}
				deplace_fond_droite ();maCamera.gestionCameraX(1,vitesseDG);
			}
		}
		public function allerHaut(){
			if(tester_cases_Haut()==false){
				if(decalage_Fond_y==0){blockHB=true;bas=false;}
				if(decalage_Fond_y>0){decalage_Fond_y-=vitesseHB;deplace_fond_bas();maCamera.gestionCameraY(-1,vitesseHB);}
			}
			else{blockHB=false;
				decalage_Fond_y-=vitesseHB;
				if(decalage_Fond_y<-63){decalage_Fond_y=0;carte_ligne-=1;}
				deplace_fond_bas ();maCamera.gestionCameraY(-1,vitesseHB);
			}
		}
		public function allerBas(){
			if(tester_cases_Bas()==false||bas_autorise==true){
				if(decalage_Fond_y==0){haut=false;}
				if(decalage_Fond_y<0){decalage_Fond_y+=vitesseHB;deplace_fond_haut();maCamera.gestionCameraY(1,vitesseHB);}
			}
			if(tester_cases_Bas()==true||bas_autorise==true){
				decalage_Fond_y+=vitesseHB;
				if(decalage_Fond_y>63){decalage_Fond_y=0;carte_ligne+=1;}
				deplace_fond_haut ();maCamera.gestionCameraY(1,vitesseHB);if(vitesseHB>=16){tomber_mort+=1;}
			}
		}
//functions de test=======================================================================================================================
		public function tester_cases_GD(dSens:Number):Boolean{
			if (tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+dSens+carte_colonne_depart)==2){return false;}
			if ((decalage_Fond_y>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+dSens+carte_colonne_depart))==2){return false;}
			if ((decalage_Fond_y<0)&&(tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+8+dSens+carte_colonne_depart))==2){return false;}
			else{return true;}
		}
		
		public function tester_cases_Haut():Boolean{
			if (tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==2){return false;}
			if ((decalage_Fond_x>0)&&(tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==2){return false;}
			if ((decalage_Fond_x<0)&&(tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==2){return false;}
			else{return true;}
		}
		public function tester_cases_Bas():Boolean{
			if (tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==1){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==1){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x<0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==1){return false;}
			if (tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==2){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==2){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x<0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==2){return false;}
			if (tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==5){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==5){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x<0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==5){return false;}
			if (tester_eau()==false){return false;}
			else{return true;}
		}
		
		public function tester_eau():Boolean{
			if (tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==300){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==300){return false;}
			if ((decalage_Fond_y<1)&&(decalage_Fond_x<0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==300){return false;}
			else{return true;}
		}
		public function tester_escalier(dSens:int):Boolean{
			if (tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==10){return true;}
			if ((decalage_Fond_x>0)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==10){return true;}
			if ((decalage_Fond_x<0)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==10){return true;}
			else{return false;}
		}
		public function testerPorte():Boolean{
			if((decalage_Fond_x<=0)&&
				(decalage_Fond_x>=-20)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)>=10)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)<=30))
				{numeroPorte=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)-11;
				return true;}
			if((decalage_Fond_x>=0)&&
				(decalage_Fond_x<=20)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)>=10)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)<=30))
				{numeroPorte=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)-11;
				return true;}
			if((decalage_Fond_x<=64)&&
				(decalage_Fond_x>=44)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)>=10)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)<=30))
				{numeroPorte=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)-11;
				return true;}
			if((decalage_Fond_x>=-64)&&
				(decalage_Fond_x<=-44)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)>=10)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)<=30))
				{numeroPorte=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)-11;
				return true;}
			else
			{return false;}
		}
		public function testerObjet():Boolean{
			if((decalage_Fond_x<=0)&&
				(decalage_Fond_x>=-20)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)>=700)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)<=710))
				{numeroObjet=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)-699;
				return true;}
			if((decalage_Fond_x>=0)&&
				(decalage_Fond_x<=20)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)>=700)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)<=710))
				{numeroObjet=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)-699;
				return true;}
			if((decalage_Fond_x<=64)&&
				(decalage_Fond_x>=44)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)>=700)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)<=710))
				{numeroObjet=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)-699;
				return true;}
			if((decalage_Fond_x>=-64)&&
				(decalage_Fond_x<=-44)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)>=700)&&
				(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)<=710))
				{numeroObjet=tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)-699;
				return true;}
			else{
				
				return false;
			}
		}
		public function tester_echelles():Boolean{
			if((decalage_Fond_x<=0)&&(decalage_Fond_x>=-16)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==5)){return true;}
			if((decalage_Fond_x>=0)&&(decalage_Fond_x>=48)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)==5)){return true;}
			if((decalage_Fond_x<=0)&&(decalage_Fond_x<=-48)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)==5)){return true;}
			if((decalage_Fond_x>=0)&&(decalage_Fond_x<=16)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==5)){return true;}
				
			if((decalage_Fond_x<=0)&&(decalage_Fond_x>=-16)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==4)){return true;}
			if((decalage_Fond_x>=0)&&(decalage_Fond_x>=48)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)==4)){return true;}
			if((decalage_Fond_x<=0)&&(decalage_Fond_x<=-48)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)==4)){return true;}
			if((decalage_Fond_x>=0)&&(decalage_Fond_x<=16)&&(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==4)){return true;}
			else{return false;}
		}
		public function tester_echelles_fin():Boolean{
			if((decalage_Fond_x<=0)&&(decalage_Fond_x>=-16)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==5)){return true;}
			if((decalage_Fond_x>=0)&&(decalage_Fond_x>=48)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart)==5)){return true;}
			if((decalage_Fond_x<=0)&&(decalage_Fond_x<=-48)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart)==5)){return true;}
			if((decalage_Fond_x>=0)&&(decalage_Fond_x<=16)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==5)){return true;}
			else{return false;}
		}
//TEST==========================================================================================================================TEST.......
		public function tester_case(ligne:int,colonne:int):int{
			var pligne:int=ligne;
			var pcolonne:int=colonne;
			var control:int;
			var monstreControl:int=mesCases.tester_case(pligne,pcolonne,Monstres(conteneur.getChildByName("Monstres")).carteMonstres);
			var decorControl:int=mesCases.tester_case(pligne,pcolonne,carteDecor);
			if(monstreControl==101||monstreControl==100){control=2;}else{control=decorControl;}
			return(control);
		}
//gestion de deplacement des decors========================================================================================================
		public function deplace_fond_droite (){
			decorSens[0]=-1;
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).vitesseDG=vitesseDG;
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).deplacer(1,0);
			
			Monstres(conteneur.getChildByName("Monstres")).vitesseDG=vitesseDG;
			Monstres(conteneur.getChildByName("Monstres")).deplacer (1,0);
			
			Items(conteneur.getChildByName("Items")).vitesseDG=vitesseDG;
			Items(conteneur.getChildByName("Items")).deplacer (1,0);
			
			Pnj(conteneur.getChildByName("Pnj")).vitesseDG=vitesseDG;
			Pnj(conteneur.getChildByName("Pnj")).deplacer (1,0);
			
			DecorN0(conteneur.getChildByName("N0")).vitesseDG=vitesseDG;
			DecorN0(conteneur.getChildByName("N0")).deplacer (1,0);
			
			DecorN1(conteneur.getChildByName("N1")).vitesseDG=vitesseDG;
			DecorN1(conteneur.getChildByName("N1")).deplacer (1,0);
			
			deplacerDecor_fond(1,0);
			
		}
		public function deplace_fond_gauche (){
			decorSens[0]=1;
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).vitesseDG=vitesseDG;
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).deplacer(-1,0);
			
			Monstres(conteneur.getChildByName("Monstres")).vitesseDG=vitesseDG;
			Monstres(conteneur.getChildByName("Monstres")).deplacer (-1,0);
			
			Items(conteneur.getChildByName("Items")).vitesseDG=vitesseDG;
			Items(conteneur.getChildByName("Items")).deplacer (-1,0);
			
			Pnj(conteneur.getChildByName("Pnj")).vitesseDG=vitesseDG;
			Pnj(conteneur.getChildByName("Pnj")).deplacer (-1,0);
			
			DecorN0(conteneur.getChildByName("N0")).vitesseDG=vitesseDG;
			DecorN0(conteneur.getChildByName("N0")).deplacer (-1,0);
			
			DecorN1(conteneur.getChildByName("N1")).vitesseDG=vitesseDG;
			DecorN1(conteneur.getChildByName("N1")).deplacer (-1,0);
			
			deplacerDecor_fond(-1,0);
			
		}
		public function deplace_fond_haut (){
			decorSens[1]=-1;
			arretHB=false;
			bas=true;
			haut=false;
			
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).vitesseHB=vitesseHB;
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).deplacer (0,-1);
			
			Monstres(conteneur.getChildByName("Monstres")).vitesseHB=vitesseHB;
			Monstres(conteneur.getChildByName("Monstres")).deplacer(0,-1);
			
			Items(conteneur.getChildByName("Items")).vitesseHB=vitesseHB;
			Items(conteneur.getChildByName("Items")).deplacer (0,-1);
			
			Pnj(conteneur.getChildByName("Pnj")).vitesseHB=vitesseHB;
			Pnj(conteneur.getChildByName("Pnj")).deplacer (0,-1);
			
			DecorN0(conteneur.getChildByName("N0")).vitesseHB=vitesseHB;
			DecorN0(conteneur.getChildByName("N0")).deplacer (0,-1);
			
			DecorN1(conteneur.getChildByName("N1")).vitesseHB=vitesseHB;
			DecorN1(conteneur.getChildByName("N1")).deplacer (0,-1);
			
			deplacerDecor_fond(0,-1);
			
			
		}
		public function deplace_fond_bas (){
			decorSens[1]=1;
			arretHB=false;
			haut=true;
			bas=false;
			
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).vitesseHB=vitesseHB;
			PlateformeSpeciale(conteneur.getChildByName("PlateformeSpeciale")).deplacer (0,1);
			
			Monstres(conteneur.getChildByName("Monstres")).vitesseHB=vitesseHB;
			Monstres(conteneur.getChildByName("Monstres")).deplacer (0,1);
			
			Items(conteneur.getChildByName("Items")).vitesseHB=vitesseHB;
			Items(conteneur.getChildByName("Items")).deplacer (0,1);
			
			Pnj(conteneur.getChildByName("Pnj")).vitesseHB=vitesseHB;
			Pnj(conteneur.getChildByName("Pnj")).deplacer (0,1);
			
			DecorN0(conteneur.getChildByName("N0")).vitesseHB=vitesseHB;
			DecorN0(conteneur.getChildByName("N0")).deplacer (0,1);
			
			DecorN1(conteneur.getChildByName("N1")).vitesseHB=vitesseHB;
			DecorN1(conteneur.getChildByName("N1")).deplacer (0,1);
			
			deplacerDecor_fond(0,1);
			
			
		}
		public function deplacerDecor_fond(sensDG:int,sensHB:int){
			var coefN2:Number=0.5;
			var coefN3:Number=0.25;
			
			if(sensDG==0){
				DecorN2(fondN2.getChildByName("N2")).vitesseHB=vitesseHB*coefN2;
				DecorN2(fondN2.getChildByName("N2")).deplacer (0,sensHB);
				
				DecorN3(fondN3.getChildByName("N3")).vitesseHB=vitesseHB*coefN3;
				DecorN3(fondN3.getChildByName("N3")).deplacer (0,sensHB);
			}
			if(sensHB==0){
				DecorN2(fondN2.getChildByName("N2")).vitesseDG=vitesseDG*coefN2;
				DecorN2(fondN2.getChildByName("N2")).deplacer (sensDG,0);
				
				DecorN3(fondN3.getChildByName("N3")).vitesseDG=vitesseDG*coefN3;
				DecorN3(fondN3.getChildByName("N3")).deplacer (sensDG,0);
			}
			
		}
		public function block(){blocker=true;}
		public function deblock(){blocker=false;}
	}
}
		