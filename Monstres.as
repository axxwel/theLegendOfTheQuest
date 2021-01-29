package{

	import flash.display.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.*;
	import flash.utils.*;
	
	public class Monstres extends MovieClip{
		public var alphaTest:int=0;
		
		public var carteDecor:Array=new Array();
		public var carteMonstres:Array=new Array();
		
		public var carte_ligne_depart:Number=0 ;
		public var carte_colonne_depart:Number=0 ;
		public var typeNiveau:String;
		public var idTypeNiveau:int=0;
		
		public var dossier:String;
		public var fichier:String;
		
		public var monBoss:Boss=new Boss();
		
		public var herosSens:int=1;
		
		public var mesCases:Cases=new Cases;
		public var monHerosHitTest:HitTestGros=new HitTestGros;
		
		public var armeUtilise:int=0;
		public var monArmeHitTest:HitTestArme=new HitTestArme;
		
		public var monArme:Armes=new Armes;
		
		private var controlDG:int;
		private var controlHB:int;
		
		public var liste_Monstes:Array=new Array;
		public var conteneurMonstres:Sprite=new Sprite();
		public var vitesseDG:int;
		public var vitesseHB:int;
		
		public var inventaire:Array=new Array();
		public var objetMonstre:Array=[false,0,0];
		public var monstreObjetPris:Array=[false,0,0];
		public var monstreTouche:Boolean=false;
		public var nMonstreTouche:int;
		public var droiteGauche:int=1;
		
		public var mort:Boolean=false;
		public var blocker:Boolean=true;
		
		private var attack:Boolean=false;
		private var prendre:Boolean=false;
		private var prendreAutorise:Boolean=false;
		
		public var armeTouche:Boolean=false;
		public var herosTouche:Boolean=false;
		
		public var herosAffaibli:Array=[false,0];
		
		public var memoireMonstres:Array=new Array;
		public var memoireMonstresObjet:Array=new Array;
		
		public var tableauSon:Array=[0,false];
		
		public function Monstres(pnomMonde:String,pnomLieux:String,pCartes:Array,pcarte_ligne_depart:int,pcarte_colonne_depart:int,ptypeNiveau:String,pidTypeNiveau):void{
			carteDecor=pCartes[0];
			carteMonstres=pCartes[4];
			dossier=pnomMonde;
			fichier=pnomLieux;
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart;
			typeNiveau=ptypeNiveau;
			idTypeNiveau=pidTypeNiveau;
			
			monArmeHitTest.alpha=alphaTest;
			monHerosHitTest.alpha=alphaTest;
			monHerosHitTest.x=460;
			monHerosHitTest.y=465;
			
			addChild(monArmeHitTest);
			addChild(monHerosHitTest);
			addChild(conteneurMonstres);
		}
		public function startMonstres(){
			creerliste_Monstes();
			
		}
//CREER LISTE======================================================================================
		public function creerliste_Monstes():void{
			memoire();
			var liste_Monstestemp:Array=new Array;
			var n:int=0;
			for(var L:Number=0;L<carteMonstres.length;L++){
				for(var C:Number=0;C<carteMonstres[L].length;C++){
					if(carteMonstres[L][C]>=542&&carteMonstres[L][C]<=641){
						liste_Monstestemp[n]=[
							donnerType(carteMonstres[L][C]),
							donnerPosition(L,C),
							donnerPropriete(donnerType(carteMonstres[L][C])),
							donnerEtat(),
							donnerObjet(L,C)
						];n++
					}
				}
			}
			liste_Monstes=liste_Monstestemp;
			if(typeNiveau=="boss"){initBoss(idTypeNiveau);}
			initialiser_PNJ();
		}
//INITIALIATION MONSTRE============================================================================
	//INITIALISATION BOSS==================================================
		public function initBoss(nBoss:int){
			liste_Monstes.push(monBoss.creerPropriete(nBoss,carte_colonne_depart,carte_ligne_depart));
		}
	//TYPE.................................................................
		public function donnerType(n:int):Array{
			var tableauTemp:Array=new Array;
			var type:int=0;
			var category:int;
			var nCarte:int=n;
			
			if(n==591){type=1;category=0;}
			if(n==590){type=1;category=1;}
			if(n==589){type=2;category=0;}
			if(n==588){type=2;category=1;}
			if(n==587){type=3;category=0;}
			if(n==586){type=4;category=0;}
			if(n==565){type=5;category=0;}
			if(n==585){type=5;category=1;}
			if(n==562){type=6;category=0;}
			if(n==563){type=6;category=1;}
			if(n==564){type=6;category=2;}
			if(n==582){type=6;category=3;}
			if(n==583){type=6;category=4;}
			if(n==584){type=6;category=5;}
			if(n==542){type=7;category=0;}
			if(n==543){type=7;category=1;}
			
			tableauTemp[0]=type;
			tableauTemp[1]=category;
			tableauTemp[2]=nCarte;
			
			return(tableauTemp);
		}
	//POSITION.................................................................
		public function donnerPosition(L:int,C:int){
			var tableauTemp:Array=new Array;
			tableauTemp[0]=C;
			tableauTemp[1]=L;
			tableauTemp[2]=C*64-carte_colonne_depart*64-64;
			tableauTemp[3]=L*64-carte_ligne_depart*64-64;
			
			return(tableauTemp);
		}
	//PROPRIETE.................................................................
		public function donnerPropriete(type:Array):Array{
			var tableauTemp:Array=new Array;
			var sensM:int=0;
			var vitesseM:int=0;
			var actionM:int=0;
			var compteurM:int=0;
			var parametrePlusM:Array=new Array();
			var distanceXY:Array=new Array();
			var projectile:Array=[false,false,false];
			switch(type[0]){
				case 1://MARCHANT-----------------------------
					vitesseM=4;actionM=1;
					switch(type[1]){
						case 0:	sensM=1;break;
						case 1:	sensM=2;break;
					}
				;break;
				case 2://VOLANT--------------------------------
					sensM=3;vitesseM=4;actionM=1;
					switch(type[1]){
						case 0: ;break;
						case 1: ;break;
					}
				;break;
				case 3://PLANTE--------------------------------
					sensM=3;actionM=1;
					parametrePlusM[0]=Math.round(50+Math.random()*50);
				;break;
				case 4://ROCHER TOMBE--------------------------
					sensM=4;vitesseM=32;
				;break;
				case 5://ROCHER MARTEAU--------------------------
					sensM=4;vitesseM=32;parametrePlusM[0]=true;actionM=Math.round(1+Math.random()*1);
				;break;
				case 6://RONCES--------------------------
					actionM=type[1]+1
				;break;
				case 7://ARBUSTE-------------------------- 
					actionM=type[1]+2;
				;break;
			}			
			tableauTemp[0]=sensM;
			tableauTemp[1]=vitesseM;
			tableauTemp[2]=actionM;
			tableauTemp[3]=compteurM;
			tableauTemp[4]=parametrePlusM
			tableauTemp[5]=distanceXY;
			tableauTemp[6]=projectile;
			return(tableauTemp);
		}
	//ETAT.................................................................
		public function donnerEtat():Array{
			var tableauTemp:Array=new Array;
			var monstreToucheM:Boolean=false;
			var monstreAfficheM:Boolean=true;
			tableauTemp[0]=monstreToucheM;
			tableauTemp[1]=monstreAfficheM;
			return(tableauTemp);
		}
	//OBJET.................................................................
		public function donnerObjet(L:int,C:int):Array{
			
			var tableauTemp:Array=new Array;
			var tableauObjet:Array=new Array;
			var tableauObjetMem:Array=new Array;
			var memTabTemp:Array=memoireObjet(L,C);
			if(memTabTemp.length>0){tableauObjet=memTabTemp;}
			if(tableauObjet.length<=0){
				var objet:int=0;
				if (carteMonstres[L+1][C]>=742){
					objet=carteMonstres[L+1][C];
				}else{
					var iA:int=itemAleatoire();
					if(iA!=0){
						objet=iA;
					}
				}
				if(objet!=0){tableauObjet[0]=objet;}
			}
			tableauTemp[0]=tableauObjet;
			tableauTemp[2]=tableauObjetMem;
			tableauTemp[3]=tableauTemp[0].length;
			return(tableauTemp);
		}
	//INIT AFFICHAGE------------------------------------------------------------------------------------
		public function initialiser_PNJ(){
			for (var n:Number=0; n<liste_Monstes.length; n++){
				var classPNJ:Class=getDefinitionByName("Monstre"+liste_Monstes[n][0][0])as Class;
				var testPNJ:Class=getDefinitionByName("HitTestGros")as Class;
				var PNJtemp:MovieClip=new classPNJ();
				var testPNJtemp:MovieClip=new testPNJ();
				PNJtemp.name="Monstre"+n;
				testPNJtemp.name="TestMonstre"+n;
				PNJtemp.x=liste_Monstes[n][1][2];
				PNJtemp.y=liste_Monstes[n][1][3];
				if(typeNiveau=="boss"){
					testPNJtemp.x=liste_Monstes[n][1][4];
					testPNJtemp.y=liste_Monstes[n][1][5];
				}else{
					testPNJtemp.x=liste_Monstes[n][1][2]+12;
					testPNJtemp.y=liste_Monstes[n][1][3]+24;
				}
				testPNJtemp.alpha=alphaTest;
				
				conteneurMonstres.addChild(PNJtemp);
				conteneurMonstres.addChild(testPNJtemp);
			}
		}
//DEPLACER DECOR==============================================================================================================
		public function deplacer(controlesX:int,controlesY:int){
			var controlesD:Array=new Array;
			controlesD[0]=controlesX;
			controlesD[1]=controlesY;
			
			if(controlesD[0]!=0){
				conteneurMonstres.x+=controlesD[0]*vitesseDG;
			}
			if(controlesD[1]!=0){
				conteneurMonstres.y+=controlesD[1]*vitesseHB;
			}
		}
//DEPLACER PNJ=================================================================================================================
		public function deplacer_PNJ(controlHeros:Array,controlDecor:Array){
			armeTouche=false;
			tableauSon=[0,false];
			for (var n:Number=0; n<liste_Monstes.length; n++){
				var nom:String="Monstre"+n;
				liste_Monstes[n][2][5][0]=conteneurMonstres.getChildByName(nom).x+(conteneurMonstres.x-460);
				liste_Monstes[n][2][5][1]=conteneurMonstres.getChildByName(nom).y+(conteneurMonstres.y-465);
				if(MovieClip(conteneurMonstres.getChildByName(nom)).numChildren>0&&
					MovieClip(conteneurMonstres.getChildByName(nom)).getChildAt(0) is MovieClip==true){
					liste_Monstes[n][2][5][2]=MovieClip(MovieClip(conteneurMonstres.getChildByName(nom)).getChildAt(0)).currentFrame;
					liste_Monstes[n][2][5][3]=MovieClip(MovieClip(conteneurMonstres.getChildByName(nom)).getChildAt(0)).totalFrames;
				}
				liste_Monstes[n][2][5][4]=conteneurMonstres.getChildByName(nom).x;
				liste_Monstes[n][2][5][5]=conteneurMonstres.getChildByName(nom).y;
				if(blocker==false){
			//MONSTRES---------------------------------
					if(liste_Monstes[n][0][0]<100){
						var sens:Number=liste_Monstes[n][2][0];
						var action:Number=liste_Monstes[n][2][2];
						if((conteneurMonstres.getChildByName(nom).y%64==0)&&(conteneurMonstres.getChildByName(nom).x%64==0)){reflechir_PNJ(n);}
						avancer_PNJ(n);
						MovieClip(conteneurMonstres.getChildByName(nom)).gotoAndStop((action*4)+sens);
			//BOSS-------------------------------------
					}else{
						monBoss.reflechir_Boss(n,liste_Monstes[n]);
						avancer_Boss(n);
						MovieClip(conteneurMonstres.getChildByName(nom)).gotoAndStop(liste_Monstes[n][2][2]);
					}
				}
				if(typeNiveau!="cine"){
					interagirObjet(n,controlDecor);
					interagir_PNJ(n,controlDecor);
					projectileMonstres(n);
				}
				
			}
			if(controlHeros[3]==1&&prendreAutorise==true){prendre=true;prendreAutorise=false;}else{prendre=false;}
			if(controlHeros[3]==0){prendreAutorise=true;}
			if(monstreObjetPris[0]==true){prendreObjet(nMonstreTouche,monstreObjetPris);}
		}
//AVANCER PNJ=====================================================================================================================
		public function avancer_PNJ(n:Number){
			var nom:String="Monstre"+n;
			var nomTest:String="TestMonstre"+n;
			var sens:Number=liste_Monstes[n][2][0];
			var vitesse:Number=liste_Monstes[n][2][1];
			if(sens!=0){
				switch(sens){
					case 1:
						conteneurMonstres.getChildByName(nom).x+=vitesse;
						conteneurMonstres.getChildByName(nomTest).x+=vitesse;
						break;
					case 2:
						conteneurMonstres.getChildByName(nom).x-=vitesse;
						conteneurMonstres.getChildByName(nomTest).x-=vitesse;
						break;
					case 3:
						conteneurMonstres.getChildByName(nom).y-=vitesse;
						conteneurMonstres.getChildByName(nomTest).y-=vitesse;
					break;
					case 4:
						conteneurMonstres.getChildByName(nom).y+=vitesse;
						conteneurMonstres.getChildByName(nomTest).y+=vitesse;
					break;
				}
			}
		}
		public function avancer_Boss(n:int){
			var nom:String="Monstre"+n;
			var nomTest:String="TestMonstre"+n;
			var vitesse:Array=liste_Monstes[n][2][1];
			
			switch(liste_Monstes[n][2][0][0]){
				case 1:
					conteneurMonstres.getChildByName(nom).x-=vitesse[0];
					conteneurMonstres.getChildByName(nomTest).x-=vitesse[0];
				break;
				case 2:
					conteneurMonstres.getChildByName(nom).x+=vitesse[0];
					conteneurMonstres.getChildByName(nomTest).x+=vitesse[0];
				break;
			}
			switch(liste_Monstes[n][2][0][1]){
				case 1:
					conteneurMonstres.getChildByName(nom).y-=vitesse[1];
					conteneurMonstres.getChildByName(nomTest).y-=vitesse[1];
				break;
				case 2:
					conteneurMonstres.getChildByName(nom).y+=vitesse[1];
					conteneurMonstres.getChildByName(nomTest).y+=vitesse[1];
				break;
			}
		}
//========================================================================================================================RELECHIR===================================	
		public function reflechir_PNJ(n:Number){
			var nom:String="Monstre"+n;
			var nomTest:String="TestMonstre"+n;
			var type:Number=liste_Monstes[n][0][0];
			var category:Number=liste_Monstes[n][0][1];
			var sens:Number=liste_Monstes[n][2][0];
			var action:Number=liste_Monstes[n][2][2];
			
			switch(type){
//REFLECHIR MONSTRE MARCHANT============================================================================================================================================
				case 1:
					conteneurMonstres.getChildByName(nom).scaleY=conteneurMonstres.getChildByName(nom).scaleX=0.9;
					var nouvelle_direction1:Number;
					if(sens==1){
						conteneurMonstres.getChildByName(nomTest).x=conteneurMonstres.getChildByName(nom).x+24;
						if ((tester_case(carte_ligne_depart+1+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+2+conteneurMonstres.getChildByName(nom).x/64)==2)
						||(tester_case(carte_ligne_depart+1+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+2+conteneurMonstres.getChildByName(nom).x/64)==100)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+2+conteneurMonstres.getChildByName(nom).x/64)==0)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+2+conteneurMonstres.getChildByName(nom).x/64)==100)){
							nouvelle_direction1=2;conteneurMonstres.getChildByName(nomTest).x=conteneurMonstres.getChildByName(nom).x;
						}else{nouvelle_direction1=1;}
					}
					if(sens==2){
						conteneurMonstres.getChildByName(nomTest).x=conteneurMonstres.getChildByName(nom).x;
						if ((tester_case(carte_ligne_depart+1+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+conteneurMonstres.getChildByName(nom).x/64)==2)
						||(tester_case(carte_ligne_depart+1+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+conteneurMonstres.getChildByName(nom).x/64)==100)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+conteneurMonstres.getChildByName(nom).x/64)==0)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+conteneurMonstres.getChildByName(nom).x/64)==100)){
							nouvelle_direction1=1;conteneurMonstres.getChildByName(nomTest).x=conteneurMonstres.getChildByName(nom).x+24;
						}else{nouvelle_direction1=2;}
					}
					liste_Monstes[n][2][0]=nouvelle_direction1;
				break;
