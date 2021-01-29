package{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class PlateformeSpeciale extends MovieClip{
		
		public var alphaTest:int=0;
		
		public var nomMonde:String;
		public var nomNiveau:String;
		private var cartePlateforme:Array=new Array;
		public var carte_ligne_depart:int=0;
		public var carte_colonne_depart:int=0;
		public var liste_Plateforme:Array=new Array;
		public var conteneurPlateforme:Sprite=new Sprite();
		public var monHerosHitTest:HitTestSquare=new HitTestSquare();	
		
		public var zoomCam:Array=new Array();
		
		public var vitesseDG:int;
		public var vitesseHB:int;
		public var mesCases:Cases=new Cases;
		
		private var retourListe:Boolean=false;
		
		public var decalageY:int=0;
		public var sensPlateforme:int=0;
		public var vitessePlateforme:int=0;
		public var touchePlateforme:Boolean=false;
		public var arretPlateforme:Boolean=false;
		
		public var tableauSon:Array=new Array();
		
		public function PlateformeSpeciale (pnomMonde:String,pnomNiveau:String,pCartes:Array,pcarte_ligne_depart:int,pcarte_colonne_depart:int){
			
			cartePlateforme=pCartes[0];
			nomMonde=pnomMonde;
			nomNiveau=pnomNiveau;
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart;
			
			monHerosHitTest.alpha=0;
			monHerosHitTest.x=480;
			monHerosHitTest.y=512;
			monHerosHitTest.width=4;
			monHerosHitTest.height=16;
			
			addChild(conteneurPlateforme);
			addChild(monHerosHitTest);
		}
		public function startPlateformes(){
			
			creerListe_Plateforme();
		}
//INITIALIATION LISTE PLATEFORME============================================================================
	public function creerListe_Plateforme():void{
			
			var liste_Plateformetemp:Array=new Array;
			var n:int=0;
			for(var L:int=0;L<cartePlateforme.length;L++){
				for(var C:int=0;C<cartePlateforme[L].length;C++){
					if(cartePlateforme[L][C]>=462&&cartePlateforme[L][C]<=501&&donnerType(cartePlateforme[L][C])[0]!=0){
						liste_Plateformetemp[n]=[donnerType(cartePlateforme[L][C]),donnerPosition(L,C),donnerPropriete(donnerType(cartePlateforme[L][C])),donnerEtat()];
						n++;
					}
				}
			}
			liste_Plateforme=liste_Plateformetemp;
			initialiser_Plateforme();
	}
	//TYPE.................................................................
		public function donnerType(n:int):Array{
			var tableauTemp:Array=new Array;
			var type:int=0;
			var category:int;
			var typeAffichage:int=0;
			var posTest:int=0;
			
			if(n==464){type=1;category=1;typeAffichage=1;posTest=0;}//BOUGE---------
			if(n==465){type=1;category=2;typeAffichage=1;posTest=0;}
			if(n==484){type=1;category=3;typeAffichage=1;posTest=0;}
			if(n==485){type=1;category=4;typeAffichage=1;posTest=0;}
			if(n==466){type=1;category=5;typeAffichage=2;posTest=1;}
			if(n==486){type=1;category=5;typeAffichage=3;posTest=2;}
			
			if(n==467){type=2;category=1;typeAffichage=4;posTest=0;}//ENTRE SORT-----
			if(n==487){type=2;category=2;typeAffichage=4;posTest=0;}
			if(n==468){type=2;category=3;typeAffichage=5;posTest=1;}
			if(n==488){type=2;category=3;typeAffichage=6;posTest=2;}
			
			if(n==469){type=3;category=1;typeAffichage=7;posTest=0;}//CASSE----------
			if(n==470){type=3;category=2;typeAffichage=8;posTest=1;}
			if(n==471){type=3;category=3;typeAffichage=9;posTest=2;}
			
			if(n==489){type=4;category=1;typeAffichage=7;posTest=0;}//TOMBE----------
			if(n==490){type=4;category=2;typeAffichage=8;posTest=1;}
			if(n==491){type=4;category=3;typeAffichage=9;posTest=2;}
			
			tableauTemp[0]=type;
			tableauTemp[1]=category;
			tableauTemp[2]=typeAffichage;
			tableauTemp[3]=posTest;
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
			var sensP:int=0;
			var vitesseP:int=0;
			var actionP:int=0;
			var compteurP:int=0;
			var parametrePlusP:Array=new Array();
			switch(type[0]){
				case 1://DROITE GAUCHE*HAUT BAS-----------------------------
					vitesseP=4;
					switch(type[1]){
						case 1:	sensP=1;break;
						case 2: sensP=2;break;
						case 3:	sensP=3;break;
						case 4: sensP=4;break;
						case 5: ;break;//FIN BOIS HB DG------------------
					}
				;break;
				case 2://ENTRE SORT--------------------------------
					switch(type[1]){
						case 1:	actionP=1;compteurP=Math.round(10+Math.random()*50);break;//ENTRE SORT 1----------------
						case 2:	actionP=3;compteurP=Math.round(10+Math.random()*50);break;//ENTRE SORT 2-------------
						case 3:	;break;//MILLIEUX BOIS ES--------------
						case 4: ;break;//FIN BOIS ES------------------
					}
				;break;
				case 3://CASE---------------------------------------
					actionP=2;
				;break;
				case 4://TOMBE---------------------------------------
					vitesseP=8;actionP=1;
				;break;
				case 5://ESCALIER---------------------------------------
				;break;
			}
			tableauTemp[0]=sensP;
			tableauTemp[1]=vitesseP;
			tableauTemp[2]=actionP;
			tableauTemp[3]=compteurP;
			tableauTemp[4]=parametrePlusP
			
			return(tableauTemp);
		}
	//ETAT.................................................................
		public function donnerEtat():Array{
			var tableauTemp:Array=new Array;
			var toucheP:Boolean=false;
			var afficheP:Boolean=true;
			tableauTemp[0]=toucheP;
			tableauTemp[1]=afficheP;
			return(tableauTemp);
		}
//INITIALISER PLATEFORME==================================================================================================================================
		public function initialiser_Plateforme(){
			for (var n:int=0; n<liste_Plateforme.length; n++){
				if(liste_Plateforme[n][0][2]!=0){
					var classPlateforme:Class=getDefinitionByName("Plateforme"+liste_Plateforme[n][0][2])as Class;
					var Plateformetemp:MovieClip=new classPlateforme();
					Plateformetemp.name="Plateforme"+n;
					Plateformetemp.x=liste_Plateforme[n][1][2];
					Plateformetemp.y=liste_Plateforme[n][1][3];
					conteneurPlateforme.addChild(Plateformetemp);
				}
				var testPlateformetemp:HitTestSquare=new HitTestSquare();	
				testPlateformetemp.name="TestPlateforme"+n;
				
				testPlateformetemp.x=liste_Plateforme[n][1][2];
				testPlateformetemp.y=liste_Plateforme[n][1][3];
				switch(liste_Plateforme[n][0][3]){
					case 0: initTest(32,8,32,0);break;
					case 1: initTest(64,8,0,0);break;
					case 2: initTest(32,8,0,0);break;
					case 3: initTest(64,64,0,0);break;
				}
				function initTest(l:int,h:int,pX:int,pY:int){
					testPlateformetemp.alpha=0;
					testPlateformetemp.width=l;
					testPlateformetemp.height=h;
					testPlateformetemp.x=liste_Plateforme[n][1][2]+pX;
					testPlateformetemp.y=liste_Plateforme[n][1][3]+pY;
				}
				conteneurPlateforme.addChild(testPlateformetemp);
			}
		}
//DEPLACER DECOR=========================================================================================================================
		public function deplacer(controlesX:int,controlesY:int){
			var controlesDecor:Array=new Array;
			controlesDecor[0]=controlesX;
			controlesDecor[1]=controlesY;
			
			if(controlesDecor[0]!=0){
				conteneurPlateforme.x+=controlesDecor[0]*vitesseDG;
			}
			if(controlesDecor[1]!=0){
				conteneurPlateforme.y+=controlesDecor[1]*vitesseHB;
			}
		}
//RUN=====================================================================================================================================
		public function deplacer_Plateforme(control:Array,controlDecor:Array){
			touchePlateforme=false;
			arretPlateforme=false;
			decalageY=0;
			sensPlateforme=0;
			tableauSon=[0,false];
			for (var n:int=0; n<liste_Plateforme.length; n++){
				var nom:String="Plateforme"+n;
				if(liste_Plateforme[n][0][2]!=0){
					if((conteneurPlateforme.getChildByName(nom).y%64==0)&&(conteneurPlateforme.getChildByName(nom).x%64==0)){
						reflechir_Plateforme(n);
					}
				}
				interagir_Plateforme(n,control,controlDecor);if(retourListe==true){n=0;retourListe=false;}
				if(liste_Plateforme[n][0][2]!=0){
					animer_Plateforme(n);
					avancer_Plateforme(n);
				}
			}
		}
	//AVANCER----------------------------------------------------------
		public function avancer_Plateforme(n:int){
			var nom:String="Plateforme"+n;
			var nomTest:String="TestPlateforme"+n;
			var sens:int=liste_Plateforme[n][2][0];
			var vitesse:int=liste_Plateforme[n][2][1];
			if(sens!=0){
				switch(sens){
					case 1:
						conteneurPlateforme.getChildByName(nom).x+=vitesse;
						conteneurPlateforme.getChildByName(nomTest).x+=vitesse;
						break;
					case 2:
						conteneurPlateforme.getChildByName(nom).x-=vitesse;
						conteneurPlateforme.getChildByName(nomTest).x-=vitesse;
						break;
					case 3:
						conteneurPlateforme.getChildByName(nom).y-=vitesse;
						conteneurPlateforme.getChildByName(nomTest).y-=vitesse;
					break;
					case 4:
						conteneurPlateforme.getChildByName(nom).y+=vitesse;
						conteneurPlateforme.getChildByName(nomTest).y+=vitesse;
					break;
				}
			}
		}
	//ANIMER-------------------------------------------------------------
		public function animer_Plateforme(n:int){
			var nom:String="Plateforme"+n;
			var type:int=liste_Plateforme[n][0][0];
			var cat:int=liste_Plateforme[n][0][1];
			switch(type){
				case 2://ENTRE SORT-----------
					switch(cat){
						case 1: MovieClip(conteneurPlateforme.getChildByName(nom)).gotoAndStop(liste_Plateforme[n][2][2]);break;
						case 2: MovieClip(conteneurPlateforme.getChildByName(nom)).gotoAndStop(liste_Plateforme[n][2][2]);break;
						case 3: MovieClip(conteneurPlateforme.getChildByName(nom)).gotoAndStop(liste_Plateforme[n-1][2][2]);break;
					}
				break;
				case 3://CASSE----------------------
					MovieClip(conteneurPlateforme.getChildByName(nom)).gotoAndStop(liste_Plateforme[n][2][2]);break;
				break;
				case 4://TOMBE------------------------
					MovieClip(conteneurPlateforme.getChildByName(nom)).gotoAndStop(liste_Plateforme[n][2][2]);break;
				break;
			}
		}
//REFLECHIR================================================================================================================================
		public function reflechir_Plateforme(n:int){
			var nom:String="Plateforme"+n;
			var nomTest:String="TestPlateforme"+n;
			var type:int=liste_Plateforme[n][0][0];
			var cat:int=liste_Plateforme[n][0][1];
			var sens:int=liste_Plateforme[n][2][0];
			var vitesse:int=liste_Plateforme[n][2][1];
			var testCase:Array=tester_case(carte_ligne_depart+1+conteneurPlateforme.getChildByName(nom).y/64,carte_colonne_depart+1+conteneurPlateforme.getChildByName(nom).x/64);
			
			switch(type){
	//BOIS MOUVANT=================================================================================================================
				case 1:
					if(cat<=4){
						var nouvelle_direction:int;
						if (testCase[0]==1){
							nouvelle_direction=testCase[1];
						}else{nouvelle_direction=liste_Plateforme[n][2][0];}
					}else{nouvelle_direction=liste_Plateforme[n-1][2][0];}						
					liste_Plateforme[n][2][0]=nouvelle_direction;
				break;
	// BOIS RENTRE SORT================================================================================================================
				case 2:
					if(cat==1||cat==2){
		//BOIS ENTRE ET SORT------------------------------------------------------------
						var nouvelle_Action:int;
						if(liste_Plateforme[n][2][2]==1){
							liste_Plateforme[n][3][0]=true;
							liste_Plateforme[n][2][3]-=1;
							if(liste_Plateforme[n][2][3]<=0){liste_Plateforme[n][2][3]=20;liste_Plateforme[n][2][4][0]=false;nouvelle_Action=2;}else{nouvelle_Action=1;}
						}
						if(liste_Plateforme[n][2][2]==2){
							liste_Plateforme[n][3][0]=true;
							liste_Plateforme[n][2][3]-=1;
							if(liste_Plateforme[n][2][3]<=0){
								if(liste_Plateforme[n][2][4][0]==false){nouvelle_Action=3;}else{nouvelle_Action=1;}
									
								liste_Plateforme[n][2][3]=Math.round(10+Math.random()*50);
							}else{nouvelle_Action=2;}
						}
						if(liste_Plateforme[n][2][2]==3){
							liste_Plateforme[n][3][0]=false;
							liste_Plateforme[n][2][3]-=1;
							if(liste_Plateforme[n][2][3]<=0){liste_Plateforme[n][2][3]=20;liste_Plateforme[n][2][4][0]=true;nouvelle_Action=2;}else{nouvelle_Action=3;}
						}
						liste_Plateforme[n][2][2]=nouvelle_Action;
					}else{
						liste_Plateforme[n][3][0]=liste_Plateforme[n-1][3][0];
						liste_Plateforme[n][2][2]=liste_Plateforme[n-1][2][2];
					}
				break;
		//BOIS CASSE------------------------------------------------------------------------
				case 3:
					if (liste_Plateforme[n][3][0]==true){
						liste_Plateforme[n][2][3]-=1;
						if(liste_Plateforme[n][2][3]==9){tableauSon=[3,true];}
						if(liste_Plateforme[n][2][3]<10){liste_Plateforme[n][2][2]=3;}
						if(liste_Plateforme[n][2][3]<=0){liste_Plateforme[n][2][2]=4;liste_Plateforme[n][3][1]=false;}
					}else{liste_Plateforme[n][2][3]=20;}
				break;
		//BOIS TOMBE------------------------------------------------------------------------
				case 4:
					if (liste_Plateforme[n][3][0]==true){
						liste_Plateforme[n][2][0]=4;
						if(testCase[0]==2){
							liste_Plateforme[n][2][1]=0;
							liste_Plateforme[n][2][3]-=1;
							if(liste_Plateforme[n][2][3]<10){liste_Plateforme[n][2][2]=3;}
							if(liste_Plateforme[n][2][3]<=0){liste_Plateforme[n][2][2]=4;liste_Plateforme[n][3][1]=false;}
						}
					}else{liste_Plateforme[n][2][3]=10;}				
				break;
				default: break;
			}
		}
//INTERAGIR====================================================================================================================================
		function interagir_Plateforme(n,control:Array,controlDecor:Array){
			
			if(controlDecor[0]!=0){
				if(controlDecor[0]==1){monHerosHitTest.x=480}
				if(controlDecor[0]==-1){monHerosHitTest.x=476}
			}
			var sensHeros:int=controlDecor[1];
				var touchX:Boolean;
				var touchY:Boolean;
				var nomTest:String="TestPlateforme"+n;
				var type:int=liste_Plateforme[n][0][0];
				var L:int=liste_Plateforme[n][1][1];
				var C:int=liste_Plateforme[n][1][0];
				
				monHerosHitTest.alpha=alphaTest;
				conteneurPlateforme.getChildByName(nomTest).alpha=alphaTest;
				
				switch(type){
		//BOIS BOUGE=====================================================================================================================================================
					case 1:
						if(sensHeros!=1&&monHerosHitTest.hitTestObject(conteneurPlateforme.getChildByName(nomTest))){
							touchePlateforme=true;
							decalageY=conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y-512;
							vitessePlateforme=liste_Plateforme[n][2][1];
							sensPlateforme=liste_Plateforme[n][2][0];
							if(conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y==512){
								decalageY=0;arretPlateforme=true;
							}
						}
					break;
		//BOIS ENTRE SORT=====================================================================================================================================================
					case 2:
						if(liste_Plateforme[n][2][2]!=1&&sensHeros!=1&&monHerosHitTest.hitTestObject(conteneurPlateforme.getChildByName(nomTest))){
							touchePlateforme=true;
							decalageY=conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y-512;
							if(conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y==512){
								decalageY=0;arretPlateforme=true;
							}
						}
					break;
		//BOIS CASSE=====================================================================================================================================================
					case 3:
						if(liste_Plateforme[n][2][2]<3&&sensHeros!=1&&monHerosHitTest.hitTestObject(conteneurPlateforme.getChildByName(nomTest))){
							touchePlateforme=true;
							decalageY=conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y-512;
							if(conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y==512){
								decalageY=0;arretPlateforme=true;liste_Plateforme[n][3][0]=true;
							}
						}
						if(liste_Plateforme[n][3][0]==true){
							if(n<liste_Plateforme.length-1){
								if(tester_case(L,C+1)[0]==4&&liste_Plateforme[n+1][0][0]==3){
									if(liste_Plateforme[n+1][0][1]==3){liste_Plateforme[n+1][3][0]=true;}
								}
							}
							if(n>0){
								if(tester_case(L,C-1)[0]==4&&liste_Plateforme[n-1][0][0]==3){
									if(liste_Plateforme[n-1][0][1]==1){liste_Plateforme[n-1][3][0]=true;}
								}
							}
						}
					break;
		//BOIS TOMBE=====================================================================================================================================================
					case 4:
						if(n<liste_Plateforme.length-1){
							if(liste_Plateforme[n][3][0]==true&&liste_Plateforme[n+1][0][0]==4){
								var tC1:Array=tester_case(L,C+1);
								if(tC1[0]==3&&liste_Plateforme[n+1][2][0]!=4){liste_Plateforme[n+1][2][0]=4;liste_Plateforme[n+1][3][0]=true;}
							}
						}
						if(liste_Plateforme[n][2][2]<3&&sensHeros!=1&&monHerosHitTest.hitTestObject(conteneurPlateforme.getChildByName(nomTest))){
							touchePlateforme=true;
							decalageY=conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y-512;
							sensPlateforme=liste_Plateforme[n][2][0];
							if(conteneurPlateforme.getChildByName(nomTest).y+conteneurPlateforme.y==512){vitessePlateforme=liste_Plateforme[n][2][1];
								decalageY=0;arretPlateforme=true;
								liste_Plateforme[n][3][0]=true;
							}
						}
						if(n>0){
							if(liste_Plateforme[n][3][0]==true&&liste_Plateforme[n-1][0][0]==4){
								var tC2:Array=tester_case(L,C-1);
								if(tC2[0]==3&&liste_Plateforme[n-1][2][0]!=4){liste_Plateforme[n-1][2][0]=4;liste_Plateforme[n-1][3][0]=true;retourListe=true;}
							}
						}
					break;
				}
		}
//TESTER CASES======================================================================================================================
		public function tester_case(ligne:int,colonne:int):Array{
			var pligne:int=ligne;
			var pcolonne:int=colonne;
			var control:Array=[0,0];
			var decorControl:int=mesCases.tester_case(pligne,pcolonne,cartePlateforme);
			switch(decorControl){
				case 201: control[0]=1;control[1]=1;break;
				case 202: control[0]=1;control[1]=2;break;
				case 203: control[0]=1;control[1]=3;break;
				case 204: control[0]=1;control[1]=4;break;
				case 205: control[0]=3;control[1]=1;break;
				case 206: control[0]=4;control[1]=1;break;
				default: control[0]=0;control[1]=0;break;
			}
			if(decorControl!=0&&decorControl<=5){control[0]=2;}
			return(control);
		}
	}
}
		