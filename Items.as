package{

	import flash.display.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.*;
	import flash.utils.*;
	
	public class Items extends MovieClip{
		public var alphaTest:int=0;
		
		public var carteDecor:Array=new Array();
		public var carte_ligne_depart:int=0 ;
		public var carte_colonne_depart:int=0 ;
		
		public var carteItems:Array=new Array;
		public var dossier:String;
		public var fichier:String;
		
		public var mesCases:Cases=new Cases;
		public var monHerosHitTest:HitTestSquare=new HitTestSquare;
		
		
		private var controlDG:int;
		private var controlHB:int;
		
		private var interupteurAppuie:Boolean=false;
		
		public var liste_Items:Array=new Array;
		public var conteneurItems:Sprite=new Sprite();
		public var vitesseDG:int;
		public var vitesseHB:int;
		
		public var monstreTouche:Boolean=false;
		public var touche_sol:Boolean=false;
		
		public var pieces:Array=[false,0];
		public var cle:Array=[false,0];
		public var tableauCle:Array=new Array();
		public var coffreOuvrir:Boolean=false;
		public var serrureOuvrir:Array=[false,0];
		
		public var initialisationCoffre:Array=new Array();
		
		public var porteFermeCle=false;
		
		public var porteCote:Boolean=false;
		public var blockPorte:Boolean=false;
		public var porteOuvrir:Boolean=false;
		public var porteFermer:Boolean=false;
		
		public var armePlus:Boolean=false;
		public var armeUtilise:int=0;
		public var itemPlus:Boolean=false;
		public var itemUtilise:int=0;
		public var habitPlus:Boolean=false;
		public var inventaireRetour:Array=new Array();
		public var habitPris:Array=new Array;
		
		public var tableauMemoire:Array=new Array;
		public var memoireItems:Array=new Array;
		
		private var mort:Boolean=false;
		public var blocker:Boolean=true;
		
		private var attack:Boolean=false;
		
		public var objetDansCoffre:Array=new Array;
		public var retourObjet:Array=new Array;
		
		public var tableauSon:Array=new Array();
		
		public function Items(pnomMonde:String,pnomLieux:String,pCartes:Array,pcarte_ligne_depart:int,pcarte_colonne_depart:int):void{
			
			carteDecor=pCartes[0];
			carteItems=pCartes[5];
			dossier=pnomMonde;
			fichier=pnomLieux;
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart;
			monHerosHitTest.alpha=0;
			monHerosHitTest.x=464;
			monHerosHitTest.y=464;
			
			addChild(monHerosHitTest);
			addChild(conteneurItems);
		}
		public function startItems(){creerListe_Items();}
		public function creerListe_Items():void{
			
			var liste_Itemstemp:Array=new Array;
			var n:int=0;
			for(var L:int=0;L<carteItems.length;L++){
				for(var C:int=0;C<carteItems[L].length;C++){
					if((carteItems[L][C]>=422&&carteItems[L][C]<442)||(carteItems[L][C]>=722&&carteItems[L][C]<902)){
						liste_Itemstemp[n]=[donnerType(carteItems[L][C]),donnerPosition(C,L),true,true];n++
					}
				}
			}			
			liste_Items=liste_Itemstemp;
			initialiser_Items();
		}
		public function donnerType(n:int):Array{
			var tableauTemp:Array=new Array;
			var c:int;
			var type:int=0;
			var valeur:int=n;
			var category:int;
			
			if(valeur>=422&&valeur<442){c=422;category=0;}//porte
			
			if(valeur>=722&&valeur<742){c=722;category=10;}//coffre
			if(valeur>=742&&valeur<762){c=742;category=1;}//pieces
			if(valeur>=762&&valeur<782){c=762;category=2;}//cle
			if(valeur>=782&&valeur<802){c=782;category=3;}//armes
			if(valeur>=802&&valeur<822){c=802;category=4;}//item
			if(valeur>=822&&valeur<842){c=822;category=5;}//habitHaut
			if(valeur>=842&&valeur<862){c=842;category=6;}//habitBas
			if(valeur>=862&&valeur<882){c=862;category=7;}//habitPieds
			
			type=n-c;
			tableauTemp[0]=valeur;
			tableauTemp[1]=category;
			tableauTemp[2]=type+1;
			
			return(tableauTemp);
		}
		public function donnerPosition(L:int,C:int){
			var tableauTemp:Array=new Array;
			tableauTemp[0]=L;
			tableauTemp[1]=C;
			tableauTemp[2]=L*64-carte_colonne_depart*64-64;
			tableauTemp[3]=C*64-carte_ligne_depart*64-64;
			
			return(tableauTemp);
		}
		public function initialiser_Items(){
			testerPorteCle();
			memoire();
			for (var n:int=0; n<liste_Items.length;n++){
				var colonne=liste_Items[n][1][0];
				var ligne=liste_Items[n][1][1];
				
				for(var nItem:int=0;nItem<liste_Items.length;nItem++) {
					var colonneI=liste_Items[nItem][1][0];
					var ligneI=liste_Items[nItem][1][1];
					if(((colonne==colonneI&&ligne==ligneI-1)||
					(colonne==colonneI+1&&ligne==ligneI-1)||
					(colonne==colonneI-1&&ligne==ligneI-1))&&liste_Items[nItem]!=liste_Items[n]&&(liste_Items[n][0][1]==10||liste_Items[n][0][1]==0)){
						liste_Items[nItem][3]=false;
					}
				}
				if(liste_Items[n][3]!=false){liste_Items[n][3]=true;}
			}
			for (var num:int=0; num<liste_Items.length;num++){
				if(liste_Items[num][3]==true){initialisationItem(num);}
			}
			
		}
		public function initialisationItem(n:int){
			var Itemstemp:MovieClip=new MovieClip;
			Itemstemp.name="Item"+n;
			var testItemstemp:HitTestSquare=new HitTestSquare();			
			testItemstemp.name="TestItem"+n;
			
			
			var nomClasseObjet1:String="";
			var nomClasseObjet2:String="";
			var nomClasseObjet3:String="";
			switch(liste_Items[n][0][1]){
				case 0: nomClasseObjet1="InventaireDetailsObjetsPortes";break;
				case 1: nomClasseObjet1="InventaireDetailsObjetsPieces";break;
				case 2: nomClasseObjet1="InventaireDetailsObjetsCle";break;
				case 3: nomClasseObjet1="InventaireDetailsObjetsArmes";break;
				case 4: nomClasseObjet1="InventaireDetailsObjetsItems";break;
						
				case 5: nomClasseObjet1="PNJdetails_habit_haut";nomClasseObjet2="PNJdetails_habit_haut_details";nomClasseObjet3="PNJdetails_habit_bras";break;
				case 6: nomClasseObjet1="PNJdetails_habit_bas";break;
				case 7: nomClasseObjet1="PNJdetails_pieds";nomClasseObjet2="PNJdetails_pieds";break;
				case 10: nomClasseObjet1="InventaireDetailsObjetsCoffre";break;
				default: ;break;
			}
			var classObjet1:Class=getDefinitionByName(nomClasseObjet1)as Class;
			var objetTemp1:MovieClip=new classObjet1();
			objetTemp1.name="objet1";
			objetTemp1.gotoAndStop(liste_Items[n][0][2]+1);
			Itemstemp.addChild(objetTemp1);
			if(liste_Items[n][0][1]==5||liste_Items[n][0][1]==7){
				var classObjet2:Class=getDefinitionByName(nomClasseObjet2)as Class;
				var objetTemp2:MovieClip=new classObjet2();
				objetTemp2.name="objet2";
				objetTemp2.gotoAndStop(liste_Items[n][0][2]+1);
				Itemstemp.addChild(objetTemp2);
				if(liste_Items[n][0][1]==5){
					var classObjet3:Class=getDefinitionByName(nomClasseObjet3)as Class;
					var objetTemp3:MovieClip=new classObjet3();
					objetTemp3.name="objet3";
					objetTemp3.gotoAndStop(liste_Items[n][0][2]+1);
					Itemstemp.addChild(objetTemp3);
				}
			}
			switch(liste_Items[n][0][1]){
				case 0: ;break;
				case 1: ;break;
				case 2: objetTemp1.y-=48;break;
				case 3: objetTemp1.y-=128;break;
				case 4: objetTemp1.y-=184;break;
				case 5: objetTemp1.scaleX=objetTemp1.scaleY=1.2;objetTemp1.x-=10;objetTemp1.y+=18;
						objetTemp2.scaleX=objetTemp2.scaleY=1.2;objetTemp2.x-=10;objetTemp2.y+=18;
						objetTemp3.scaleX=objetTemp3.scaleY=1.2;objetTemp3.x-=10;objetTemp3.y+=18;;break;
				case 6: objetTemp1.scaleX=objetTemp1.scaleY=1.2;objetTemp1.x-=12;objetTemp1.y+=4;;break;
				case 7: objetTemp1.scaleX=objetTemp1.scaleY=1.2;objetTemp1.x+=10;objetTemp1.y-=2;
						objetTemp2.scaleX=objetTemp2.scaleY=1.2;objetTemp2.x-=10;objetTemp2.y-=2;break;
				case 10: ;break;
			}
			Itemstemp.x=liste_Items[n][1][2];
			Itemstemp.y=liste_Items[n][1][3];
				
			testItemstemp.x=liste_Items[n][1][2]+12;
			testItemstemp.y=liste_Items[n][1][3]+24;
			testItemstemp.alpha=0;
				
			conteneurItems.addChild(Itemstemp);
			conteneurItems.addChild(testItemstemp);
			animer_Items(n);
		}
//GESTION ITEM==============================================================================================================================================
		private function gestionItem(empPris:Array,nPose:Array,affiche:Boolean=true){
			
			var ligne:int=empPris[0];
			var colonne:int=empPris[1];
			var inMem:Boolean=false;
			var inMemN:int=0;
			for(var n:int=0;n<liste_Items.length;n++) {
				var L:int=liste_Items[n][1][0];
				var C:int=liste_Items[n][1][1];
				if(colonne==C&&ligne==L){
					inMemN=n;
					inMem=true;
				}				
			}
			var objetPris:Array=new Array;
			if(inMem==true){objetPris=liste_Items[inMemN];}else{objetPris[0]=[0,0,0];}
			var tp:Array=[721+nPose[0]*20+nPose[1],nPose[0],nPose[1]]
			var ps:Array=donnerPosition(ligne,colonne)
			var objetPose:Array=[tp,ps,true,true];
			if(objetPose[0][1]==0){
				if(inMem==true){
					suprimerItem(inMemN,false);miseEnMemoire(inMemN);
				}
			}
			if(objetPose[0][1]!=0&&
				(objetPose[0][1]!=objetPris[0][1]||
				objetPose[0][2]!=objetPris[0][2])){
				if(inMem==true){
					suprimerItem(inMemN,true);
					liste_Items[inMemN][0]=objetPose[0];
					if(affiche==true){initialisationItem(inMemN);}
					miseEnMemoire(inMemN);
				}
				if(inMem==false){
					liste_Items.push(objetPose);
					var nFin:int=liste_Items.length-1
					if(affiche==true){initialisationItem(nFin);}
					if(affiche==false){liste_Items[nFin][3]=false;}
					miseEnMemoire(nFin);
				}
			}
		}
		public function suprimerItem(n:int,ajout:Boolean=false){
			var nom:String="Item"+n;
			var nomTest:String="TestItem"+n;
			if(ajout==true){
				suprimer();
			}
			if(ajout==false){
				liste_Items[n][2]=false;
				liste_Items[n][3]=false;
				suprimer();
			}
			function suprimer(){
				for(var n:int=0; n<conteneurItems.numChildren; n++) {
					var nomItem=conteneurItems.getChildAt(n).name;
					if(nom==nomItem){
						conteneurItems.removeChild(conteneurItems.getChildByName(nom));
						conteneurItems.removeChild(conteneurItems.getChildByName(nomTest));
					}
				}
			}
		}
//ANIMER ITEM==========================================================================================================
		public function animer_Items(n:int){
			var nom:String="Item"+n;
			var category:int=liste_Items[n][0][1];
			var type:int=liste_Items[n][0][2];
			switch(category){
				case 0:
					MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).gotoAndStop(Math.round(type/2));
					MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(type/Math.round(type/2));
					if(type%2!=0){MovieClip(MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).getChildAt(0)).gotoAndStop(initialiserPorteCle(n));}
					break;
				case 1:
					var nP:int=0;
					switch(type){
						case 1: nP=1;break;
						case 2: nP=3;break;
						case 3: nP=5;break;
					}
					for(var i:int=0;i<nP;i++){
						MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(i)).gotoAndPlay(Math.round(Math.random()*8));
					}
					break;
				case 10:
					MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(1);
					break;
			}
		}
		public function deplacer(controlesX:int,controlesY:int){
			
			var controlesD:Array=new Array;
			controlesD[0]=controlesX;
			controlesD[1]=controlesY;
			
			if(controlesD[0]!=0){
				conteneurItems.x+=controlesD[0]*vitesseDG;
			}
			if(controlesD[1]!=0){
				conteneurItems.y+=controlesD[1]*vitesseHB;
			}
		}
		public function deplacer_Items(control:Array,controlDecor:Array){
			interagir_Items(control,controlDecor);
		}