//REFLECHIR MONSTRE VOLANT============================================================================================================================================			
				case 2:
					conteneurMonstres.getChildByName(nom).scaleY=conteneurMonstres.getChildByName(nom).scaleX=0.9;
					var nouvelle_direction2:Number;
					var nouvelle_vitesse2:Number;
					var amplitude:Number=2; 
					if(liste_Monstes[n][3][0]==true){
						nouvelle_direction2=liste_Monstes[n][2][0];
					}else{ 
						if(sens==4){
							if(conteneurMonstres.getChildByName(nom).y/64>=((liste_Monstes[n][1][3]/64)+amplitude)){
								nouvelle_direction2=3;
							}else{
								nouvelle_direction2=Math.round(3+Math.random()*1);
							}
						}
						if(sens==3){
							if(conteneurMonstres.getChildByName(nom).y/64<=((liste_Monstes[n][1][3]/64)-amplitude)){
								nouvelle_direction2=4;}else{nouvelle_direction2=Math.round(3+Math.random()*1);
							}
						}
					}
					if(nouvelle_direction2==3){nouvelle_vitesse2=4;}
					if(nouvelle_direction2==4){nouvelle_vitesse2=8;} 
					liste_Monstes[n][2][0]=nouvelle_direction2;
					liste_Monstes[n][2][1]=nouvelle_vitesse2;
				break;
