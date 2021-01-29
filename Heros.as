package{
	import flash.display.*;
	import flash.events.Event;
	
	public class Heros extends MovieClip{
		
		public var conteneur:Sprite=new Sprite;
		private var itoucheSol:Boolean=false;
		private var toucheSol_time:int=0;
		
		private var herosDG:int=0;
		private var herosHB:int=0;
		private var herosSaut:int=0;	
		private var herosAttack:int=0;
		private var retourAttack:int=0;
		private var topAttack:Boolean=false;
		private var finAttack:Boolean=false;
		public var vitesseDG:int=0;
		public var vitesseHB:int=0;
		public var decorSens:Array=new Array();
		public var frappe:Boolean=false;
		public var frappeForce:int=0;
		public var armeHitTest:Array=new Array();
		
		private var derapage:Boolean=false
		
		public var herosAffaibli:Array=[false,0];
		public var finAffaibli:Boolean=false;
		public var sortirAffaibliN:int=0;
		
		private var decorDG:int=0;
		private var sensDecorDG:int=0;
		private var decorHB:int=0;
		private var decorSaut:int=0;
		private var decorToucheSol:int=0;
		private var decorCours:int=0;
		private var decorEchelle:int=0;
		private var decorMort:int=0;
		private var controlHeros:int=0;
		public var herosSens:int=1;
		private var herosAlpha:Boolean=true;
		private var boom:Boolean=false;
		private var finControl:Boolean=false;
		
		public var heros=new MovieClip();
		public var herosTete=new MovieClip();
		public var herosHabit=new MovieClip();
		public var herosPieds=new Mouvement_pieds();
		
		public var herosArme=new Armes();
		public var armeUtilise:int=0;
		
		public var herosSourcil=new PNJdetails_sourcil();
		public var herosVisage=new PNJdetails_visage();
		public var herosOeil=new PNJdetails_oeil();
		public var herosCasque=new Mouvement_casque();
		
		public var herosHabitBas=new PNJdetails_habit_bas();
		public var herosHabitHaut=new PNJdetails_habit_haut();
		public var herosHabitDetails=new PNJdetails_habit_haut_details();
		public var herosBras=new Mouvement_bras();
		
		public var herosEffets=new PNJdetails_effets();
		
		public var monProjectile:Projectiles=new Projectiles;
		
		public var type:String;
		public var idType:String;
		
		public var inventaire:Array=new Array;
		
		public var tableauSon:Array=new Array();
		
		public function Heros(pType:String,pidType:int):void{
			creerPersonnage();
		}
		public function creerPersonnage(){
			addChild(conteneur);
			conteneur.addChild(heros);
			
//HEROS PIEDS=============================================================
			herosPieds.x=-32;
			herosPieds.y=-20;
			herosPieds.gotoAndStop(1);
			MovieClip(MovieClip(herosPieds.getChildAt(0)).getChildAt(0)).gotoAndStop(2);
			MovieClip(MovieClip(herosPieds.getChildAt(0)).getChildAt(1)).gotoAndStop(2);
			heros.addChild(herosPieds);
//HEROS HABIT=============================================================		
			herosHabitBas.x=-32;
			herosHabitBas.y=-20;
			
			herosHabitHaut.x=-32;
			herosHabitHaut.y=-20;
			
			herosHabitDetails.x=-32;
			herosHabitDetails.y=-20;
			
			herosHabitBas.gotoAndStop(1);
			herosHabitHaut.gotoAndStop(1);
			herosHabitDetails.gotoAndStop(1);
			
			herosHabit.addChildAt(herosHabitBas,0);
			herosHabit.addChildAt(herosHabitHaut,1);
			herosHabit.addChildAt(herosHabitDetails,2);
			
			heros.addChild(herosHabit);
//HEROS BRAS=================================================================
			herosBras.x=-22;
			MovieClip(herosBras.getChildAt(0)).gotoAndStop(2);
			herosBras.cacheAsBitmap=true;
			heros.addChild(herosBras);
//HEROS TETE=============================================================
			heros.addChild(herosTete);
			
			herosVisage.x=-32;
			herosVisage.y=-45;
			herosVisage.cacheAsBitmap=true;
			herosVisage.gotoAndStop(2);
			herosTete.addChild(herosVisage);
			
			herosOeil.x=-32;
			herosOeil.y=-45;
			herosOeil.cacheAsBitmap=true;
			herosOeil.gotoAndStop(2);
			herosTete.addChild(herosOeil);
			
			herosCasque.x=-32;
			herosCasque.y=-45;
			herosCasque.cacheAsBitmap=true;
			herosCasque.gotoAndStop(1);
			MovieClip(herosCasque.getChildAt(0)).gotoAndStop(2);
			herosTete.addChild(herosCasque);
			
			herosSourcil.x=-32;
			herosSourcil.y=-45;
			herosSourcil.cacheAsBitmap=true;
			herosTete.addChild(herosSourcil);
//HEROS ARME=============================================================
			herosArme.name="Armes";
			heros.addChild(herosArme);
			
//PROJECTILE===============================================================
			monProjectile.name="Projectiles";
			monProjectile.x=480;
			monProjectile.y=480;
			conteneur.addChild(monProjectile);
			
//EFFETS===================================================================
			herosEffets.name="Effet";
			herosEffets.x=480;
			herosEffets.y=480;
			herosEffets.gotoAndStop(0);
			conteneur.addChild(herosEffets);
		}
//RUN CINE===============================================================================================================================
		public function afficherHerosCine(pTableauControl:Array){
			
			var pied:int=pTableauControl[0];
			var arme:int=pTableauControl[1];
			var visage:int=pTableauControl[2];
			var oeil:int=pTableauControl[3];
			var casque:int=pTableauControl[4];
			var habit:int=pTableauControl[5];
			var bras:int=pTableauControl[6];
			var sac:int=pTableauControl[7];
			var effets:Array=[0,0];
			var invisible:Boolean=pTableauControl[8];
		
			afficher(pied,arme,visage,oeil,casque,habit,bras,effets,invisible);
		}
//RUN===================================================================================================================================
		public function afficherHeros(controles,controlesDecor,invenataireRetour:Array):void{
			
			inventaire=invenataireRetour;
			
			herosDG=controles[0];
			herosHB=controlesHB(controles[3]);
			herosSaut=controles[1];
			retourAttack=herosArme.attack;
			sensDecorDG=controlesDecor[0];
			decorSaut=controlesDecor[1];
			decorToucheSol=toucheSol(controlesDecor[1])
			decorCours=fCours(controlesDecor[4]);
			decorEchelle=controlesDecor[5];
			decorMort=controlesDecor[10];
			controlHeros=controlesDecor[6];
			
			if(decorMort==0){
				if(decorEchelle==0){herosAttack=controles[4];}else{herosAttack=0;}
				if(herosAttack==1&&finAttack==true&&topAttack==false){topAttack=true;finAttack=false;}else{topAttack=false;}
				if(herosAttack==0){finAttack=true;}
			}
			bougerHeros();
			bougerTete();
			
			afficher(
				 monPieds(),
				 monArme(),
				 monVisage(),
				 monOeil(),
				 monCasque(),
				 monHabit(),
				 monBras(),
				 monEffet());
		}
//FUNCTION DETAIL AFFICHAGE=================================================================================================================
		private function bougerHeros(){
			heros.x=480;
			heros.y=480;
			heros.rotation=0;
			if(decorMort!=0){
				
				if(decorMort==1){
					heros.rotation=-95;
					heros.y=512;
				}
				if(decorMort==2){
					if(heros.alpha>=1){herosAlpha=true;}
					if(heros.alpha<=0.75){herosAlpha=false;}
					if(herosAlpha==true){heros.alpha-=0.25;}
					if(herosAlpha==false){heros.alpha+=0.25;}
					if(herosDG!=0){heros.scaleX=herosSens=herosDG;}
				}else{heros.alpha=1;}
			}else{
				heros.alpha=1;
				if(controlHeros==4){heros.y=484;}
				if(controlHeros==0){
					if(herosDG!=0){heros.scaleX=herosSens=herosDG;}
				}
			}
		}
//TETE=================================================================
		private function bougerTete(){
			herosTete.x=-3;
			herosTete.y=-16;
			
			if(decorMort!=0){
				if(decorMort==1){
					herosTete.rotation=-40;
				}
				if(decorMort==10){herosTete.rotation=-40;}
				if(decorMort==11){herosTete.y-=32;}
			}else{
				if(controlHeros==4){herosTete.rotation=-10*herosDG;}
				if(controlHeros==0){
					if(decorEchelle==1){
						herosTete.y=-17;
						herosTete.x=-2;
						if(herosHB==1){herosTete.rotation=-10;}
						if(herosHB==-1){herosTete.rotation=15;}
					}else{
						herosTete.rotation=0;
					}
					if(decorSaut==1||decorSaut==-1){decorDG=herosDG;}else{decorDG=sensDecorDG;}
					if((decorSaut==-1||decorSaut==3)&&decorEchelle==0){herosTete.y=-18;}
					if((herosDG!=decorDG)&&decorToucheSol==2){derapage=true;}else{derapage=false;}
					if(decorCours!=0){herosTete.x=0;}
				}	
			}
		}
//PIEDS=================================================================
		private function monPieds():uint{
			var pieds:int=1;
			var time:int;
			herosPieds.x=-32;
			herosPieds.y=-20;
			if(decorMort!=0){
				if(decorMort==1){pieds=1;}
				if(decorMort==2){pieds=2;}
				if(decorMort==10){herosPieds.alpha=0;}
				if(decorMort==11){pieds=3;herosPieds.y+=32;}
			}else{
				herosPieds.alpha=1;
				if(controlHeros==9){pieds=1;}
				if(controlHeros==3){pieds=7;herosPieds.x=-38;}
				if(controlHeros==4){pieds=4;herosPieds.x=-42;}
				if(controlHeros==0){
					if((decorDG!=0)&&(decorSaut==2)&&time==0){
						if(decorCours!=0||(derapage==true&&herosDG!=0)){
							if(decorCours==3){pieds=2;}else{pieds=9;}
						}else{
							if(decorToucheSol==3){pieds=1;}else{pieds=2;}
						}
					}
					if(decorSaut==5||(time>0&&time<5)){pieds=1;time+=1;}else{time=0;}
					if(decorSaut==1||decorSaut==-1||decorSaut==3){pieds=3;}
					if((decorEchelle==1)&&(herosHB!=0)&&(decorToucheSol!=2)){pieds=5;herosPieds.x=-38;herosPieds.y=-16;}
					if((decorEchelle==1)&&((herosHB==0)||(decorToucheSol==2))){pieds=6;herosPieds.x=-38;herosPieds.y=-16;}
					if(decorEchelle==0&&herosHB==1&&decorDG==0&&decorToucheSol==2){pieds=7;herosPieds.x=-38;}
					if(decorEchelle==0&&herosHB==-1){pieds=1;}
					if(decorSaut==4){pieds=2;}
				}
			}
			return (pieds);
		}
//ARME=================================================================
		private function monArme():uint{
			
			if(herosDG!=0){herosArme.herosSens=herosDG;}
			if(herosArme.projectilesActif==true){gestionProjectiles();}else{monProjectile.suprimerTout();}
			if(herosArme.armeUtilise==2){heros.setChildIndex(herosArme,3);}else{heros.setChildIndex(herosArme,heros.numChildren-1);}
			armeHitTest=herosArme.hitTestArme();
			
			var arme:uint=1;
			herosArme.x=-19;
			herosArme.y=16;
			herosArme.scaleX=1;
			if(decorMort!=0){
				if(decorMort==1){arme=1;}
				if(decorMort==2){arme=7;}
				if(decorMort==10){arme=7;}
			}else{
				if(controlHeros==9){arme=1;}
				if(controlHeros==2){arme=1;}
				if(controlHeros==3){arme=2;herosArme.x=8;}
				if(controlHeros==4){arme=2;herosArme.x=8;}
				if(controlHeros==0){
					if((decorDG!=0)&&(retourAttack==0)&&(decorSaut!=0)){if(decorCours!=0){arme=9;}else{arme=2;}}
					if((decorSaut==1||decorSaut==-1)&&retourAttack==0){if(decorCours!=0){arme=9;}else{arme=2;}}
					if((decorEchelle==1)&&(herosHB!=0)&&(decorToucheSol!=2)){arme=7;}
					if((decorEchelle==1)&&((herosHB==0)||(decorToucheSol==2))){arme=6;}
					if(decorEchelle==0&&herosHB==1&&decorDG==0&&decorToucheSol==2){arme=2;herosArme.x=8;}
					if(decorSaut==4){arme=7;}
				}
			}
			return(arme)
		}
//VISAGE=================================================================
		private function monVisage():uint{
			var visage:uint=13;
			herosSourcil.alpha=1;
			if(decorMort!=0){visage=11;}else{
				if(controlHeros==9){visage=13;}
				if(controlHeros==2){visage=13;}
				if(controlHeros==3){visage=11;herosSourcil.alpha=0;}
				if(controlHeros==4){visage=7;}
				if(controlHeros==0){
					if(decorDG!=0){if(decorCours!=0){if(decorCours==2){visage=9;}else{visage=14;}}else{visage=13;}}
					if(herosHB!=0&&decorDG==0){visage=6;}
					if(decorSaut==1||decorSaut==-1){visage=6;}
					if(decorSaut==3){visage=7;}
					if(retourAttack!=0){visage=10}
					if(decorEchelle!=0){visage=5;}
					if(decorSaut==4){visage=7;}
					if(decorEchelle==0&&herosHB==1&&decorToucheSol==2&&decorDG==0){herosSourcil.alpha=0;}
				}
			}
			return(visage)
		}
//OEIL=================================================================
		private function monOeil():uint{
			var oeil:uint=2;
			if(decorMort==1){oeil=1;}
			if(controlHeros==4){oeil=1;}
			return(oeil)
		}
//CASQUE=================================================================
		private function monCasque():uint{
			var casque:uint=1;
			if(decorMort!=0){casque=1;}else{
				if(controlHeros==9){casque=1;}
				if(controlHeros==2){casque=1;}
				if(controlHeros==3){casque=2;}
				if(controlHeros==0){
					if(decorEchelle==0&&herosHB==1&&decorToucheSol==2&&decorDG==0){casque=2;}
					else if((decorSaut==-1||decorSaut==3)&&decorEchelle==0){herosCasque.y=-47;}
					else{herosCasque.x=-32;herosCasque.y=-45;}
				}
			}
			return(casque)
		}
//BRAS=================================================================
		private function monBras():uint{
			var bras:uint=1;
			herosBras.x=-22;
			if(decorMort!=0){
				if(decorMort==1){bras=1;}
				if(decorMort==2){bras=7;}
				if(decorMort==10){bras=11;}
				if(decorMort==11){bras=3;herosBras.x-=32;}
			}else{
				if(controlHeros==9){bras=1;}
				if(controlHeros==3){bras=8;}
				if(controlHeros==4){bras=8;}
				if(controlHeros==0){
					if((decorDG!=0)&&(retourAttack==0)&&(decorSaut==2)){if(decorCours!=0){bras=9;}else{bras=2;}}
					if((decorSaut==1||decorSaut==-1)&&retourAttack==0){if(decorCours!=0){bras=9;}else{bras=2;}}
					if(retourAttack==1){
						switch(armeUtilise){
							case 0: bras=3;break;
							case 1: bras=3;break;
							case 2: bras=3;break;
							case 3: bras=10;break;
							default: break;
						}
					}
					if((decorEchelle==1)&&(herosHB!=0)&&(decorToucheSol!=2)){bras=7;}
					if((decorEchelle==1)&&((herosHB==0)||(decorToucheSol==2))){bras=6;}
					if(decorEchelle==0&&herosHB==1&&decorDG==0&&decorToucheSol==2){bras=8;}
					if(decorSaut==4){bras=7;}
				}
			}
			return(bras)
		}
//HABIT=================================================================
		private function monHabit():uint{
			var habit:int=1;
			herosHabit.x=0;
			MovieClip(herosHabit.getChildAt(2)).alpha=1;
			if(decorMort!=0){
				if(decorMort==1){habit=1;}
				if(decorMort==2){habit=1;}
				if(decorMort==10){habit=1;MovieClip(herosHabit.getChildAt(0)).alpha=0;}
			}else{
				MovieClip(herosHabit.getChildAt(0)).alpha=1;
				if(controlHeros==9){habit=1;}
				if(controlHeros==3){habit=-1;herosHabit.x=-4;}
				if(controlHeros==4){habit=-1;herosHabit.x=-4;}
				if(controlHeros==0){
					if((decorEchelle==1)&&(herosHB!=0)&&(decorToucheSol!=2)){habit=-1;herosHabit.x=-6;}
					if((decorEchelle==1)&&((herosHB==0)||(decorToucheSol==2))){habit=-1;herosHabit.x=-6;}
					if(decorEchelle==0&&herosHB==1&&decorDG==0&&decorToucheSol==2){habit=-1;herosHabit.x=-4;}
				}
			}
			if(habit==-1){MovieClip(herosHabit.getChildAt(2)).alpha=0;}
				
			return(habit)
		}
//EFFETS=================================================================
		private function monEffet():Array{
			var effet:Array=[1,0];
			var currentF:int=0;
			var totalF:int=0;
			conteneur.setChildIndex(herosEffets,conteneur.numChildren-1);
			if(decorMort!=0){
				if(decorMort==1){conteneur.setChildIndex(herosEffets,0);effet[0]=3;}
				if(decorMort==2&&finControl==true){herosEffets.x=480+herosSens*16;boom=true;}
				if(decorMort==11){effet[0]=6;}
				if(decorMort==10){effet[0]=1;}
			}else if(controlHeros!=0){
				if(controlHeros==9){effet[0]=1;}
				if(controlHeros==3){effet[0]=0;}
				if(controlHeros==4){
				   if(finControl==true){herosEffets.x=480+herosSens*16;boom=true;}else{effet[0]=2;}
				}
			}
			if(herosAffaibli[0]==true){
				effet[0]=5;
				if(topAttack==true){effet[1]=2;}else{effet[1]=1;}
				if(sortirAffaibli()==true||decorMort!=0){effet[0]=5;effet[1]=3;}
			}
			if(herosAffaibli[0]==false){
				if(boom==true){
					effet[0]=4;
					herosEffets.x-=decorSens[0]*vitesseDG;
					herosEffets.y+=decorSens[1]*vitesseHB;
				}
				if(boom==false){
					herosEffets.x=480;
					herosEffets.y=480;
				}
			}
			return(effet)
		}
//PROJECTILES=========================================================
		private function gestionProjectiles(){
			if(herosArme.frappe==true){
				frappe=true;
				monProjectile.projectileSens=herosSens;
				monProjectile.creer(herosArme.frappeForce);
			}else{frappe=false;}
			
			monProjectile.deplacer();
			herosArme.proprieteProjectile[0]=monProjectile.projectileActif;
			herosArme.proprieteProjectile[1]=monProjectile.positionX+464+(monProjectile.longueur+24)*herosSens;
			herosArme.proprieteProjectile[2]=monProjectile.positionY+480;
		}
//AFFICHAGE TOTAL========================================================================================================================
		public function afficher(ppieds:uint,
								 parme:uint,
								 pvisage:uint,
								 poeil:uint,
								 pcasque:uint,
								 phabit:int,
								 pbras:uint,
								 peffets:Array,
								 pinvisible:Boolean=false){
			
			
			if(herosAffaibli[0]==false){herosArme.afficherArme(parme,herosAttack);}else{herosArme.afficherArme(parme,false);}
			
			herosOeil.gotoAndStop(poeil);
			var attVisage:int=((pvisage-1)/4)+2;
			var attSourcil:int=((pvisage-1)-((attVisage-2)*4))+2;
			herosSourcil.gotoAndStop(attSourcil);
			herosVisage.gotoAndStop(attVisage);
			herosCasque.gotoAndStop(pcasque);
			MovieClip(herosCasque.getChildAt(0)).gotoAndStop(2);
			
			herosHabit.scaleX=phabit;
			MovieClip(herosHabit.getChildAt(0)).gotoAndStop(inventaire[1]);
			MovieClip(herosHabit.getChildAt(1)).gotoAndStop(inventaire[0]);
			MovieClip(herosHabit.getChildAt(2)).gotoAndStop(inventaire[0]);
			
			herosBras.gotoAndStop(pbras);
			MovieClip(MovieClip(herosBras.getChildAt(0)).getChildAt(0)).gotoAndStop(inventaire[0]);
			
			herosPieds.gotoAndStop(ppieds);
			MovieClip(MovieClip(herosPieds.getChildAt(0)).getChildAt(0)).gotoAndStop(inventaire[2]);
			MovieClip(MovieClip(herosPieds.getChildAt(0)).getChildAt(1)).gotoAndStop(inventaire[2]);
			
			if(pinvisible==true){conteneur.alpha=0;}else{conteneur.alpha=1;}
			herosEffets.gotoAndStop(peffets[0]);
			if(boom==true&&
				MovieClip(herosEffets.getChildAt(0)).currentFrame>=
				MovieClip(herosEffets.getChildAt(0)).totalFrames){
				boom=false;
			}
			if(peffets[1]!=0){
				MovieClip(herosEffets.getChildAt(0)).gotoAndStop(peffets[1]);
				if(peffets[0]==5&&peffets[1]==3&&
					MovieClip(MovieClip(herosEffets.getChildAt(0)).getChildAt(0)).currentFrame>=
					MovieClip(MovieClip(herosEffets.getChildAt(0)).getChildAt(0)).totalFrames){
					finAffaibli=false;herosAffaibli[0]=false;
				}
			}
			
			if(decorMort==0&&controlHeros==0){finControl=true;}else{finControl=false;}
			jouerSon(ppieds,herosAttack,pvisage,peffets,pinvisible);
		}
//SORTIE SON================================================================================================
		public function jouerSon(ppieds:uint,
								 parme:uint,
								 pvisage:uint,
								 peffets:Array,
								 pinvisible:Boolean=false){
			
			var sonPas:int=ppieds;
			var sonBouche:int=pvisage;
			var sonArme:Array=[herosArme.attack,herosArme.armeUtilise];
			var sonBoom:Array=peffets;
			var tableauTemp:Array=[sonPas,sonBouche,sonArme,sonBoom];
			
			tableauSon=tableauTemp;
		}
//fonction controles affinée=================================================================================
		public function sortirAffaibli():Boolean{
			var control:Boolean=false;
			if(topAttack==true){sortirAffaibliN+=10;}else{if(sortirAffaibliN>0){sortirAffaibliN-=1;}else{sortirAffaibliN=0;}}
			if(sortirAffaibliN>=50){finAffaibli=true;control=true;sortirAffaibliN=0;}
			if(herosAffaibli[0]==false||finAffaibli==true){control=true;}
			return(control);
		}
		private function fCours(control:int=0):int{
			var cours:int=0;
			if(control!=0){
				if(control==1){cours=1;}
				if(control==2){cours=2;}
				if(control==3){cours=3;}
			}else{cours=0;}
			return(cours);
		}
		private function controlesHB(control:int=0):int{
			var hautBas:int=0;
			if (control==-1){hautBas=-1;}
			if (control==0){hautBas=0;}
			if (control==1){hautBas=1;}
			return(hautBas);
		}
		private function toucheSol(control:int=0):int{
			var sol:int=0;
			if(itoucheSol==true&&toucheSol_time<=2){toucheSol_time+=1;sol=3;}else{
				if (control==2||control==0){sol=2;}
				if (control==5){itoucheSol=true;toucheSol_time=0;}else{itoucheSol=false;}
				if (control==1||control==-1){sol=0;}
			}
			return(sol);
		}
	}
}
		