//INTERAGIR ITEM===========================================================================================================================================================	
		function interagir_Items(control:Array,controlDecor:Array){
			monHerosHitTest.alpha=alphaTest;
			monHerosHitTest.x=464+controlDecor[0]*vitesseDG;
			monHerosHitTest.y=464;
			armePlus=false;
			itemPlus=false;
			habitPlus=false;
			pieces=[false,0];
			cle=[false,0];
			coffreOuvrir=false;
			serrureOuvrir=[false,0];
			porteFermeCle=false;
			porteOuvrir=porteFermer=false;
			blockPorte=false;
			porteCote=false;
			
			for(var n:int=0; n<liste_Items.length; n++) {
				var nom:String="Item"+n;
				var nomTest:String="TestItem"+n;
				var category=liste_Items[n][0][1];
				var L:int=liste_Items[n][1][0];
				var C:int=liste_Items[n][1][1];
				var ct:int=0;
				var tp:int=0;
				if(conteneurItems.getChildByName(nomTest) is DisplayObject==true){conteneurItems.getChildByName(nomTest).alpha=alphaTest;}
				if(liste_Items[n][3]==true&&monstreTouche==false){
					switch(category){
//PORTE========================================================================================================================
					case 0: 
						var type=Math.round(liste_Items[n][0][2]/2);
						var imagePorte=MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).currentFrame;
						switch(type){
							case 1:
								if(imagePorte==1){
									conteneurItems.getChildByName(nomTest).width=16;
									conteneurItems.getChildByName(nomTest).x=liste_Items[n][1][2]+24;
								}else{
									conteneurItems.getChildByName(nomTest).width=8;
									conteneurItems.getChildByName(nomTest).x=liste_Items[n][1][2]+28;
								}
								conteneurItems.getChildByName(nomTest).y=liste_Items[n][1][3]+28;
								conteneurItems.getChildByName(nomTest).height=8;
								
								break;
							case 2:
								conteneurItems.getChildByName(nomTest).x=liste_Items[n][1][2];
								conteneurItems.getChildByName(nomTest).y=liste_Items[n][1][3]-64;
								conteneurItems.getChildByName(nomTest).height=128;
								conteneurItems.getChildByName(nomTest).width=64;
								break;
						}
						if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))&&blocker==false){
							if(liste_Items[n][0][2]%2!=0){
								if(type==1){porteFermeCle=true;}
								if(type==2){blockPorte=true;}
								if((interupteur(control[3])==1||type==2)&&checkCle(liste_Items[n][0][3])==true){
									MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(3);
									serrureOuvrir[0]=true;
									serrureOuvrir[1]=liste_Items[n][0][3];
									porteFermeCle=false;
											
									liste_Items[n][0][0]+=1;
									liste_Items[n][0][2]+=1;
											
									miseEnMemoire(n);
								}
							}
							if(liste_Items[n][0][2]%2==0){
								if(interupteur(control[3])==1||(type==2&&imagePorte!=3)){
									porteOuvrir=true;
									MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(3);
								}
							}
							if(type==2){porteCote=true;}
						}else{
							
							if(imagePorte==3){porteFermer=true;}
							if(liste_Items[n][0][2]%2!=0){
								MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(1);
							}
							if(liste_Items[n][0][2]%2==0){
								MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(2);
							}
						}
					break;