//REFLECHIR MONSTRE PLANTE============================================================================================================================================			
				case 3:
					var nouvelle_action:Number;
					
					liste_Monstes[n][2][3]+=1;
					if(action==0&&liste_Monstes[n][2][3]>liste_Monstes[n][2][4][0]){nouvelle_action=1;liste_Monstes[n][2][3]=0;}else{nouvelle_action=0;}
					if(action==1){
						if(liste_Monstes[n][2][3]<10){liste_Monstes[n][2][3]+=1;nouvelle_action=1;}else{nouvelle_action=2;liste_Monstes[n][2][3]=1;}
					}
					if(action==2){
						if(liste_Monstes[n][2][3]<5+liste_Monstes[n][2][4][0]){
							liste_Monstes[n][2][3]+=1;
							nouvelle_action=2;liste_Monstes[n][3][0]=false;
						}else{
							nouvelle_action=3;
							liste_Monstes[n][2][3]=0;
							liste_Monstes[n][3][0]=true;
						}
					}
					if(action==3){
						if(liste_Monstes[n][2][3]<10){
							liste_Monstes[n][2][3]+=1;
							nouvelle_action=3;
						}else{
							nouvelle_action=0;
							liste_Monstes[n][2][3]=0;
							liste_Monstes[n][2][4][0]=Math.round(50+Math.random()*50)
							}
					}
					if(action==4){
						if(liste_Monstes[n][2][3]<20){
							liste_Monstes[n][2][3]+=1;
							nouvelle_action=4;
						}
						if(liste_Monstes[n][2][3]>20){
							nouvelle_action=0;
							liste_Monstes[n][2][3]=0;							
						}
					}
				liste_Monstes[n][2][2]=nouvelle_action;
				break;
