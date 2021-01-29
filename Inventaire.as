package{

	import flash.display.*;
	import flash.text.*;
	import flash.filters.*;
	import flash.utils.*;
	import flash.events.*;
	
	public class Inventaire extends MovieClip{
		
		public var conteneur:MovieClip=new MovieClip;
		public var conteneurObjet:MovieClip=new MovieClip;
		public var conteneurTiket:Sprite= new Sprite();
		
		public var tenue_haut:MovieClip=new MovieClip;
		public var tenue_bas:MovieClip=new MovieClip;
		public var tenue_pieds:MovieClip=new MovieClip;
		
		public var selecteur:MovieClip=new MovieClip;
		private var imageSelecteur:int=1;
		
		public var monInventairePerso:InventaireDetailsPerso=new InventaireDetailsPerso();
		public var monInventaireMagasinAchat:InventaireDetailsMagasinAchat=new InventaireDetailsMagasinAchat();
		public var monInventaireMagasinVente:InventaireDetailsMagasinVente=new InventaireDetailsMagasinVente();
		public var monInventaireSac:InventaireDetailsSac=new InventaireDetailsSac();
		public var monInventaireSelecteur:InventaireDetailsSelecteur=new InventaireDetailsSelecteur();
		public var monCoffre:InventaireDetailsCoffre=new InventaireDetailsCoffre();
		public var mesMainsPNJ:InventaireDetailsPNJ=new InventaireDetailsPNJ();
		
		public var conteneurTableauDeBord:MovieClip=new MovieClip;
		public var monChampPieces:TextField=new TextField;
		public var miseEnFormeChampPieces:TextFormat=new TextFormat();
		public var monVisuelPieces:InventaireDetailsObjetsPieces=new InventaireDetailsObjetsPieces();
		public var tableauCle:Array=new Array();
		public var nombreCleAffiche:int=0;
		public var nombrePieces:int=0;
		public var nombrePiecesAffiche:int=0;
		
		public var objetSelectione:Array=[0,0];
		
		public var invtVisible:Boolean=false;
		public var invtAlpha:Number=0;
		public var boutonLache:Boolean=true;
		
		public var emplacementSac:int=6;
		public var changementSac:Boolean=true;
		
		public var selecteurAffiche:Boolean=false;
		public var selecteurVisible:Boolean=true;
		public var tableauPosition:Array=[[[16,168]],
										[[88,244],[160,244]],
										[[88,316],[160,316]],
										[[16,360]],
										[[]],
										[[]],
										[[]],
										[[]],
										[[]],
										[[]],
										];
		public var emplacementCurseur:Array=[[[0,0]],
										[[0,0],[0,0]],
										[[0,0],[0,0]],
										[[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										];
		public var emplacementCurseurMem:Array=[[[0,0]],
										[[0,0],[0,0]],
										[[0,0],[0,0]],
										[[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										[[0,0],[0,0],[0,0]],
										];
		public var memoireEmplacement:Array=[0,0];
		private var memEmpSelecteur:Array=new Array;		
		public var autoriseCurseur:Boolean=false;
		public var autoriseAppuie:Boolean=false;
		public var autoriseAppuieInvt:Boolean=false;
		public var curseurControl:int=0;
		public var curseurAppuie:Boolean=false;
		public var boutonInvtAppuie:Boolean=false;
		public var selecteurL:int=0;
		public var selecteurC:int=0;
		public var selecteurBlock:Boolean=false;
				
		public var objetPris:Boolean=false;
		public var emplacement:int=0;
		public var affiche:Boolean=false;
		
		public var inventaireRetour:Array=new Array;
		public var changeRetour:Boolean=false;
		
		public var itemsPNJ:Array=new Array();
		
		public var donneObjet:Boolean=false;
		public var demandeObjet:Boolean=false;
		public var magasinObjet:Boolean=false;
		public var magasinVente:Boolean=false;
		public var objetDial:Boolean=false;
		
		public var finDonneObjet:Boolean=false;
		public var objetPrisPNJ:Boolean=false;
		public var objetAchete:Boolean=false;
		public var objetPNJ:Boolean=false;
		public var prixMagasin:int=0;
		public var totalPrix:Array=new Array;
		
		public var changeImposs:Boolean=false;
		public var selectImposs:Boolean=false;
		public var unSelectable:Boolean=false;
		public var reponceItem:int=0;
		
		public var ouvreCoffre:Boolean=false;
		
		public var retourObjet:Array=new Array;
		public var initialisationCoffre:Array=new Array;
		
		public var positionHeros:int=0;
		
		public var emplacementSon:Array=[0,0];
		public var tableauSon:Array=new Array();
		public var sonItem:Array=[false,0];
		public var factureSon:Boolean=false;
		
		public function Inventaire(){
			
			monInventaireSelecteur.gotoAndStop(1);
			monInventaireSelecteur.x=0;
			monInventaireSelecteur.y=-64;
			
			selecteur.addChild(monInventaireSelecteur);
			initTableauDeBord();
			conteneur.addChild(conteneurObjet);
			
			addChild(conteneur);
		}
//RUN==============================================================================================================================================
		public function run(control:Array,dialEnCours:Boolean){
			factureSon=false;
			selecteurBlock=false;
			positionHeros=1;
			boutonInvtAppuie=appuieInvt(control);
			
			if(boutonInvtAppuie==true&&objetPris==false&&dialEnCours==false){
				if(invtVisible==false){invtVisible=true;}else{invtVisible=false;}
				if(ouvreCoffre==true){coffreFerme();}
			}
			if(ouvreCoffre==true){positionHeros=3;coffreOuvert();invtVisible=true;}
			if(donneObjet==true||demandeObjet==true){objetDial=true;objetPNJouvrir(control);invtVisible=true;}
			if(magasinObjet==true){magasinOuvrir(control);invtVisible=true;}
			if(magasinObjet==false&&donneObjet==false&&demandeObjet==false&&finDonneObjet==true){
				objetDial=false;objetPNJfermer();invtVisible=false;
			}
			if(invtVisible==false&&invtAlpha>0){
				retirer();
				selecteurAffiche=false;
				selecteurL=selecteurC=0;
			}
			if(invtVisible==true&&invtAlpha<1){
				afficher();
				if(selecteurAffiche==false){gestionSac();conteneur.addChildAt(selecteur,conteneur.numChildren);selecteur.alpha=0;}
				emplacementSon=[selecteurL,selecteurC];
				autoriseCurseur=false;
			}
			if(invtAlpha>=1){
				curseurControl=deplacementCurseur(control);
				curseurAppuie=selectionCurseur(control);
				if(selecteurVisible==true){
					selecteur.alpha=1;
					selecteurAffiche=true;}else{selecteur.gotoAndStop(1);}
			}
			if(selecteurAffiche==true&&selecteurVisible==true){
				if(curseurControl!=0&&selecteurBlock==false){
					if(memEmpSelecteur[0]==selecteurL&&memEmpSelecteur[1]==selecteurC){selecteurBlock=true;}
					memEmpSelecteur=[selecteurL,selecteurC];
					deplacementSelecteur(curseurControl);
				}
				if(curseurAppuie!=false&&changeImposs==false&&selectImposs==false){appuieSelecteur();}
				monInventaireSelecteur.x=tableauPosition[selecteurL][selecteurC][0];
				monInventaireSelecteur.y=tableauPosition[selecteurL][selecteurC][1]-64;
				affichageSelecteur(control);
			}
			
			conteneur.alpha=invtAlpha;
			
			poubelle();
			retourInventaire();
			retourReponce();
			afficherObjet();
			runTableauDeBord();
			sonInventaire();
			if(monInventaireSelecteur.numChildren<=1){objetSelectione=[0,0];objetPris=false;}
		}
		public function afficher(){affiche=true;
			conteneur.addChildAt(monInventairePerso,0);
			if(invtAlpha<=1){invtAlpha+=0.25;}else{invtAlpha=1;}
		}
		public function retirer(){affiche=false;
			if(invtAlpha==0){
				
				if(monInventairePerso is DisplayObject==true){conteneur.removeChild(monInventairePerso);}
				if(selecteur is DisplayObject==true){conteneur.removeChild(selecteur);}
			}
			while(conteneurObjet.numChildren != 0) {conteneurObjet.removeChildAt(0);}
			emplacementCurseurMem=[[[0,0]],[[0,0],[0,0]],[[0,0],[0,0]],[[0,0]],[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],
									[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],];
			if(invtAlpha>=0){invtAlpha-=0.25;}else{invtAlpha=0;}
		}
		public function resetMemoire(){
			nombrePieces=0;
			emplacementCurseur=[[[0,0]],[[0,0],[0,0]],[[0,0],[0,0]],[[0,0]],[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],
									[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],[[0,0],[0,0],[0,0]],];
		}
//SON===================================================================================================================================
		public function sonInventaire(){
			var sonAppSelecteur:Array=[false,0];
			var sonDepSelecteur:Boolean=false;
			var typeIvnt:int=0;
			if((emplacementSon[0]!=selecteurL||emplacementSon[1]!=selecteurC)&&curseurControl!=0){sonDepSelecteur=true;emplacementSon=[selecteurL,selecteurC];}
			
			sonAppSelecteur[0]=curseurAppuie;
			sonAppSelecteur[1]=imageSelecteur;
			sonAppSelecteur[2]=emplacementCurseur[selecteurL][selecteurC];
			sonAppSelecteur[3]=objetSelectione;
			
			tableauSon=[sonAppSelecteur,sonDepSelecteur,sonItem,factureSon];
			if(sonItem[0]==true){sonItem=[false,0];}
		}
//COFFRE=================================================================================================================================
		public function coffreOuvert(){
			if(invtVisible==false){
				initialiserCoffre();
				
				conteneur.addChildAt(monCoffre,0);
				var tableauTemp:Array=[[376,544],[448,544],[520,544]];
				tableauPosition[6]=tableauTemp;selecteurL=6;selecteurC=0;
			}
		}
		public function coffreFerme(){
			var tableauTemp:Array=[[376,544]];
			initialiserRetourCoffre();
			tableauPosition[6]=tableauTemp;
			for(var n:int=0;n<3;n++){
				emplacementCurseur[6][n][0]=0;
				emplacementCurseur[6][n][1]=0;
			}
			conteneur.removeChild(monCoffre);
			ouvreCoffre=false;
		}
//FERMER OBJET PNJ===================================================================================
		public function objetPNJfermer(){
			
			var tableauTemp:Array=[[376,544]];
			itemsPNJ[0]=0;
			itemsPNJ[1]=0;
			for(var L:int=6;L<emplacementCurseur.length;L++){
				for(var C:int=0;C<emplacementCurseur[L].length;C++){
					emplacementCurseur[L][C][0]=0;
					emplacementCurseur[L][C][1]=0;
				}
			}
			tableauPosition[6]=tableauTemp;
			if(conteneur.getChildByName("monTiket") is DisplayObject==true){conteneur.removeChild(conteneurTiket);}
			if(conteneur.getChildByName("mesMainsPNJ") is DisplayObject==true){conteneur.removeChild(mesMainsPNJ);}
			if(conteneur.getChildByName("InventaireMagasinAchat") is DisplayObject==true){conteneur.removeChild(monInventaireMagasinAchat);}
			if(conteneur.getChildByName("InventaireMagasinVente") is DisplayObject==true){conteneur.removeChild(monInventaireMagasinVente);}
			totalPrix[0]=totalPrix[1]=0;
			selectImposs=false;
			objetAchete=false;
			objetPrisPNJ=false;
			magasinObjet=false;
			finDonneObjet=false;
		}
		public function retourReponce(){
			if(donneObjet==true){if(selecteurL==6&&selecteurC==0){reponceItem=-1;}else{reponceItem=1;}}
			
			if(demandeObjet==true){
				if(emplacementCurseur[6][0][0]==itemsPNJ[0]&&
					emplacementCurseur[6][0][1]==itemsPNJ[1]+1){reponceItem=1;}else{reponceItem=-1;}
			}
			if(magasinObjet==true){
				if(objetAchete==false){reponceItem=-1;}else{reponceItem=1;}
			}
		}
//PNJ==================================================================================================================================================================
	//ouvrie PNJ=======================================================
		public function objetPNJouvrir(control:Array){
			if(invtVisible==false){
				conteneurObjet.alpha=0;
				reponceItem=0;
				var tableauTemp:Array=[[448,544]];
				tableauPosition[6]=tableauTemp;
				mesMainsPNJ.name="mesMainsPNJ";
				conteneur.addChildAt(mesMainsPNJ,0);
				
				if(donneObjet==true){
					monInventairePerso.alpha=0;
					monInventaireSac.alpha=0;
					
					emplacementCurseur[6][0][0]=itemsPNJ[0];
					emplacementCurseur[6][0][1]=itemsPNJ[1]+1;
					selecteurL=6;selecteurC=0;
				}
			}else{
				conteneurObjet.alpha=1;
				if(donneObjet==true){pnjDonneObjet();}
				if(demandeObjet==true){pnjDemandeObjet();}
			}
	//fermer PNJ=====================================================
			function fermerPnj(){
				objetPNJ=false;
				finDonneObjet=true;
				changeImposs=false;
				donneObjet=false;
			}
//demande objet....................................................................................................
			function pnjDemandeObjet(){
				if(objetPris==false){
					
					if(emplacementCurseur[selecteurL][selecteurC][0]!=itemsPNJ[0]||
						emplacementCurseur[selecteurL][selecteurC][1]!=itemsPNJ[1]+1){
						selectImposs=true;
					}else{
						selectImposs=false;
					}
					if(objetPrisPNJ==true){
						//retourInventaire();
						objetPNJ=false;
						finDonneObjet=true;
						selectImposs=false;
						demandeObjet=false;
					}
				}
				if(objetPris==true){
					if(objetPrisPNJ==false){
						memoireEmplacement[0]=selecteurL;
						memoireEmplacement[1]=selecteurC;
					}
					objetPrisPNJ=true;
					selecteurL=6;selecteurC=0;selecteurBlock=true;
				}
				if(boutonInvtAppuie==true){
					if(objetPris==true){
						selecteurL=memoireEmplacement[0];
						selecteurC=memoireEmplacement[1];
						appuieSelecteur();
					}else{
						objetPNJ=false;
						finDonneObjet=true;
						selectImposs=false;
						demandeObjet=false;
					}
				}
			}
			
//donne objet......................................................................................................
			function pnjDonneObjet(){
				for(var L:int=0;L<6;L++){
					for(var C:int=0;C<emplacementCurseur[L].length;C++){
						var nom:String="objet"+[L]+[C];
						var objetAlpha:int=1;
						if(objetPris==false){objetAlpha=0;}
						if(conteneurObjet.getChildByName(nom) is DisplayObject==true){conteneurObjet.getChildByName(nom).alpha=objetAlpha;}
					}
				}
				if(objetPris==true){
					objetPrisPNJ=true;
					monInventairePerso.alpha=1;
					monInventaireSac.alpha=1;
					
					if(emplacementCurseur[selecteurL][selecteurC][0]!=0){changeImposs=true;}else{changeImposs=false;}
					if(boutonInvtAppuie==true){
						selecteurL=6;selecteurC=0;
						appuieSelecteur();
						objetPrisPNJ=false;
						boutonInvtAppuie=false;
					}
				}
				
				if(objetPris==false){
					if(objetPrisPNJ==false){
						if(boutonInvtAppuie==true){fermerPnj();}
					}
					selecteurL=6;selecteurC=0;selecteurBlock=true;
					if(objetPrisPNJ==true){
						 fermerPnj();
					}
				}
			}
		}
//MAGASIN==================================================================================================================================================================
		public function magasinOuvrir(control:Array){
			
			if(invtVisible==false){
				if(magasinVente==false){
					monInventaireMagasinAchat.name="InventaireMagasinAchat";
					conteneur.addChildAt(monInventaireMagasinAchat,0);
					initialiserMagasin();
					selecteurL=7;selecteurC=0;
				}
				if(magasinVente==true){
					monInventaireMagasinVente.name="InventaireMagasinVente";
					conteneur.addChildAt(monInventaireMagasinVente,0);
					initialiserMagasin();
					selecteurL=0;selecteurC=0;
				}
			}else{
				
				if(magasinVente==false){Achat();}
				if(magasinVente==true){Vente();}
			}
			function fermerMagasin(){
				
				finDonneObjet=true;
				magasinObjet=false;
			}
//ACHAT..................................................................
			function Achat(){
				if(objetPris==false){
					if(objetAchete==true){
						fermerMagasin();
					}
					if(objetPrisPNJ==false){
						if(selecteurL<7){selecteurL=7;selecteurC=0;}
						if(selecteurL==7){
							if(control[3]==1){selecteurL=7;selecteurBlock=true;}
							if(control[0]==-1&&selecteurC==0){selecteurL=7;selecteurBlock=true;}
						}else{selecteurBlock=false;}
						if(emplacementCurseur[selecteurL][selecteurC][2]>nombrePieces){unSelectable=false;}else{unSelectable=true;}
						selectImposs=true;
						if(boutonInvtAppuie==true){
							fermerMagasin();
						}
						if(curseurAppuie==true){selectImposs=false;
							if(emplacementCurseur[selecteurL][selecteurC][2]<=nombrePieces){
								var tableauTemp:Array=[[448,544]];
								tableauPosition[6]=tableauTemp;
								mesMainsPNJ.name="mesMainsPNJ";
								conteneur.addChildAt(mesMainsPNJ,0);
								emplacementCurseur[6][0][0]=emplacementCurseur[selecteurL][selecteurC][0];
								emplacementCurseur[6][0][1]=emplacementCurseur[selecteurL][selecteurC][1];
								prixMagasin=emplacementCurseur[selecteurL][selecteurC][2];
								objetPrisPNJ=true;
							}else{unSelectable=false;}
						}
					}
					if(objetPrisPNJ==true){
						if(boutonInvtAppuie==true){
							emplacementCurseur[6][0][0]=0;
							emplacementCurseur[6][0][1]=0;
							prixMagasin=0;
							conteneur.removeChild(mesMainsPNJ);
							objetPrisPNJ=false;
						}
						unSelectable=false;
						selectImposs=false;
						selecteurL=6;selecteurC=0;selecteurBlock=true;
					}
				}
				if(objetPris==true){
					if(selecteurL>5){
						if(emplacementSac<=3){selecteurL=4;}else{selecteurL=5;}
					}
					if(emplacementSac<=3){
						if(selecteurL==4&&(control[0]==1||control[3]==-1)){selecteurBlock=true;}
					}else{
						if(selecteurL==5&&(control[0]==1||control[3]==-1)){selecteurBlock=true;}
					}
					if(objetPrisPNJ==true){
						emplacementCurseurMem[6][0][0]=0;
						emplacementCurseurMem[6][0][1]=0;
						conteneur.removeChild(mesMainsPNJ);
						facture(prixMagasin,true);
						objetAchete=true;
						objetPrisPNJ=false;
					}
				}
				if(invtVisible&&selectImposs==true){animerPrix(selecteurL,selecteurC,control);}
			}
//VENTE..................................................................
			function Vente(){
				if(objetPris==false){
					if(selecteurL>5){
						if(emplacementSac<=3){selecteurL=4;}else{selecteurL=5;}
					}
					if(emplacementSac<=3){
						if(selecteurL==4&&(control[0]==1||control[3]==-1)){selecteurBlock=true;}
					}else{
						if(selecteurL==5&&(control[0]==1||control[3]==-1)){selecteurBlock=true;}
					}
					selectImposs=true;
					if(boutonInvtAppuie==true){
						fermerMagasin();
					}
					for(var o:int=0;o<itemsPNJ.length;o++){
						if(emplacementCurseur[selecteurL][selecteurC][0]==itemsPNJ[o][0]&&
							emplacementCurseur[selecteurL][selecteurC][1]==itemsPNJ[o][1]){
							prixMagasin=itemsPNJ[o-1][2];
							selectImposs=false;
						}
					}
					if(objetAchete==true){
						selectImposs=true;
						selecteur.alpha=0;
						selecteurVisible=false;
						selecteurL=0;selecteurC=0;selecteurBlock=true;
						if(boutonInvtAppuie==true||curseurAppuie==true){
							fermerMagasin();
							selecteurVisible=true;
						}
					}
					if(objetPrisPNJ==true){
						if(boutonInvtAppuie==true){}
						emplacementCurseur[6][0][0]=0;
						emplacementCurseur[6][0][1]=0;
						conteneur.removeChild(mesMainsPNJ);
						totalPrix[0]=nombrePieces;
						totalPrix[1]=nombrePieces+prixMagasin;
						facture(prixMagasin,false);
						objetAchete=true;
						objetPrisPNJ=false;
					}
					
				}
				if(objetPris==true){
					if(objetPrisPNJ==false){
						var tableauTemp:Array=[[448,544]];
						tableauPosition[6]=tableauTemp;
						mesMainsPNJ.name="mesMainsPNJ";
						conteneur.addChildAt(mesMainsPNJ,0);
						memoireEmplacement[0]=selecteurL;
						memoireEmplacement[1]=selecteurC;
						objetPrisPNJ=true;
					}
					if(objetPrisPNJ==true){
						selecteurL=6;selecteurC=0;selecteurBlock=true;
						if(boutonInvtAppuie==true){
							selecteurL=memoireEmplacement[0];
							selecteurC=memoireEmplacement[1];
							appuieSelecteur();
							objetPrisPNJ=false;
						}
					}
				}
			}
//initialise Magasin................................................................................................
			function initialiserMagasin(){
				var ligne:int=0;
				var colonne:int=0;
				
				var tableauTemp:Array=[
				[[736,244],[808,244],[880,244]],
				[[736,332],[808,332],[880,332]],
				[[736,420],[808,420],[880,420]]
				];
				tableauPosition[6]=[];
				tableauPosition[7]=tableauTemp[0];
				tableauPosition[8]=tableauTemp[1];
				tableauPosition[9]=tableauTemp[2];
				
				for(var n:int=0;n<itemsPNJ.length;n++){
					if(colonne<2){colonne=n-ligne*3}else{ligne+=1;colonne=0;}
					emplacementCurseur[7+ligne][colonne][0]=itemsPNJ[n][0];
					emplacementCurseur[7+ligne][colonne][1]=itemsPNJ[n][1]+1;
					emplacementCurseur[7+ligne][colonne][2]=itemsPNJ[n][2];
				}
			}
		}
//GESTION SAC===========================================================================================================================================================
		public function gestionSac(){
			if(emplacementSac>0){conteneur.addChildAt(monInventaireSac,0);}
			if(changementSac==true){
				var tableauTemp1:Array=new Array;
				var tableauTemp2:Array=new Array;
				switch(emplacementSac){
					case 0: ;break;
					case 1: tableauTemp1=[[16,488]];break;
					case 2: tableauTemp1=[[16,488],[88,488]];break;
					case 3: tableauTemp1=[[16,488],[88,488],[160,488]];break;
					case 4: tableauTemp1=[[16,488],[88,488],[160,488]];tableauTemp2=[[16,560]];break;
					case 5: tableauTemp1=[[16,488],[88,488],[160,488]];tableauTemp2=[[16,560],[88,560]];break;
					case 6: tableauTemp1=[[16,488],[88,488],[160,488]];tableauTemp2=[[16,560],[88,560],[160,560]];break;
				}
				tableauPosition[4]=tableauTemp1;
				tableauPosition[5]=tableauTemp2;
				
				for(var e:int;e<emplacementSac;e++){
					var ligneE:int;
					var colonneE:int;
					if(e<=2){ligneE=4;colonneE=e;}
					if(e>2){ligneE=5;colonneE=e-3;}
					var empacement:InventaireDetailsEmplacement=new InventaireDetailsEmplacement();
					empacement.name="emplacement"+e;
					empacement.x=tableauPosition[ligneE][colonneE][0];
					empacement.y=tableauPosition[ligneE][colonneE][1];
					monInventaireSac.addChild(empacement);
				}
				changementSac=false;
			}
		}
//AFFICHAGE SELECTEUR==================================================================================================================================
		public function affichageSelecteur(control:Array){
			var toucheAction:Boolean=curseurAppuie;
			var toucheInvt:Boolean=boutonInvtAppuie;
			if(imageSelecteur!=3&&imageSelecteur!=4){imageSelecteur=1;}
			else if(MovieClip(monInventaireSelecteur.getChildAt(monInventaireSelecteur.numChildren-1)).currentFrame==
					MovieClip(monInventaireSelecteur.getChildAt(monInventaireSelecteur.numChildren-1)).totalFrames){imageSelecteur=1;}
			if((emplacementCurseur[selecteurL][selecteurC][0]==0||(selectImposs==true&&unSelectable==false))&&toucheAction==true){imageSelecteur=4;}
			if(objetPris==true){
				if(toucheInvt==true){imageSelecteur=3;}else{imageSelecteur=2;}
				if(selecteurL==0&&selecteurC==0){imageSelecteur=5;}
			}
			if(changeImposs==true&&toucheAction==true){imageSelecteur=3;}
			
			if(emplacementCurseur[0][0][0]!=0&&selecteurL==0&&selecteurC==0){imageSelecteur=6;}
			
			monInventaireSelecteur.gotoAndStop(imageSelecteur);
		}
//APPUIE SELECTEUR==================================================================================================================================
		public function appuieSelecteur(){
			var nom:String;
			var nomSelect:String;
			
			if(monInventaireSelecteur.numChildren<2){
				if(emplacementCurseur[selecteurL][selecteurC][0]!=0){
					nom="objet"+[selecteurL]+[selecteurC];
					monInventaireSelecteur.addChildAt(conteneurObjet.getChildByName(nom),0);
					monInventaireSelecteur.getChildAt(0).x-=(tableauPosition[selecteurL][selecteurC][0]-44);
					monInventaireSelecteur.getChildAt(0).y-=(tableauPosition[selecteurL][selecteurC][1]-20);
					objetSelectione[0]=emplacementCurseur[selecteurL][selecteurC][0];
					objetSelectione[1]=emplacementCurseur[selecteurL][selecteurC][1];
					emplacementCurseurMem[selecteurL][selecteurC][0]=emplacementCurseur[selecteurL][selecteurC][0]=0;
					emplacementCurseurMem[selecteurL][selecteurC][1]=emplacementCurseur[selecteurL][selecteurC][1]=0;
					objetPris=true;
				}
			}else{
				
				if(emplacementCurseur[selecteurL][selecteurC][0]==0){
					nom="objet"+[selecteurL]+[selecteurC];
					conteneurObjet.addChildAt(monInventaireSelecteur.getChildAt(0),0);
					conteneurObjet.getChildAt(0).name=nom;
					conteneurObjet.getChildByName(nom).x+=tableauPosition[selecteurL][selecteurC][0]-44;
					conteneurObjet.getChildByName(nom).y+=tableauPosition[selecteurL][selecteurC][1]-20;
					emplacementCurseurMem[selecteurL][selecteurC][0]=emplacementCurseur[selecteurL][selecteurC][0]=objetSelectione[0];
					emplacementCurseurMem[selecteurL][selecteurC][1]=emplacementCurseur[selecteurL][selecteurC][1]=objetSelectione[1];
					objetSelectione[0]=0;
					objetSelectione[1]=0;
					objetPris=false;
				}else{
					
					var osTemp0:int;
					var osTemp1:int;
					
					nom="objet"+[selecteurL]+[selecteurC];
					monInventaireSelecteur.addChildAt(conteneurObjet.getChildByName(nom),0);
					conteneurObjet.addChildAt(monInventaireSelecteur.getChildAt(1),0);
					conteneurObjet.getChildAt(0).name=nom;
					conteneurObjet.getChildByName(nom).x+=tableauPosition[selecteurL][selecteurC][0]-44;
					conteneurObjet.getChildByName(nom).y+=tableauPosition[selecteurL][selecteurC][1]-20;
					monInventaireSelecteur.getChildAt(0).x-=(tableauPosition[selecteurL][selecteurC][0]-44);
					monInventaireSelecteur.getChildAt(0).y-=(tableauPosition[selecteurL][selecteurC][1]-20);
					osTemp0=objetSelectione[0];
					osTemp1=objetSelectione[1];
					objetSelectione[0]=emplacementCurseur[selecteurL][selecteurC][0];
					objetSelectione[1]=emplacementCurseur[selecteurL][selecteurC][1];
					emplacementCurseurMem[selecteurL][selecteurC][0]=emplacementCurseur[selecteurL][selecteurC][0]=osTemp0;
					emplacementCurseurMem[selecteurL][selecteurC][1]=emplacementCurseur[selecteurL][selecteurC][1]=osTemp1;
					objetPris=true;
				}
			}
			if(objetSelectione[0]==1||objetSelectione[0]==2){
				switch(objetSelectione[0]){
					case 1: 
					switch(objetSelectione[1]){
						case 2: nombrePieces+=1;break;
						case 3: nombrePieces+=3;break;
						case 4: nombrePieces+=5;break;
					};break;
					case 2:
					switch(objetSelectione[1]){
						case 2: ajouterCle(1);break;
						case 3: ajouterCle(2);break;
						case 4: ajouterCle(3);break;
					};break;
				}
				monInventaireSelecteur.removeChildAt(0);
			}
		}
//DEPLACEMENT SELECTEUR==================================================================================================================================
		public function deplacementSelecteur(curseur:int){
			var longueur:int;
			if(magasinObjet==true){longueur=10;}
			else if(ouvreCoffre==true||objetDial==true){longueur=7;}
			else if(emplacementSac>=3){longueur=6;}
			else{longueur=5;}		
			
			if(selecteurL<=0){emplacement=0;}
			if(selecteurL>=1&&selecteurL<=3){emplacement=1;}
			if(selecteurL>=4&&selecteurL<=5){emplacement=2;}
			if(selecteurL>=6&&selecteurL<7){emplacement=4;}
			if(selecteurL>=7){emplacement=5;}
				
			if(curseur!=0){
				switch(curseur){
					case 1: if(selecteurC>0){
								selecteurC-=1
							}else{
								if(selecteurL==2&&selecteurC==0){
									selecteurL=3;selecteurC=0;
								}else{
									if(selecteurL>0){
										if(tableauPosition[selecteurL-1].length>0){selecteurL-=1;}else{
											for(var g:int=selecteurL-1;g>0;g--){
												if(tableauPosition[g].length>0){selecteurL=g;g=0;}
											}
										}
									};
									selecteurC=tableauPosition[selecteurL].length-1;
								}
							};break;
					case 2: if(selecteurC<tableauPosition[selecteurL].length-1){
								selecteurC+=1;
							}else{
								if(selecteurL==3&&selecteurC==0){
									selecteurL=2;selecteurC=0;
								}else{
									if(selecteurL<longueur-1){
										if(tableauPosition[selecteurL+1].length>0){selecteurL+=1;}else{
											for(var d:int=selecteurL+1;d<longueur;d++){
												if(tableauPosition[d].length>0){selecteurL=d;d=longueur-1;}
											}
										}
									}
									selecteurC=0;
								}
							} ;break;
					case 3: if(selecteurL>0){
								
								if(tableauPosition[selecteurL-1].length>0){selecteurL-=1;}else{
									for(var h:int=selecteurL-1;h>0;h--){
										if(tableauPosition[h].length>0){selecteurL=h;h=0;}
									}
								}
								if(selecteurC>tableauPosition[selecteurL].length-1){
								selecteurC=tableauPosition[selecteurL].length-1;
								}
							};break;
					case 4: if(selecteurL<longueur-1){
								if(tableauPosition[selecteurL+1].length>0){selecteurL+=1;}else{
									for(var b:int=selecteurL+1;b<longueur;b++){
										if(tableauPosition[b].length>0){selecteurL=b;b=longueur-1;}
									}
								}
								if(selecteurC>tableauPosition[selecteurL].length-1){
								selecteurC=tableauPosition[selecteurL].length-1;
								}
							};break;
				}
				if(objetPris==true){
					var l:int=selecteurL;
					var c:int=selecteurC;
					if(emplacement==0||(emplacement==2&&selecteurL<=3)){
						
						switch(objetSelectione[0]){
							case 0: ;break;
							case 1: l=4;c=0;break;
							case 2: l=4;c=0;break;
						
							case 3: l=1;c=1;break;
							case 4: l=2;c=1;break;
						
							case 5: l=1;c=0;break;
							case 6: l=2;c=0;break;
							case 7: l=3;c=0;break;
							default: ;break;
						}
					}
					else if(emplacement==1){
						if(curseur==1||curseur==3){l=0;c=0;}
						if(curseur==2||curseur==4){l=4;c=0;}
					}else{
						l=selecteurL;c=selecteurC;
					}
					selecteurL=l;selecteurC=c;
				}
			}
		}
//AFFICHE OBJET==========================================================================================================================================
		public function afficherObjet(){
			var longueur:int;
			if(magasinObjet==true){longueur=10;}
			else if(ouvreCoffre==true||objetDial==true){longueur=7;}
			else if(emplacementSac>=3){longueur=6;}
			else{longueur=5;}	
			for(var L:int=0;L<longueur;L++){
				for(var C:int=0;C<emplacementCurseur[L].length;C++){
					if(emplacementCurseur[L][C][0]!=0&&
						(emplacementCurseur[L][C][0]!=emplacementCurseurMem[L][C][0]||
						emplacementCurseur[L][C][1]!=emplacementCurseurMem[L][C][1])){
						if(conteneurObjet.getChildByName("objet"+[L]+[C]) is DisplayObject==true){
								conteneurObjet.removeChild(conteneurObjet.getChildByName("objet"+[L]+[C]));
						}
						affichage();
						emplacementCurseurMem[L][C][0]=emplacementCurseur[L][C][0];
						emplacementCurseurMem[L][C][1]=emplacementCurseur[L][C][1];
					}else{
						if(emplacementCurseur[L][C][0]==0){
							if(conteneurObjet.getChildByName("objet"+[L]+[C]) is DisplayObject==true){
								conteneurObjet.removeChild(conteneurObjet.getChildByName("objet"+[L]+[C]));
								emplacementCurseurMem[L][C][0]=emplacementCurseur[L][C][0]=0;
								emplacementCurseurMem[L][C][1]=emplacementCurseur[L][C][1]=0;
							}
						}
					}
				}
			}
			function affichage(){
				var nomClasseObjet1:String="";
				var nomClasseObjet2:String="";
				var nomClasseObjet3:String="";
				switch(emplacementCurseur[L][C][0]){
					case 0: ;break;
					case 1: nomClasseObjet1="InventaireDetailsObjetsPieces";break;
					case 2: nomClasseObjet1="InventaireDetailsObjetsCle";break;
					case 3: nomClasseObjet1="InventaireDetailsObjetsArmes";break;
					case 4: nomClasseObjet1="InventaireDetailsObjetsItems";break;
					
					case 5: nomClasseObjet1="PNJdetails_habit_haut";nomClasseObjet2="PNJdetails_habit_haut_details";nomClasseObjet3="PNJdetails_habit_bras";break;
					case 6: nomClasseObjet1="PNJdetails_habit_bas";break;
					case 7: nomClasseObjet1="PNJdetails_pieds";nomClasseObjet2="PNJdetails_pieds";break;
					default: ;break;
				}
				var objetTemp:MovieClip=new MovieClip();
				var classObjet1:Class=getDefinitionByName(nomClasseObjet1)as Class;
						
				var objetTemp1:MovieClip=new classObjet1();
				objetTemp1.gotoAndStop(emplacementCurseur[L][C][1]);
				objetTemp1.x=tableauPosition[L][C][0];
				objetTemp1.y=tableauPosition[L][C][1];
						
				if(emplacementCurseur[L][C][0]==5||emplacementCurseur[L][C][0]==7){
					var classObjet2:Class=getDefinitionByName(nomClasseObjet2)as Class;
					var objetTemp2:MovieClip=new classObjet2();
					objetTemp2.gotoAndStop(emplacementCurseur[L][C][1]);
					objetTemp2.x=tableauPosition[L][C][0];
					objetTemp2.y=tableauPosition[L][C][1];
					if(emplacementCurseur[L][C][0]==5){
						var classObjet3:Class=getDefinitionByName(nomClasseObjet3)as Class;
						var objetTemp3:MovieClip=new classObjet3();
						objetTemp3.gotoAndStop(emplacementCurseur[L][C][1]);
						objetTemp3.x=tableauPosition[L][C][0];
						objetTemp3.y=tableauPosition[L][C][1];
					}
				}
				if(emplacementCurseur[L][C][0]==1){
					var nP:int=0;
					switch(emplacementCurseur[L][C][1]-1){
						case 1: nP=1;break;
						case 2: nP=3;break;
						case 3: nP=5;break;
					}
					for(var i:int=0;i<nP;i++){
						MovieClip(objetTemp1.getChildAt(i)).gotoAndPlay(Math.round(Math.random()*8));
					}
					objetTemp.addChild(objetTemp1);
				}
				if(emplacementCurseur[L][C][0]==2){objetTemp1.y-=64;objetTemp.addChild(objetTemp1);}
				if(emplacementCurseur[L][C][0]==3){objetTemp1.y-=128;objetTemp.addChild(objetTemp1);}
				if(emplacementCurseur[L][C][0]==4){objetTemp1.y-=192;objetTemp.addChild(objetTemp1);}
				if(emplacementCurseur[L][C][0]==5){
					objetTemp1.scaleX=objetTemp1.scaleY=1.6;objetTemp1.x-=16;objetTemp1.y-=20;
					objetTemp2.scaleX=objetTemp2.scaleY=1.6;objetTemp2.x-=16;objetTemp2.y-=20;
					objetTemp3.scaleX=objetTemp3.scaleY=1.6;objetTemp3.x-=16;objetTemp3.y-=20;
					objetTemp.addChild(objetTemp1);
					objetTemp.addChild(objetTemp2);
					objetTemp.addChild(objetTemp3);
				}
				if(emplacementCurseur[L][C][0]==6){objetTemp1.scaleX=objetTemp1.scaleY=1.6;objetTemp1.x-=18;objetTemp1.y-=41;objetTemp.addChild(objetTemp1);}
				if(emplacementCurseur[L][C][0]==7){
					objetTemp1.scaleX=objetTemp1.scaleY=1.6;objetTemp1.x-=20;objetTemp1.y-=56;
					objetTemp2.scaleX=objetTemp2.scaleY=1.6;objetTemp2.y-=56;
					objetTemp.addChild(objetTemp2);
					objetTemp.addChild(objetTemp1);
				}
						
				objetTemp.name="objet"+[L]+[C];
				conteneurObjet.addChild(objetTemp);
				if(magasinObjet==true&&emplacementCurseur[L][C][2]!=undefined){afficherPrix(L,C,emplacementCurseur[L][C][2]);}
						
			}
		}
//RETOUR MEMOIRE=====================================================================================================================================================
		public function retourInventaire(){
			var pIR:Array=new Array;
			
			pIR[0]=emplacementCurseur[1][0][1];//habit haut
			pIR[1]=emplacementCurseur[2][0][1];//habit bas
			pIR[2]=emplacementCurseur[3][0][1];//habit pieds
			if(emplacementCurseur[1][1][1]>0){pIR[3]=emplacementCurseur[1][1][1]-1;}
			else{pIR[3]=0;}//arme
			if(emplacementCurseur[2][1][1]>0){pIR[4]=emplacementCurseur[2][1][1]-1;}
			else{pIR[4]=0;};//item
	//SAC=======================================================
			pIR[40]=emplacementSac;
			pIR[41]=emplacementCurseur[4][0][0];
			pIR[42]=emplacementCurseur[4][0][1];
			
			pIR[43]=emplacementCurseur[4][1][0];
			pIR[44]=emplacementCurseur[4][1][1];
			
			pIR[45]=emplacementCurseur[4][2][0];
			pIR[46]=emplacementCurseur[4][2][1];
			
			pIR[51]=emplacementCurseur[5][0][0];
			pIR[52]=emplacementCurseur[5][0][1];
			
			pIR[53]=emplacementCurseur[5][1][0];
			pIR[54]=emplacementCurseur[5][1][1];
			
			pIR[55]=emplacementCurseur[5][2][0];
			pIR[56]=emplacementCurseur[5][2][1];
	//COFFRE=====================================================
			pIR[60]=0;
			pIR[61]=emplacementCurseur[6][0][0];
			pIR[62]=emplacementCurseur[6][0][1];
			
			pIR[63]=emplacementCurseur[6][1][0];
			pIR[64]=emplacementCurseur[6][1][1];
			
			pIR[65]=emplacementCurseur[6][2][0];
			pIR[66]=emplacementCurseur[6][2][1];
	//============================================================
			for(var n:int=0; n<pIR.length; n++) {
				if(inventaireRetour[n]!=pIR[n]){
					inventaireRetour[n]=pIR[n];
				}
			}
		}
		public function initialiserCoffre(){
			for(var n:int=0;n<3;n++){
				var objetInit:Array=initialise(n);
				emplacementCurseur[6][n][0]=objetInit[0];
				emplacementCurseur[6][n][1]=objetInit[1]+1;
			}
			function initialise(nObjet):Array{
				var controlObjet:Array=new Array;
				controlObjet[0]=retourObjet[nObjet][1];
				controlObjet[1]=retourObjet[nObjet][2];
				return(controlObjet);
			}
		}
		public function initialiserRetourCoffre(){
			var retourCoffre:Array=new Array;
			
			for(var n:int=0;n<3;n++){
				var retourItem:Array=new Array;
				retourItem[0]=722+emplacementCurseur[6][n][0]*20+emplacementCurseur[6][n][1];
				retourItem[1]=emplacementCurseur[6][n][0];
				retourItem[2]=emplacementCurseur[6][n][1]-1;
				retourCoffre[n]=retourItem;
			}
			retourCoffre[3]=retourObjet[3];
			initialisationCoffre=retourCoffre;
			stage.dispatchEvent(new Event("fermeCoffre"));
		}
//MODIFIER INVENTAIRE=======================================================================================================================================================
		public function modifierInvt(emp:int,obj:int=0,son:Boolean=true){
			var l:int=0;
			var c:int=0;
			var t:int=0;
			var psonItem:Array=[false,0];
			switch(emp){
				case 0: l=1;c=0;t=5;psonItem=[true,3];break;
				case 1: l=2;c=0;t=6;psonItem=[true,3];break;
				case 2: l=3;c=0;t=7;psonItem=[true,3];break;
				case 3: l=1;c=1;t=3;if(obj!=0){obj+=1};psonItem=[true,2];break;
				case 4: l=2;c=1;t=4;if(obj!=0){obj+=1};psonItem=[true,3];break;
				case 10: 
					switch(obj-1){
						case 1: nombrePieces+=1;psonItem=[true,0,1];break;
						case 2: nombrePieces+=3;psonItem=[true,0,3];break;
						case 3: nombrePieces+=5;psonItem=[true,0,5];break;
					};break;
				case 11:
					psonItem=[true,1];
					switch(obj-1){
						case 1: ajouterCle(1);break;
						case 2: ajouterCle(2);break;
						case 3: ajouterCle(3);break;
					};break;
			}
	//ITEM PRIS==================================================
			if(obj==0){t=0;}
			if(son==true){sonItem=psonItem;}
			if(emp<40){
				emplacementCurseur[l][c][0]=t;
				emplacementCurseur[l][c][1]=obj;
			}
	//SAC========================================================
			if(emp>=40&&emp<60){
				var nEmpSac:int=0;
				var tp:int=0;
				var ct:int=0;
				if(emp==40){nEmpSac=obj;}
				switch(emp){
					case 41: l=4;c=0;tp=obj;break;
					case 42: l=4;c=0;ct=obj;break;
					
					case 43: l=4;c=1;tp=obj;break;
					case 44: l=4;c=1;ct=obj;break;
					
					case 45: l=4;c=2;tp=obj;break;
					case 46: l=4;c=2;ct=obj;break;
					
					case 51: l=5;c=0;tp=obj;break;
					case 52: l=5;c=0;ct=obj;break;
					
					case 53: l=5;c=1;tp=obj;break;
					case 54: l=5;c=1;ct=obj;break;
					
					case 55: l=5;c=2;tp=obj;break;
					case 56: l=5;c=2;ct=obj;break;
				}
				if(tp!=0){emplacementCurseur[l][c][0]=tp;}
				if(ct!=0){emplacementCurseur[l][c][1]=ct;}
				if(tp==0&&ct==0){
					emplacementCurseur[l][c][0]=0;
					emplacementCurseur[l][c][1]=0;
				}
			}
		}
//PRIX=============================================================================================================================================================================
		private function afficherPrix(L:int,C:int,prix:int){
			var monChampPrix:TextField=new TextField;
			var miseEnFormeChampPrix:TextFormat=new TextFormat();
			var maPiecePrix:PiecePrix=new PiecePrix;
			
			monChampPrix.text=String(prix+"  ");
			monChampPrix.x=tableauPosition[L][C][0]-44;
			monChampPrix.y=tableauPosition[L][C][1]+60;
			monChampPrix.autoSize=TextFieldAutoSize.RIGHT;
			monChampPrix.background=true;
			monChampPrix.filters=[new DropShadowFilter(1,45)];	
			
			miseEnFormeChampPrix.size=13;
			miseEnFormeChampPrix.font="Comic Sans MS";
			miseEnFormeChampPrix.bold=true;
			miseEnFormeChampPrix.color=0x000000;
			
			monChampPrix.setTextFormat(miseEnFormeChampPrix);
			monChampPrix.name="prix"+[L]+[C];
			maPiecePrix.name="piecePrix"+[L]+[C];
			
			maPiecePrix.x=tableauPosition[L][C][0]+42;
			maPiecePrix.y=tableauPosition[L][C][1]+62;
			
			conteneurObjet.addChild(monChampPrix);
			conteneurObjet.addChild(maPiecePrix);
		}
		private function animerPrix(L:int,C:int,control:Array){
			var miseEnFormeChampPrix:TextFormat=new TextFormat();
			if(control[1]!=0||control[4]!=0){
				miseEnFormeChampPrix.size=16;
				miseEnFormeChampPrix.color=0xFF0000;
			}
			if(control[1]==0&&control[4]==0){
				miseEnFormeChampPrix.size=13;
				miseEnFormeChampPrix.color=0x000000;
			}
			TextField(conteneurObjet.getChildByName("prix"+[L]+[C])).setTextFormat(miseEnFormeChampPrix);
		}
		private function facture(prix:int,ajout:Boolean){
			factureSon=true;
			var monTiket:InventaireDetailsTiket=new InventaireDetailsTiket();
			var monChampPrix:TextField=new TextField;
			var miseEnFormeChampPrix:TextFormat=new TextFormat();
			var miseEnFormeChampPrix2:TextFormat=new TextFormat();
			var maPiecePrix:PiecePrix=new PiecePrix;
			var prixS:String=String(prix);
			
			if(ajout==true){
				monChampPrix.text=String("="+prix+",00\n"+nombrePieces+"-"+prix+"\n="+(nombrePieces-prix));}
			else{
				monChampPrix.text=String("="+prix+",00\n"+nombrePieces+"+"+prix+"\n="+(nombrePieces+prix));
			}
			monChampPrix.x=408;
			monChampPrix.y=570;
			monChampPrix.autoSize=TextFieldAutoSize.RIGHT;
			
			maPiecePrix.x=494;
			maPiecePrix.y=570;
			
			miseEnFormeChampPrix.size=20;miseEnFormeChampPrix2.size=12;
			miseEnFormeChampPrix.font="Comic Sans MS";
			miseEnFormeChampPrix.bold=true;
			miseEnFormeChampPrix.color=0x000000;
			
			monChampPrix.setTextFormat(miseEnFormeChampPrix);
			monChampPrix.setTextFormat(miseEnFormeChampPrix2,2+prixS.length,monChampPrix.length);
			conteneurTiket.addChild(monTiket);
			conteneurTiket.addChild(monChampPrix);
			conteneurTiket.addChild(maPiecePrix);
			conteneurTiket.name="monTiket";
			conteneurObjet.addChild(conteneurTiket);
			if(ajout==true){nombrePieces-=prix;}else{nombrePieces+=prix;}
			
		}
		public function poubelle(){
			if(emplacementCurseur[0][0][0]!=0&&(selecteurL!=0||selecteurC!=0)){
				emplacementCurseur[0][0][0]=0;
				emplacementCurseur[0][0][1]=0;
			}
		}
//CLE================================================================================================================================================================
	//AJOUTER CLE--------------------------------------------------------------
		public function ajouterCle(typeCle:int){
			tableauCle.push(typeCle);
		}
	//SUPRIMER CLE-------------------------------------------------------------
		public function suprimerCle(typeSerrure:int){
			for(var n:int=0;n<tableauCle.length;n++){
				if(tableauCle[n]==typeSerrure){
					tableauCle.splice(n,1);
				}
			}
		}
//TABLEAU DE BORD====================================================================================================================================================
		public function initTableauDeBord(){
			
			monChampPieces.text=String(nombrePiecesAffiche);
			monChampPieces.x=36;
			monChampPieces.autoSize=TextFieldAutoSize.LEFT;
			monChampPieces.filters=[new DropShadowFilter(4,45)];	
			
			miseEnFormeChampPieces.size=22;
			miseEnFormeChampPieces.font="Comic Sans MS";
			miseEnFormeChampPieces.color=0xFFFF00;
			
			monChampPieces.setTextFormat(miseEnFormeChampPieces);
			
			monVisuelPieces.gotoAndStop(2);
			MovieClip(monVisuelPieces.getChildAt(0)).gotoAndStop(1);
			monVisuelPieces.y=-6;
			monVisuelPieces.width=24;
			monVisuelPieces.height=24;
			
			conteneurTableauDeBord.x=72;
			conteneurTableauDeBord.y=376;
			
			conteneurTableauDeBord.addChild(monVisuelPieces);
			conteneurTableauDeBord.addChild(monChampPieces);
		
			monInventairePerso.addChildAt(conteneurTableauDeBord,monInventairePerso.numChildren);
		}
		public function runTableauDeBord(){
			if(nombrePiecesAffiche!=nombrePieces){
				if(nombrePiecesAffiche<nombrePieces-10){nombrePiecesAffiche=nombrePieces-10;}
				if(nombrePiecesAffiche>nombrePieces+10){nombrePiecesAffiche=nombrePieces+10;}
				if(nombrePiecesAffiche<nombrePieces){nombrePiecesAffiche+=1;visuelPiecesPlay();}
				if(nombrePiecesAffiche>nombrePieces){nombrePiecesAffiche-=1;visuelPiecesPlay();}
			}
			if(nombreCleAffiche!=tableauCle.length){
				if(nombreCleAffiche<tableauCle.length){visuelClePlay(true);}
				if(nombreCleAffiche>tableauCle.length){visuelClePlay(false);}
				couleurCle();
			}
			function visuelPiecesPlay(){
				monChampPieces.text=String(nombrePiecesAffiche);			
				monChampPieces.setTextFormat(miseEnFormeChampPieces);
				var minuteur:Timer=new Timer(40,12);
				minuteur.addEventListener(TimerEvent.TIMER,minuteurPlay);
				minuteur.addEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
				minuteur.start();
				function minuteurPlay(evt:TimerEvent){
					MovieClip(monVisuelPieces.getChildAt(0)).play();
				}
				function minuteurStop(evt:TimerEvent){
					MovieClip(monVisuelPieces.getChildAt(0)).gotoAndStop(1);
					removeMinuteur();
				}
				function removeMinuteur(){
					minuteur.removeEventListener(TimerEvent.TIMER,minuteurPlay);
					minuteur.removeEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
				}
			}
			function visuelClePlay(ajout:Boolean){
				switch(ajout){
					case true:
						nombreCleAffiche+=1;
						var monVisuelCle:InventaireDetailsObjetsCle=new InventaireDetailsObjetsCle();
						monVisuelCle.name="Cle"+nombreCleAffiche;
						monVisuelCle.gotoAndStop(2);
						monVisuelCle.x=(nombreCleAffiche*15)-8;
						monVisuelCle.y=-15;
						monVisuelCle.width=25;
						monVisuelCle.height=25;
						conteneurTableauDeBord.addChild(monVisuelCle);
					break;
					case false:
						if(nombreCleAffiche>0){
							conteneurTableauDeBord.removeChild(conteneurTableauDeBord.getChildByName("Cle"+nombreCleAffiche));
							nombreCleAffiche-=1;
						}
					break;
				}
			}
			function couleurCle(){
				for(var n:int=0;n<nombreCleAffiche;n++){
					MovieClip(conteneurTableauDeBord.getChildByName("Cle"+(n+1))).gotoAndStop(tableauCle[n]+1);
				}
			}
		}
//AFFINAGE CURSEUR====================================================================================================================================================
		private function deplacementCurseur(control:Array):int{
			var curseur:int=0;
			var deplacement:int=0;
			
			if(control[0]==0&&control[3]==0){autoriseCurseur=true;}
			if(control[0]!=0){
				if(control[0]!=1){curseur=1;}
				if(control[0]!=-1){curseur=2;}
			}
			if(control[3]!=0){
				if(control[3]!=-1){curseur=3;}
				if(control[3]!=1){curseur=4;}
			}
			if(curseur!=0&&autoriseCurseur==true){deplacement=curseur;autoriseCurseur=false;}			
			return(deplacement);
		}
		private function selectionCurseur(control:Array):Boolean{
			var curseur:Boolean=false;
			var appuie:Boolean=false;
			if(control[1]==0&&control[4]==0){autoriseAppuie=true;}
			if(control[1]!=0){curseur=true;}
			if(control[4]!=0){curseur=true;}
			if(curseur!=false&&autoriseAppuie==true){appuie=curseur;autoriseAppuie=false;}	
			
			return(appuie);
		}
		private function appuieInvt(control:Array):Boolean{
			var curseur:Boolean=false;
			var appuie:Boolean=false;
			if(control[5]==0){autoriseAppuieInvt=true;}
			if(control[5]!=0){curseur=true;}
			if(curseur!=false&&autoriseAppuieInvt==true){appuie=curseur;autoriseAppuieInvt=false;}	
			
			return(appuie);
		}
	}
}