//PIECES========================================================================================================================
					case 1:
						if(liste_Items[n][2]==true&&blocker==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								pieces[0]=true;
								pieces[1]=liste_Items[n][0][2];
								
								gestionItem([L,C],[ct,tp]);
							}
						}
					break;
//CLE========================================================================================================================
					case 2:
						if(liste_Items[n][2]==true&&blocker==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								cle[0]=true;
								cle[1]=liste_Items[n][0][2];
								
								gestionItem([L,C],[ct,tp]);
							}
						}
					break;
//ARME========================================================================================================================
					case 3:
						if(liste_Items[n][2]==true&&blocker==false&&attack==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								if(interupteur(control[3])==1&&armeUtilise!=liste_Items[n][0][2]){
									armePlus=true;
									if(armeUtilise!=0){ct=3;tp=armeUtilise;}
									armeUtilise=liste_Items[n][0][2];
									gestionItem([L,C],[ct,tp]);
								}
							}
						}
					break;
//ITEM========================================================================================================================
					case 4:
						if(liste_Items[n][2]==true&&blocker==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								if(interupteur(control[3])==1&&itemUtilise!=liste_Items[n][0][2]){
									itemPlus=true;
									if(itemUtilise!=0){ct=4;tp=itemUtilise;}
									itemUtilise=liste_Items[n][0][2];
									gestionItem([L,C],[ct,tp]);
								}
							}
						}
					break;