//REFLECHIR MONSTRE ROCHER============================================================================================================================================
				case 4:
					var nouvelle_direction4:Number;
					var nouvelle_action4:Number;
					
					if(liste_Monstes[n][3][0]==true){
						if(liste_Monstes[n][2][3]<=2){liste_Monstes[n][2][3]+=1;liste_Monstes[n][2][1]=8;nouvelle_direction4=4;
							if(liste_Monstes[n][2][3]<=2){nouvelle_action4=1;}
							if(liste_Monstes[n][2][3]>=2){nouvelle_action4=2;}
						}
						if(liste_Monstes[n][2][3]>=2){
							nouvelle_action4=0;
							conteneurMonstres.getChildByName(nom).y=liste_Monstes[n][1][3];
							conteneurMonstres.getChildByName(nomTest).y=liste_Monstes[n][1][3]+24;
							liste_Monstes[n][2][3]=0;
							liste_Monstes[n][3][0]=false;
						}
					}
					if(liste_Monstes[n][3][0]==false){
						if ((tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==1)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==2)){
							nouvelle_direction4=0;nouvelle_action4=1;liste_Monstes[n][3][0]=true;liste_Monstes[n][2][4][0]=true;
						}else{nouvelle_direction4=4;nouvelle_action4=0;liste_Monstes[n][2][1]=32;liste_Monstes[n][3][0]=false;liste_Monstes[n][2][4][0]=false;}
					}
				liste_Monstes[n][2][0]=nouvelle_direction4;
				liste_Monstes[n][2][2]=nouvelle_action4;
				
				break;
//REFLECHIR MONSTRE ROCHER MARTEAU============================================================================================================================================
				case 5:
				var nouvelle_direction5:int;
				var L5:int=liste_Monstes[n][1][1];
				var C5:int=liste_Monstes[n][1][0];
				if(liste_Monstes[n][3][0]==false){
					if ((tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==1)
					||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==2)
					||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==100)){
						nouvelle_direction5=0;
						
					}else{
						if(liste_Monstes[n][2][4][0]==true&&category==1){miseEnMemoire(n);liste_Monstes[n][2][4][0]=false;}
						carteMonstres[L5+1][C5]=585;
						carteMonstres[L5][C5]=0;
						nouvelle_direction5=4;
						L5+=1;
						
					}
				}
				liste_Monstes[n][2][0]=nouvelle_direction5;
				liste_Monstes[n][1][1]=L5;
				break;
			}
		}
//INTERAGIR===========================================================================================================================================================	
		public function interagir_PNJ(n:Number,control:Array){
			if(control[0]!=0){
				switch(control[0]){
					case 1:	droiteGauche=1;break;
					case -1:droiteGauche=2;break;
				}
			}			
			var imunise:int=control[10];
			var sens:Number=liste_Monstes[n][2][0];
			var nom:String="Monstre"+n;
			var nomTest:String="TestMonstre"+n;
			var nomTestObjet:String="TestItem"+n;
			var nomP:String="Projectile"+n;
			var nomPTest:String="HitTestProjectile"+n;
			var type:Number=liste_Monstes[n][0][0];
			var category:Number=liste_Monstes[n][0][1];
			
			if(conteneurMonstres.getChildByName(nomTest) is DisplayObject==true){conteneurMonstres.getChildByName(nomTest).alpha=alphaTest;}
			if(conteneurMonstres.getChildByName(nomTestObjet) is DisplayObject==true){conteneurMonstres.getChildByName(nomTestObjet).alpha=alphaTest;}
			monArmeHitTest.alpha=alphaTest;
			if(liste_Monstes[n][3][1]==true){
				if(monstreTouche==false){
					if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))==true){nMonstreTouche=n;monstreTouche=true;}
				}
				if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))==false&&nMonstreTouche==n){monstreTouche=false;}
			}else{monstreTouche=false;}
			if(imunise!=2&&imunise!=0){mort=true;}else{mort=false;}
			switch(type){
				
//INTERAGIR MONSTRE MARCHANT============================================================================================================================================
				case 1:
					if(attack==true&&armeUtilise==2&&liste_Monstes[n][3][0]==false&&monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))){
						armeTouche=true;}
					if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&liste_Monstes[n][3][0]==false&&mort==false){
						if(imunise!=2){
							stage.dispatchEvent(new Event("mort_monstre"));
						}
					}
					else if(monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&liste_Monstes[n][3][0]==false&&attack==true&&mort==false){
						
						liste_Monstes[n][3][0]=true;
						liste_Monstes[n][2][0]=0;
						liste_Monstes[n][2][1]=0;
					}
					if(liste_Monstes[n][3][0]==true){
						ajouterObjet(n);
						if(liste_Monstes[n][2][3]==1){tableauSon=[type,true];}
						if(liste_Monstes[n][2][3]<10){
							if(droiteGauche==1){liste_Monstes[n][2][0]=1;}
							if(droiteGauche==2){liste_Monstes[n][2][0]=2;}
							liste_Monstes[n][2][2]=4;
						}
						if(liste_Monstes[n][2][3]<=100){liste_Monstes[n][2][3]+=1;}
						if(liste_Monstes[n][2][3]>=10&&liste_Monstes[n][2][3]<=50){liste_Monstes[n][2][2]=0;}
						if(liste_Monstes[n][2][3]>=50){liste_Monstes[n][2][2]=3;}
						if(liste_Monstes[n][2][3]>=100){
							liste_Monstes[n][2][2]=1;
							liste_Monstes[n][2][0]=Math.round(1+Math.random()*1);
							liste_Monstes[n][2][1]=4;
							liste_Monstes[n][2][3]=0;
							liste_Monstes[n][3][0]=false;
						}
					}else{recupererObjet(n);}
				break;
