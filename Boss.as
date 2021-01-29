package{

	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Boss extends MovieClip{
		public var alphaTest:int=1;
		
		public var conteneur=new MovieClip();
		
		public var controles:Array=new Array();
		public var controlesDecor:Array=new Array();
		
		public var idBoss:int=0;
		public var carte_ligne_depart:int=0;
		public var carte_colonne_depart:int=0;
		
		public var attack:Boolean=false;
		public var herosAffaibli:Array=[false,0];
		public var herosImunise:Boolean=false;
		public var hitTestB_H:Boolean=false;
		public var hitTestA_B:Boolean=false;
		public var hitTestP_B:Boolean=false;
		public var hitTestP_H:Boolean=false;
		
		public var liste_propriete:Array=new Array();
//=====================================================
		
		public function Boss(){
			
		}
//CREER PROPRITETE================================================================================
		public function creerPropriete(n:int,pcarte_colonne_depart:int,pcarte_ligne_depart:int):Array{
			carte_ligne_depart=pcarte_ligne_depart;
			carte_colonne_depart=pcarte_colonne_depart;
			var prop:Array=[donnerType(n),donnerPosition(n),donnerPropriete(n),donnerEtat(n),donnerObjet(n)];
			return(prop);
		}
	//TYPE.................................................................
		public function donnerType(n:int):Array{
			var tableauTemp:Array=new Array;
			var type:int=100;
			var category:int=n
			
			tableauTemp[0]=type;
			tableauTemp[1]=category;
			
			return(tableauTemp);
		}
	//POSITION....................................................
		private function donnerPosition(n:int):Array{			
			var tableauTemp:Array=new Array;
			var L:int=0;
			var C:int=0;
			var testX:int=0;
			var testY:int=0;
			var sizeX:int=0;
			var sizeY:int=0;
			switch(n){
				case 1: L=28;C=15;testX=0;testY=-12;sizeX=64;sizeY=64;break;
			}
			tableauTemp[0]=L;
			tableauTemp[1]=C;
			tableauTemp[2]=C*64-carte_colonne_depart*64-64;
			tableauTemp[3]=L*64-carte_ligne_depart*64-64;
			tableauTemp[4]=tableauTemp[2]+testX;
			tableauTemp[5]=tableauTemp[3]+testY;
			tableauTemp[6]=sizeX;
			tableauTemp[7]=sizeY;
			return(tableauTemp);
		}
	//PROPRIETE....................................................
		private function donnerPropriete(n:int):Array{
			var tableauTemp:Array=new Array;
			var sens:Array=new Array;
			var vitesse:Array=new Array;
			var action:int=0;
			var compteur:int=0;
			var parametrePlus:Array=new Array();
			var distanceXY:Array=new Array();
			var projectile:Array=[false,false,false];
			switch(n){
				case 1://Araigne-----------------------------
					sens=[0,0];
					vitesse=[8,16];
					action=1;
					parametrePlus=[0,1];
					distanceXY=[0,0];
				;break;
			}	
			tableauTemp[0]=sens;
			tableauTemp[1]=vitesse;
			tableauTemp[2]=action;
			tableauTemp[3]=compteur;
			tableauTemp[4]=parametrePlus;
			tableauTemp[5]=distanceXY;
			tableauTemp[6]=projectile;
			return(tableauTemp);
		}
	//ETAT............................................................
		private function donnerEtat(n:int):Array{
			var tableauTemp:Array=new Array;
			var monstreTouche:Boolean=false;
			var monstreAffiche:Boolean=true;
			var monstreAffaibli:Boolean=false;
			var monstreToucheN:int=0;
			tableauTemp[0]=monstreTouche;
			tableauTemp[1]=monstreAffiche;
			tableauTemp[2]=monstreAffaibli;
			tableauTemp[3]=monstreToucheN;
			return(tableauTemp);
		}
	//OBJET............................................................
		private function donnerObjet(n:int):Array{
			var tableauTemp:Array=new Array;
			tableauTemp[0]=0;
			tableauTemp[1]=false;
			return(tableauTemp);
		}
		public function donnerListe():Array{
			return(liste_propriete);
		}
//REFLECHIR==================================================================================================================================
		public function reflechir_Boss(n:int,propriete:Array){
			var nom:String="Boss";
			liste_propriete=propriete;
			var type:int=liste_propriete[0][1];
			
			var sensDG:int=liste_propriete[2][0][0];
			var sensHD:int=liste_propriete[2][0][1];
			var action:int=liste_propriete[2][2];
			var vitesse:Array=liste_propriete[2][1];
			var nombreImage:int=liste_propriete[2][5][2];
			var nombreTotalImage:int=liste_propriete[2][5][3];
			var affaibli:Boolean=liste_propriete[3][2];
			var projectile:Array=liste_propriete[2][6];
			switch(type){
	//BOSS SPIDER===============================================================================
				case 1: 
					switch(action){
				//ARRET...............................
						case 1:
							liste_propriete[3][0]=false;
							liste_propriete[3][2]=false;
							if(liste_propriete[2][4][0]<=0){
								liste_propriete[2][4][1]+=1;
								liste_propriete[2][3]=0;
								if((liste_propriete[2][5][0]<=32||herosImunise==true||liste_propriete[2][5][4]<=620||
									(liste_propriete[2][4][1]>=6&&herosAffaibli[0]==false))&&liste_propriete[2][5][4]<=1800){liste_propriete[2][0][0]=2;}
								
								else if(liste_propriete[2][5][0]>=412||herosAffaibli[0]==true||liste_propriete[2][5][4]>=1800){liste_propriete[2][0][0]=1;}
								else{liste_propriete[2][0][0]=Math.round(1+Math.random()*1);}
								liste_propriete[2][4][0]=liste_propriete[2][4][0]=64*Math.round(1+Math.random()*2);
								if(liste_propriete[2][4][0]>=128){liste_propriete[2][2]=Math.round(2+Math.random()*1);}
								else{liste_propriete[2][2]=2;}
							}else{
								var r:int=Math.round(1+Math.random()*(2-liste_propriete[3][3]));
								if(affaibli==false&&
									herosAffaibli[0]==false&&
									projectile[1]==false&&
									liste_propriete[2][5][0]>=250&&
									(liste_propriete[2][3]>0&&r==1||liste_propriete[2][4][1]>=5)){
									liste_propriete[2][6][0]=true;//lance toile
									liste_propriete[2][3]=0;
									liste_propriete[2][4][1]=0;
								}else{liste_propriete[2][3]=0;}
								liste_propriete[2][0][0]=0;
								liste_propriete[2][0][1]=0;
								liste_propriete[2][4][0]-=8;
							}
						;break;
				//MARCHE.......................................
						case 2:
							liste_propriete[2][0][1]=0;
							if(liste_propriete[2][3]<=liste_propriete[2][4][0]){
								liste_propriete[2][2]=2;
						
								liste_propriete[2][3]+=vitesse[0];
							}else{liste_propriete[2][0][0]=0;liste_propriete[2][2]=1;}
						;break;
				//SAUTE.............................................
						case 3:
							if(liste_propriete[2][3]<liste_propriete[2][4][0]*2){
								liste_propriete[2][2]=3;
								liste_propriete[2][3]+=vitesse[1];
								if(liste_propriete[2][3]<=liste_propriete[2][4][0]){liste_propriete[2][0][1]=1;}
								else{liste_propriete[2][0][1]=2;}
							}else{liste_propriete[2][0][0]=0;liste_propriete[2][0][1]=0;liste_propriete[2][2]=1;}
						;break;
				//DANS TOILE........................................
						case 4:
							liste_propriete[2][0][0]=0;
							liste_propriete[2][0][1]=0;
							if(liste_propriete[2][3]<liste_propriete[2][4][0]){
								liste_propriete[2][2]=4;
								liste_propriete[2][3]+=1;
							}else{liste_propriete[2][2]=6;}
						;break;
				//SAUTE DANS TOILE........................................
						case 5:
							if(liste_propriete[2][3]<liste_propriete[2][4][0]*2){
								liste_propriete[2][2]=5;
								liste_propriete[2][3]+=vitesse[1];
								if(liste_propriete[2][3]<=liste_propriete[2][4][0]){liste_propriete[2][0][1]=1;}
								else{liste_propriete[2][0][1]=2;}
							}else{liste_propriete[2][0][0]=0;liste_propriete[2][0][1]=0;liste_propriete[2][2]=4;}
						;break;
				//ECLATE TOILE........................................
						case 6:
							if(nombreImage>=nombreTotalImage){liste_propriete[2][2]=1;}
						;break;
				//BOOM........................................
						case 7:
							liste_propriete[2][0][0]=0;
							if(nombreImage>=nombreTotalImage){
								liste_propriete[2][3]=30;
								liste_propriete[2][2]=9;
							}
						;break;
				//SAIGNE............................................
						case 8:
							liste_propriete[2][0][0]=0;
							if(nombreImage>=nombreTotalImage){
								liste_propriete[2][3]=30;
								liste_propriete[2][2]=10;
							}
						;break;
				//RUGIT........................................
						case 9:
							if(liste_propriete[2][3]<=0){
								liste_propriete[2][3]=0;
								liste_propriete[2][2]=11;
							}else{liste_propriete[2][3]--;}
						;break;
				//RUGIT SANG........................................
						case 10:
							if(liste_propriete[2][3]<=0){
								liste_propriete[2][3]=0;
								if(liste_propriete[3][3]>2){liste_propriete[2][2]=12;
								}else{liste_propriete[3][3]+=1;liste_propriete[2][2]=11;}
							}else{liste_propriete[2][3]--;}
						;break;
				//SE BAISSE........................................
						case 11:
							if(nombreImage>=nombreTotalImage){liste_propriete[2][2]=1;}
						;break;
				//SE BAISSE MORT........................................
						case 12:
							if(nombreImage>=nombreTotalImage){liste_propriete[2][2]=13;}
						;break;
				//VRAIMENT MORT........................................
						case 13:
							liste_propriete[2][2]=13;
						;break;
					}
				;break;
	//BOSS 2=======================================================================================
				case 2:
				;break;
			}
			interagirBoss(n);
		}
//INTERAGIR================================================================================================================
		public function interagirBoss(n:int){
			var nom="Boss";
			var nomTest="HitTestBoss";
			var type:int=liste_propriete[0][1];
			
			var touche:Boolean=liste_propriete[3][0];
			var affaibli:Boolean=liste_propriete[3][2];
			var projectile:Array=liste_propriete[2][6];
			switch(type){
	//BOSS SPIDER===============================================================================
				case 1:
				if(liste_propriete[2][2]!=10){
			//BOSS TOUCHE HEROS----------
					if(hitTestB_H==true&&affaibli==false){
						//liste_propriete[3][0]=true;
					}
			//ARME TOUCHE BOSS----------
					if(hitTestA_B==true){
						if(affaibli==true){
							liste_propriete[2][2]=8;
						}
						if(affaibli==false&&liste_propriete[2][2]!=3){
							liste_propriete[3][0]=true;
							liste_propriete[2][2]=7;
						}
					}
			//PROJECTILE TOUCHE BOSS----------------
					if(hitTestP_B){
						liste_propriete[3][2]=true;
						if(liste_propriete[2][2]==3){liste_propriete[2][2]=5;}
						if(liste_propriete[2][2]<3){liste_propriete[2][2]=4;}
					}
				}
				;break;
	//BOSS 2=======================================================================================
				case 2:
				;break;
			}
			/*if(attackToile==true&&finAttack==true&&dansToile==true){comptAttack+=1;finAttack=false;}
			if(attackToile==false){finAttack=true;}
			if(comptAttack==5){dansToile=false;comptAttack=0;}*/
		}
	}
}