//HABITS========================================================================================================================
		//HAUT-----------------------------------------------------------
					case 5:
						if(liste_Items[n][2]==true&&blocker==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								if(interupteur(control[3])==1){
									habitPlus=true;changerHabit(n);
								}
							}
						}
					break;
		//BAS-------------------------------------------------------------
					case 6:
						if(liste_Items[n][2]==true&&blocker==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								if(interupteur(control[3])==1){
									habitPlus=true;changerHabit(n);
								}
							}
						}
					break;
		//PIEDS------------------------------------------------------------
					case 7:
						if(liste_Items[n][2]==true&&blocker==false){
							if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))){
								if(interupteur(control[3])==1){
									habitPlus=true;changerHabit(n);
								}
							}
						}
					break;
//COFFRE========================================================================================================================
					case 10:
						if (monHerosHitTest.hitTestObject(conteneurItems.getChildByName(nomTest))&&blocker==false&&touche_sol){
							if(interupteur(control[3])==1){
								MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(2);
								initialiserObjetCoffre(n);
								coffreOuvrir=true;
								stage.dispatchEvent(new Event("ouvreCoffre"));
								
							}
						}else{MovieClip(MovieClip(MovieClip(conteneurItems.getChildByName(nom)).getChildByName("objet1")).getChildAt(0)).gotoAndStop(1);}
					break;