//INTERAGIR MONSTRE VOLANT============================================================================================================================================
				case 2:
					if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&liste_Monstes[n][3][0]==false&&mort==false){
						if(imunise!=2){
							stage.dispatchEvent(new Event("mort_monstre"));
						}
					}
					else if(monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&attack==true&&liste_Monstes[n][3][0]==false&&mort==false){
						armeTouche=true;
						liste_Monstes[n][3][0]=true;						
					}
					if(liste_Monstes[n][3][0]==true){
						if(liste_Monstes[n][2][3]==1){tableauSon=[type,true];}
						if((tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==1)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==2)
						||(tester_case(carte_ligne_depart+2+conteneurMonstres.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurMonstres.getChildByName(nom).x/64)==100)){
							ajouterObjet(n);
							if(liste_Monstes[n][2][3]<=10){liste_Monstes[n][2][3]+=1;liste_Monstes[n][2][1]=0;liste_Monstes[n][2][2]=4;
								if(droiteGauche==1){liste_Monstes[n][2][0]=3;}
								if(droiteGauche==2){liste_Monstes[n][2][0]=4;}
							}
							if(liste_Monstes[n][2][3]<=60&&liste_Monstes[n][2][3]>10){liste_Monstes[n][2][3]+=1;liste_Monstes[n][2][2]=3;liste_Monstes[n][2][1]=0;}
							if(liste_Monstes[n][2][3]>=60){
								liste_Monstes[n][2][2]=1;liste_Monstes[n][2][0]=3;liste_Monstes[n][2][1]=4;liste_Monstes[n][3][0]=false;liste_Monstes[n][2][3]=0;}
						}else{
							if(liste_Monstes[n][2][3]<=10){
								liste_Monstes[n][2][3]+=1;
								liste_Monstes[n][2][1]=0;
								liste_Monstes[n][2][2]=4;
								if(droiteGauche==1){liste_Monstes[n][2][0]=3;}
								if(droiteGauche==2){liste_Monstes[n][2][0]=4;}
							}else{
								liste_Monstes[n][2][0]=4;
								liste_Monstes[n][2][1]=16;
								liste_Monstes[n][2][2]=2;
								liste_Monstes[n][2][3]=11;
							}
						}
					}else{recupererObjet(n);}
				break;
//INTERAGIR MONSTRE PLANTE============================================================================================================================================
				case 3:
					if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&liste_Monstes[n][3][0]==false&&mort==false){
						if(imunise!=2){
							stage.dispatchEvent(new Event("mort_monstre"));
						}
					}
					else if(monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&attack==true&&liste_Monstes[n][3][0]==false&&mort==false){
						tableauSon=[type,true];
						armeTouche=true;
						liste_Monstes[n][2][4][1]=true;
						liste_Monstes[n][3][0]=true;
						liste_Monstes[n][2][3]=0;
						liste_Monstes[n][2][2]=4;
					}
					if(liste_Monstes[n][2][4][1]==true){ajouterObjet(n);}
					if(liste_Monstes[n][3][0]==false){recupererObjet(n);liste_Monstes[n][2][4][1]=false;}
				break;
//INTERAGIR MONSTRE ROCHER============================================================================================================================================
				case 4:
					if(mort==true&&liste_Monstes[n][2][3]<=5){liste_Monstes[n][2][3]+=1;
						if(liste_Monstes[n][2][3]<=3){liste_Monstes[n][2][2]=2;liste_Monstes[n][2][0]=0;}
						if(liste_Monstes[n][2][3]>3){liste_Monstes[n][2][2]=3;liste_Monstes[n][2][0]=0;}
						if(liste_Monstes[n][2][3]>4){liste_Monstes[n][2][2]=4;liste_Monstes[n][2][0]=0;}
					}
					if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&liste_Monstes[n][3][0]==false&&mort==false){
						if(imunise!=2){
							liste_Monstes[n][3][0]=true;
							if(liste_Monstes[n][2][4][1]==true){recupererObjet(n);liste_Monstes[n][2][4][1]=false;}
							stage.dispatchEvent(new Event("mort_monstre"));
						}
					}
					if(liste_Monstes[n][2][4][0]==true&&liste_Monstes[n][4][0]!=0){liste_Monstes[n][2][4][1]=true;}
					if(liste_Monstes[n][4][0]==0){liste_Monstes[n][2][4][1]=false;}
					if(liste_Monstes[n][2][4][1]==true){ajouterObjet(n);}
				break;
//INTERAGIR MONSTRE ROCHER MARTEAU============================================================================================================================================
				case 5:	
					if(liste_Monstes[n][3][0]==true&&liste_Monstes[n][3][1]==true&&liste_Monstes[n][2][3]<=10){liste_Monstes[n][2][3]+=1;
						if(liste_Monstes[n][2][3]==1){tableauSon=[type,true];}
						if(liste_Monstes[n][2][3]<=5){liste_Monstes[n][2][2]=3;}
						if(liste_Monstes[n][2][3]>5){liste_Monstes[n][2][2]=4;}
						if(liste_Monstes[n][2][3]>10){liste_Monstes[n][2][2]=5;liste_Monstes[n][3][1]=false;}
						if(liste_Monstes[n][2][3]==11){
						if(liste_Monstes[n][2][4][0]==true&&category==1){miseEnMemoire(n);liste_Monstes[n][2][4][0]=false;}
						carteMonstres[liste_Monstes[n][1][1]][liste_Monstes[n][1][0]]=0;
						}
					}
					if(attack==true&&armeUtilise==3&&liste_Monstes[n][3][0]==false&&monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))){
						liste_Monstes[n][2][3]=0;liste_Monstes[n][3][0]=true;
					}
				break;
//INTERAGIR MONSTRE RONCE============================================================================================================================================
				case 6:
					conteneurMonstres.getChildByName(nomTest).x=liste_Monstes[n][1][2]-12;
					conteneurMonstres.getChildByName(nomTest).y=liste_Monstes[n][1][3]-8;
					conteneurMonstres.getChildByName(nomTest).height=90;
					conteneurMonstres.getChildByName(nomTest).width=88;
					if(liste_Monstes[n][3][1]==true){
						if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))&&liste_Monstes[n][3][0]==false&&mort==false){
							if(imunise!=2){
								stage.dispatchEvent(new Event("mort_monstre"));
							}
						}
						else if(attack==true&&armeUtilise==1&&liste_Monstes[n][3][0]==false&&monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))){
							liste_Monstes[n][3][0]=true;
							liste_Monstes[n][2][3]=0;
						}
					}
					if(liste_Monstes[n][3][0]==true&&liste_Monstes[n][2][3]<=10){liste_Monstes[n][2][3]+=1;
						if(liste_Monstes[n][2][3]==1){tableauSon=[type,true];}
						if(liste_Monstes[n][2][3]<=5){liste_Monstes[n][2][2]=7;}
						if(liste_Monstes[n][2][3]>9){
							liste_Monstes[n][2][2]=8;
							liste_Monstes[n][3][1]=false;
							ajouterObjet(n);
						}
						if(liste_Monstes[n][2][3]==10){
							//if(conteneurMonstres.getChildByName(nomTest) is DisplayObject==true){conteneurMonstres.removeChild(conteneurMonstres.getChildByName(nomTest));}
							carteMonstres[liste_Monstes[n][1][1]][liste_Monstes[n][1][0]]=0;
						}
					}					
				break;