//FIN...............========================================================================================================================
					default:
							
					break;
					}
				}
				tableauSon=[coffreOuvrir,serrureOuvrir[0],porteOuvrir,porteFermer];
			}
		}
//MEMOIRE=====================================================================================================================================MEMOIRE================================
		public function miseEnMemoire(nItem:int){
		
			var inMemory:Boolean=false;
			var inMemoryN:int=0;
			var longueurTableau:int=tableauMemoire.length;
			
			for(var n:int=0; n<longueurTableau;n++) {
				if(tableauMemoire[n][0]==dossier&&tableauMemoire[n][1]==fichier&&tableauMemoire[n][2]=="Items"&&
					tableauMemoire[n][3][1][0]==liste_Items[nItem][1][0]&&tableauMemoire[n][3][1][1]==liste_Items[nItem][1][1]){
					tableauMemoire.splice(n,1,[dossier,fichier,"Items",liste_Items[nItem],false]);
					inMemoryN=n;
					inMemory=true;
				}				
			}
			if(inMemory==true&&liste_Items[nItem][2]==false){
				var C:int=liste_Items[nItem][1][0];
				var L:int=liste_Items[nItem][1][1];
				if(carteItems[L][C]==1){
					tableauMemoire.splice(inMemoryN,1);
				}
			}
			if(inMemory==false){
				tableauMemoire.push([dossier,fichier,"Items",liste_Items[nItem],false]);
			}
		}
		public function memoire(){
			tableauMemoire=memoireItems;
			for(var n:int=0; n<memoireItems.length; n++) {
				if(memoireItems[n][0]==dossier&&memoireItems[n][1]==fichier&&memoireItems[n][2]=="Items"){
					var itemEnMemoire:Array=memoireItems[n][3];
					var ajout:Boolean=itemEnMemoire[2];
					
					var type:int=itemEnMemoire[0][1];
					ajoutObjet(n,ajout);
				}
			}
			
			function ajoutObjet(item:int,ajout:Boolean){
				var inMemory:Boolean;
				var inMemoryN:int=0;
				var itemEnMemoire:Array=memoireItems[item][3];
				var type:int=itemEnMemoire[0][1];
				var ligne:int=itemEnMemoire[1][0];
				var colonne:int=itemEnMemoire[1][1];
				
				var itemInit:Array=initialiserItemMemPosition(item);
				
				for(var n:int=0; n<liste_Items.length; n++) {
					var L:int=liste_Items[n][1][0];
					var C:int=liste_Items[n][1][1];
					if(colonne==C&&ligne==L){inMemoryN=n;inMemory=true;}
				}
				if(inMemory==false){
					if(ajout==true){liste_Items.unshift(itemInit);}
					if(ajout==false){liste_Items.splice(inMemoryN,1);}
				}
				if(inMemory==true){
					if(ajout==true){liste_Items.splice(inMemoryN,1,itemInit);}
					if(ajout==false){liste_Items.splice(inMemoryN,1);}
				}
			}
			function initialiserItemMemPosition(n:int):Array{
				var itemMem:Array=new Array;
				itemMem[0]=memoireItems[n][3][0];
				itemMem[1]=donnerPosition(memoireItems[n][3][1][0],memoireItems[n][3][1][1]);
				itemMem[2]=memoireItems[n][3][2];
				itemMem[3]=memoireItems[n][3][3];
				return(itemMem);
			}
		}
		public function changerHabit(n:int){
			var nObjet:int=0;
			var L:int=liste_Items[n][1][0];
			var C:int=liste_Items[n][1][1];
			var ct:int=liste_Items[n][0][1];
			var tp:int=inventaireRetour[ct-5];
			
			if(tp==0){ct=0;}
			habitPris[0]=liste_Items[n][0][1]-5;
			habitPris[1]=liste_Items[n][0][2]+1;
			gestionItem([L,C],[ct,tp-1]);
		}
		public function viderObjetCoffre(){
			while(retourObjet.length>0){retourObjet.splice(0,1);}
		}
		public function initialiserObjetCoffre(nObjet:int){
			
			var ligne=liste_Items[nObjet][1][0];
			var colonne=liste_Items[nObjet][1][1];
			for(var o:int=-1;o<2;o++) {
				var itemP:Boolean=false;
				var item:int=0;
				for(var n:int=0;n<liste_Items.length;n++) {
					var L:int=liste_Items[n][1][0];
					var C:int=liste_Items[n][1][1];
					if(colonne+1==C&&ligne+o==L&&liste_Items[n][2]==true){item=n;itemP=true;}
				}
				
				if(itemP==true){retourObjet[o+1]=initialiser(item);}else{retourObjet[o+1]=[0,0,0];}
			}
			retourObjet[3]=liste_Items[nObjet][1];
			function initialiser(objetN:int):Array{
				var controlObjet:Array=new Array;
				controlObjet[0]=liste_Items[objetN][0][0];
				controlObjet[1]=liste_Items[objetN][0][1];
				controlObjet[2]=liste_Items[objetN][0][2];
				return(controlObjet);
			}
		}
		public function initialiserPorteCle(nPorte:int):int{
			var control:int=1;
			var ligne=liste_Items[nPorte][1][0];
			var colonne=liste_Items[nPorte][1][1];
			for(var n:int=0;n<liste_Items.length;n++) {
				var L:int=liste_Items[n][1][0];
				var C:int=liste_Items[n][1][1];
				if(colonne+1==C&&ligne==L&&liste_Items[n][2]==true){
					control=liste_Items[n][0][2];
					if(liste_Items[nPorte][0][3]==undefined){liste_Items[nPorte][0][3]=control;}
				}
			}
			return(control);
		}
		public function checkCle(typeSerrure){
			var control:Boolean=false;
			for(var n:int=0;n<tableauCle.length;n++){
				if(tableauCle[n]==typeSerrure){
					control=true;
				}
			}
			return(control);
		}
		public function modifierObjetCoffre(){
			viderObjetCoffre();
			var control:Array=new Array;
			var ligne=initialisationCoffre[3][0];
			var colonne=initialisationCoffre[3][1];
			for(var o:int=-1;o<2;o++) {
				var L:int=ligne+o;
				var C:int=colonne+1;
				var ct:int=initialisationCoffre[o+1][1];
				var tp:int=0
				if(initialisationCoffre[o+1][2]>0){tp=initialisationCoffre[o+1][2];}
				gestionItem([L,C],[ct,tp],false);
			}
		}
		public function testerPorteCle(){
			for (var n:int=0; n<liste_Items.length;n++){
				var category=liste_Items[n][0][1];
				var Lporte=liste_Items[n][1][1];
				var Cporte=liste_Items[n][1][0];
				var Lheros=carte_ligne_depart+8;
				var Cheros=carte_colonne_depart+8;
				if(category==0&&liste_Items[n][0][2]%2!=0){
					if(Lporte==Lheros&&Cporte==Cheros){
						liste_Items[n][0][0]+=1;
						liste_Items[n][0][2]+=1;
						miseEnMemoire(n);
					}
				}
			}
		}
		public function controlHitTestArmes(control:Array){
			attack=control[0];
		}
		private function interupteur(control:int=0){
			var retour:int=0;
			if(control!=0&&interupteurAppuie==false){retour=control;interupteurAppuie=true;}else{retour=0}
			if(control==0){interupteurAppuie=false;}
			return(retour);
		}
		public function block(){blocker=true;}
		public function deblock(){blocker=false;}
	}
}