//INTERAGIR MONSTRE ARBUSTE============================================================================================================================================
				case 7:
					if(liste_Monstes[n][3][1]==true){
						if(liste_Monstes[n][3][0]==true&&liste_Monstes[n][2][3]<=10){liste_Monstes[n][2][3]+=1;
							if(liste_Monstes[n][2][3]==1){tableauSon=[type,true];}
							if(liste_Monstes[n][2][3]<=5){liste_Monstes[n][2][2]=4;}
							if(liste_Monstes[n][2][3]>9){liste_Monstes[n][2][2]=1;}
						}
						if(attack==true&&armeUtilise==1&&liste_Monstes[n][3][0]==false&&monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTest))){
							liste_Monstes[n][2][3]=0;liste_Monstes[n][3][0]=true;
						}
					}else{liste_Monstes[n][2][2]=1;}
					
					if(liste_Monstes[n][3][0]==true&&liste_Monstes[n][2][3]>=9){ajouterObjet(n);}
				break;
//INTERAGIR BOSS============================================================================================================================================
				case 100:
					monBoss.attack=attack;
					monBoss.herosAffaibli=herosAffaibli;
					if(imunise==2){monBoss.herosImunise=true;}else{monBoss.herosImunise=false;}
					MovieClip(conteneurMonstres.getChildByName(nomTest)).width=liste_Monstes[n][1][6];;
					MovieClip(conteneurMonstres.getChildByName(nomTest)).height=liste_Monstes[n][1][7];
			//BOSS TOUCHE HEROS----------
					if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nom))==true&&liste_Monstes[n][3][2]==false&&liste_Monstes[n][3][0]==false&&mort==false){
						monBoss.hitTestB_H=true;
						if(imunise!=2){
							stage.dispatchEvent(new Event("mort_monstre"));
						}
					}else{monBoss.hitTestB_H=false;}
			//ARME TOUCHE BOSS----------
					if(monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nom))==true&&attack==true&&liste_Monstes[n][3][0]==false){
						monBoss.hitTestA_B=true;ajouterObjet(n);
					}else{monBoss.hitTestA_B=false;}
					if(liste_Monstes[n][2][6][1]==true){
			//PROJECTILE TOUCHE BOSS----------------
						if(MovieClip(conteneurMonstres.getChildByName(nomPTest)).hitTestObject(conteneurMonstres.getChildByName(nomTest))==true&&liste_Monstes[n][2][6][2]==true){
							monBoss.hitTestP_B=true;
						}else{monBoss.hitTestP_B=false;}
					}
					if(liste_Monstes[n][2][2]==11){recupererObjet(n);}
				break;
//=================================================================================================================
			}
			if(liste_Monstes[n][4][1]==true){miseEnMemoireObjet(n);}
		}
//TESTER CASES=====================================================================================================
		public function tester_case(ligne:int,colonne:int):int{
			var pligne:int=ligne;
			var pcolonne:int=colonne;
			var control:int;
			var monstreControl:int=mesCases.tester_case(pligne,pcolonne,carteMonstres);
			var decorControl:int=mesCases.tester_case(pligne,pcolonne,carteDecor);
			if((monstreControl==100||monstreControl==101)&&decorControl==0){control=100;}else{control=decorControl;}
			return(control);
		}
//HIT TEST====================================================================================================================
		public function controlHitTestArmes(control:Array){
			attack=control[0];
			monArmeHitTest.scaleX=control[1];
			monArmeHitTest.scaleY=control[2];
			monArmeHitTest.x=control[3];
			monArmeHitTest.y=control[4];
		}
//ITEM MONSTRE=================================================================================================================================
		public function ajouterObjet(nM:int){
			if(liste_Monstes[nM][4][1]==true){
				if(liste_Monstes[nM][4][3]>0){liste_Monstes[nM][4][3]-=1;}else{liste_Monstes[nM][4][3]=liste_Monstes[nM][4][0].length-1;}
				var nObjet:int=liste_Monstes[nM][4][3];
				initialisationItem(nM,liste_Monstes[nM][4][0][nObjet]);
				liste_Monstes[nM][4][1]=false;
			}
		}
	//ITEM ALEATOIRE-----------------------------------------------------------------------
		public function itemAleatoire():int{
			var nO:int=Math.round(Math.random()*100);
			var objetPieces:int=0;
			if(nO>=50){
				if(nO<=80){objetPieces=742;}
				if(nO>80&&nO<=95){objetPieces=743;}
				if(nO>95){objetPieces=744;}
			}
			return(objetPieces);
		}
	//INITIALISER ITEM---------------------------------------------------------------------
		public function initialisationItem(n:int,nObj:int){
			var nom:String="Monstre"+n;
			var objet:Array=new Array();
			objet[0]=true;
			objet[1]=donnerTypeItem(nObj);
			objet[2]=conteneurMonstres.getChildByName(nom).x;
			objet[3]=conteneurMonstres.getChildByName(nom).y;
			
			var Itemstemp:MovieClip=new MovieClip;
			Itemstemp.name="ItemMonstre"+n;
			
			var testItemstemp:HitTestSquare=new HitTestSquare();			
			testItemstemp.name="TestItem"+n;
			
			var nomClasseObjet1:String="";
			var nomClasseObjet2:String="";
			switch(objet[1][1]){
					
				case 1: nomClasseObjet1="InventaireDetailsObjetsPieces";break;
				case 2: nomClasseObjet1="InventaireDetailsObjetsCle";break;
				case 3: nomClasseObjet1="InventaireDetailsObjetsArmes";break;
				case 4: nomClasseObjet1="InventaireDetailsObjetsItems";break;
						
				case 5: nomClasseObjet1="PNJdetails_habit_haut";nomClasseObjet2="PNJdetails_habit_bras";break;
				case 6: nomClasseObjet1="PNJdetails_habit_bas";break;
				case 7: nomClasseObjet1="PNJdetails_pieds";nomClasseObjet2="PNJdetails_pieds";break;
					
				default: ;break;
			}
			var classObjet1:Class=getDefinitionByName(nomClasseObjet1)as Class;
			var objetTemp1:MovieClip=new classObjet1();
			objetTemp1.name="objet1";
			objetTemp1.gotoAndStop(objet[1][2]+1);
			Itemstemp.addChild(objetTemp1);
			if(objet[1][1]==5||objet[1][1]==7){
				var classObjet2:Class=getDefinitionByName(nomClasseObjet2)as Class;
				var objetTemp2:MovieClip=new classObjet2();
				objetTemp2.name="objet2";
				objetTemp2.gotoAndStop(objet[1][2]+1);
				Itemstemp.addChild(objetTemp2);
			}
			switch(objet[1][1]){
				case 1: 
					var nP:int=0;
					switch(objet[1][2]){
						case 1: nP=1;break;
						case 2: nP=3;break;
						case 3: nP=5;break;
					}
					for(var i:int=0;i<nP;i++){
						MovieClip(objetTemp1.getChildAt(i)).gotoAndPlay(Math.round(Math.random()*8));
					}
					;break;
				case 2: objetTemp1.y-=48;break;
				case 3: objetTemp1.y-=128;break;
				case 4: objetTemp1.y-=192;break;
				case 5: objetTemp1.scaleX=objetTemp1.scaleY=1.2;objetTemp1.x-=10;objetTemp1.y+=18;
						objetTemp2.scaleX=objetTemp2.scaleY=1.2;objetTemp2.x-=10;objetTemp2.y+=18;break;
				case 6: objetTemp1.scaleX=objetTemp1.scaleY=1.2;objetTemp1.x-=12;objetTemp1.y+=4;break;
				case 7: objetTemp1.scaleX=objetTemp1.scaleY=1.2;objetTemp1.x+=10;objetTemp1.y-=2;
						objetTemp2.scaleX=objetTemp2.scaleY=1.2;objetTemp2.x-=10;objetTemp2.y-=2;break;
			}
			Itemstemp.x=objet[2];
			Itemstemp.y=objet[3]+10;
			
			testItemstemp.x=objet[2];
			testItemstemp.y=objet[3]+10;
			testItemstemp.alpha=1;
			
			conteneurMonstres.addChild(Itemstemp);
			conteneurMonstres.addChild(testItemstemp);
		}
	//INTERAGIR ITEM-------------------------------------------------------------------------------------
		public function interagirObjet(nO:int,control:Array){
			var nomTestObjet:String="TestItem"+nO;
			var nObjet:int=liste_Monstes[nO][4][3];
			var obj:Array=donnerTypeItem(liste_Monstes[nO][4][0][nObjet]);
			if(conteneurMonstres.getChildByName(nomTestObjet) is DisplayObject==true&&control[10]==0){
				if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomTestObjet))&&(prendre==true||obj[3]>=10)&&liste_Monstes[nO][4][1]==false){
					if(inventaire[obj[3]]!=obj[2]){
						reprendreItem(nO);
						liste_Monstes[nO][4][0].splice(nObjet,1);
					}
				}
			}
		}
		public function reprendreItem(n:int){	
			var nObjet:int=liste_Monstes[n][4][3];
			objetMonstre[0]=true;
			objetMonstre[1]=donnerTypeItem(liste_Monstes[n][4][0][nObjet])[3];
			objetMonstre[2]=donnerTypeItem(liste_Monstes[n][4][0][nObjet])[2];
			if(donnerTypeItem(liste_Monstes[n][4][0][nObjet])[1]==3){objetMonstre[2]-=1;}
			if(donnerTypeItem(liste_Monstes[n][4][0][nObjet])[1]==4){objetMonstre[2]-=1;}
			objetMonstre[3]=n;
		}
		public function suprimerObjet(n:int){
			var nomObjet:String="ItemMonstre"+n;
			var nomTestObjet:String="TestItem"+n;
			if(conteneurMonstres.getChildByName(nomObjet) is DisplayObject==true){
				conteneurMonstres.removeChild(conteneurMonstres.getChildByName(nomObjet));
			}
			if(conteneurMonstres.getChildByName(nomTestObjet) is DisplayObject==true){
				conteneurMonstres.removeChild(conteneurMonstres.getChildByName(nomTestObjet));
			}
		}
		public function modifierObjet(n:int,cObj:int=0,tobj:int=0){
			var nObjet:int;
			switch(cObj){
				case 0: nObjet=820+tobj;break;//habitHaut
				case 1: nObjet=840+tobj;break;//habitBas
				case 2: nObjet=860+tobj;break;//habitPieds
				case 3: nObjet=781+tobj;break;//armes
				case 4: nObjet=800+tobj;break;//item
			}
			suprimerObjet(n);
			if(tobj>0){
				initialisationItem(n,nObjet);
				liste_Monstes[n][4][0].push(nObjet);
			}
		}
		public function recupererObjet(n:int){
			suprimerObjet(n);
			if(liste_Monstes[n][4][0].length>0){liste_Monstes[n][4][1]=true;}
			else{
				var L=liste_Monstes[n][1][1];
				var C=liste_Monstes[n][1][0];
				carteMonstres[L+1][C]=0;
			}
		}
		public function donnerTypeItem(n:int):Array{
			var tableauTemp:Array=new Array;
			var c:int;
			var type:int=0;
			var valeur:int=n;
			var category:int=0;
			var posInvent:int=0;
			
			if(valeur>=742&&valeur<762){c=742;category=1;posInvent=10;}//pieces
			if(valeur>=762&&valeur<782){c=762;category=2;posInvent=11;}//cle
			if(valeur>=782&&valeur<802){c=782;category=3;posInvent=3;}//armes
			if(valeur>=802&&valeur<822){c=802;category=4;posInvent=4;}//item
			if(valeur>=822&&valeur<842){c=822;category=5;posInvent=0;}//habitHaut
			if(valeur>=842&&valeur<862){c=842;category=6;posInvent=1;}//habitBas
			if(valeur>=862&&valeur<882){c=862;category=7;posInvent=2;}//habitPieds
			
			type=n-c;
			tableauTemp[0]=valeur;
			tableauTemp[1]=category;
			tableauTemp[2]=type+1;
			tableauTemp[3]=posInvent;
			return(tableauTemp);
		}
		public function prendreObjet(n:int,pObjetPris:Array){
			var nObjet:int=0;
			var ctObjet:int=0;
			var tpObjet:int=0;
			switch(pObjetPris[1]){
				case 0:ctObjet=5;tpObjet=-2;break;
				case 1:ctObjet=6;tpObjet=-2;break;
				case 2:ctObjet=7;tpObjet=-2;break;
				case 3:ctObjet=3;tpObjet=-1;break;
				case 4:ctObjet=4;tpObjet=-1;break;
			}
			nObjet=722+ctObjet*20+pObjetPris[2]+tpObjet;
			liste_Monstes[n][4][0].push(nObjet);
			liste_Monstes[n][4][1]=true;
			liste_Monstes[n][4][3]=liste_Monstes[n][4][0].length;
			monstreObjetPris=[false,0,0];
		}
//PROJECTILE============================================================================================================
		public function projectileMonstres(n:int){
			if(liste_Monstes[n][2][6][0]==true){creerProjectile(n);liste_Monstes[n][2][6][1]=true;liste_Monstes[n][2][6][0]=false;}
			if(liste_Monstes[n][2][6][1]==true){deplacerProjectile(n);}
		}
		public function creerProjectile(n:int){
			var nom:String="Monstre"+n;
			var nomTest:String="TestMonstre"+n;
			
			var projectileTemp:TirToile=new TirToile;
			projectileTemp.name="Projectile"+n;
			var hitTestprojectileTemp:HitTestPetit=new HitTestPetit;
			hitTestprojectileTemp.name="HitTestProjectile"+n;
			hitTestprojectileTemp.alpha=alphaTest;
			
			var departX:int=conteneurMonstres.getChildByName(nomTest).x-32;
			var departY:int=conteneurMonstres.getChildByName(nomTest).y+32;
			projectileTemp.x=departX;
			projectileTemp.y=departY;
			hitTestprojectileTemp.x=departX+32;
			hitTestprojectileTemp.y=departY-8;
			
			conteneurMonstres.addChild(projectileTemp);
			conteneurMonstres.addChild(hitTestprojectileTemp);
			
		}
		public function deplacerProjectile(n:int){
			var nom:String="Monstre"+n;
			var nomTest:String="TestMonstre"+n;
			var nomP:String="Projectile"+n;
			var nomPTest:String="HitTestProjectile"+n;
			var suppr:Boolean=false;
			armeTouche=false;
			
			if(monArmeHitTest.hitTestObject(conteneurMonstres.getChildByName(nomP))==true&&attack==true&&armeUtilise!=0){armeTouche=true;liste_Monstes[n][2][6][2]=true;}
			if(liste_Monstes[n][2][6][2]==false){
				if(monHerosHitTest.hitTestObject(conteneurMonstres.getChildByName(nomPTest))==true){
					herosAffaibli=[true,1];
					suppr=true;
				}
				conteneurMonstres.getChildByName(nomPTest).scaleX=+1;conteneurMonstres.getChildByName(nomPTest).x-=16;
				conteneurMonstres.getChildByName(nomP).x-=16;
			}
			if(liste_Monstes[n][2][6][2]==true){
				
				conteneurMonstres.getChildByName(nomP).scaleX=-1;conteneurMonstres.getChildByName(nomP).x+=16;
				conteneurMonstres.getChildByName(nomPTest).x=conteneurMonstres.getChildByName(nomP).x-64;
				if(conteneurMonstres.getChildByName(nomPTest).hitTestObject(conteneurMonstres.getChildByName(nomTest))==true){
					conteneurMonstres.getChildByName(nomP).alpha=0;}
			}
			
			if(conteneurMonstres.getChildByName(nomP).x<=0||
			conteneurMonstres.getChildByName(nomP).x>=conteneurMonstres.getChildByName(nom).x+conteneurMonstres.getChildByName(nom).width){suppr=true;}
			if(suppr==true){suprimerProjectile(n);}
		}
		public function suprimerProjectile(n:int){
			var nomP:String="Projectile"+n;
			var nomPTest:String="HitTestProjectile"+n;
			if(liste_Monstes[n][2][6][1]==true){
				liste_Monstes[n][2][6][0]=false;
				liste_Monstes[n][2][6][1]=false;
				liste_Monstes[n][2][6][2]=false;
				conteneurMonstres.removeChild(conteneurMonstres.getChildByName(nomP));
				conteneurMonstres.removeChild(conteneurMonstres.getChildByName(nomPTest));
			}
		}
//FUNCTION MEMOIRE====================================================================================================
	//memoireObjet==================================================
		public function miseEnMemoireObjet(n:int){
			for (var o:int=0;o<liste_Monstes[n][4][0].length;o++){
				if(liste_Monstes[n][4][2][o]!=liste_Monstes[n][4][0][o]){
					miseEnMemoire(n);
					liste_Monstes[n][4][2][o]=liste_Monstes[n][4][0][o];
				}
			}
		}
	//===============================================================
		public function miseEnMemoire(n:Number){
			var liste_MonstreTemp:Array=liste_Monstes[n];
			var type:int=liste_MonstreTemp[0][0];
			var cat:int=liste_MonstreTemp[0][1];
			var nMonstre:int=liste_MonstreTemp[0][2];
			var C:int=liste_MonstreTemp[1][0];
			var L:int=liste_MonstreTemp[1][1];
			var obj:Array=liste_MonstreTemp[4][0];
			var mTemp:Array=[type,cat,nMonstre,C,L,obj];
			
			var inMem:Boolean=false;
			var nMem:int;
			
			for(var m:int;m<memoireMonstres.length;m++){
				if(memoireMonstres[m][0]==dossier&&memoireMonstres[m][1]==fichier&&memoireMonstres[m][2]=="Monstres"){
					var cln:int=memoireMonstres[m][5][3];
					var lgn:int=memoireMonstres[m][5][4];
					if(C==cln&&L==lgn){inMem=true;nMem=m;}
				}
			}
			if(inMem==true){
				if(obj.length==0){memoireMonstres.splice(nMem,1);}
				else{memoireMonstres.splice(nMem,1,[dossier,fichier,"Monstres",n,false,mTemp]);}
			}
			if(inMem==false){memoireMonstres.unshift([dossier,fichier,"Monstres",n,false,mTemp]);}
		}
		public function memoire(){
			for(var n:int=0; n<memoireMonstres.length; n++) {
				if(memoireMonstres[n][0]==dossier&&memoireMonstres[n][1]==fichier&&memoireMonstres[n][2]=="Monstres"){
					
					var type:int=memoireMonstres[n][5][0];
					var cat:int=memoireMonstres[n][5][1];
					var nMonstre:int=memoireMonstres[n][5][2];
					var C:int=memoireMonstres[n][5][3];
					var L:int=memoireMonstres[n][5][4];
					switch(type){
						case 5://ROCHER MARTEAU======
							if(cat==1){carteMonstres[L][C]=nMonstre;}
						break;
					}
				}
			}
		}
		public function memoireObjet(L:int,C:int):Array{
			var tableauControl:Array=new Array();
			for(var n:int=0; n<memoireMonstres.length; n++) {
				if(memoireMonstres[n][0]==dossier&&memoireMonstres[n][1]==fichier&&memoireMonstres[n][2]=="Monstres"){
					var nMonstre:int=memoireMonstres[n][5][2];
					var cln:int=memoireMonstres[n][5][3];
					var lgn:int=memoireMonstres[n][5][4];
					var objs:Array=memoireMonstres[n][5][5];
					if(C==cln&&L==lgn){
						for(var o:int=0;o<objs.length;o++){tableauControl[o]=objs[o];}
					}
				}
			}
			return(tableauControl);
		}
		public function block(){blocker=true;}
		public function deblock(){blocker=false;}		
	}
}