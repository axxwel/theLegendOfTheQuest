package{
	import flash.display.*
	import flash.media.*
	import flash.utils.Timer;
	import flash.events.*;
	
	public class Sounds extends MovieClip{
	
//ARMES SOUNDS===================
		public var sonPoing:Sound=new PoingSound();
		public var sonEpee:Sound=new EpeeSound();
		public var sonBandeArc:Sound=new BandeArcSound();
		public var sonTireArc:Sound=new TireArcSound();
		public var sonMarteau:Sound=new MarteauSound();
		
//DECORS SOUNDS===================
		public var sonCascade:Sound=new CascadeSound();
		public var sonBoisCraque:Sound=new BoisCraqueSound();
		
//HEROS SOUNDS===================
		public var sonEchelle:Sound=new EchelleSound();
		public var sonMarche:Sound=new MarcheSound();
		public var sonDerapage:Sound=new DerapageSound();
		public var sonToucheSol:Sound=new ToucheSolSound();
		public var sonBoom:Sound=new BoomSound();
		public var sonCoucou:Sound=new CoucouSound();
		
		public var sonMort:Sound=new MortSound();
		public var sonPlouf:Sound=new PloufSound();
//ITEMS SOUNDS=====================
		public var sonPieces:Sound=new PiecesSound();
		public var sonCle:Sound=new CleSound();
		public var sonPrendreObjet:Sound=new PrendreObjetSound();
		public var sonPrendreArme:Sound=new PrendreArmesSound();
		public var sonCoffreOuvrir:Sound=new CoffreOuvrirSound();
		public var sonSerrureOuvrir:Sound=new OuvrirSerrureSound();
		public var sonPorteOuvrir:Sound=new PorteOuvrirSound();
		public var sonPorteFermer:Sound=new PorteFermerSound();
//MONSTRES SOUNDS==================
		public var sonCriMarchant:Sound=new CriMarchantSound();
		public var sonCriVolant:Sound=new CriVolantSound();
		public var sonCriPlante:Sound=new CriPlanteSound();
		public var sonCriRocher:Sound=new RocherSound();
		public var sonCriRonces:Sound=new CriRoncesSound();
//INVENTAIRE SOUNDS===============
		public var sonDeplacerInvt:Sound=new deplacerInvtSound();
		public var sonBeepNotInvt:Sound=new BeepNotInvtSound();
		public var sonCaissePrix:Sound=new CaissePrix();
//DIALOGUES SOUNDS================
		public var sonVoixA:Sound=new VoixA();
		public var sonVoixE:Sound=new VoixE();
		public var sonVoixI:Sound=new VoixI();
		public var sonVoixO:Sound=new VoixO();
		public var sonVoixU:Sound=new VoixU();
//CHANNELS=======================
		private var tableauFinSon:Array=new Array();
		
		public var pisteHeros0:SoundChannel=new SoundChannel;
		public var pisteHeros1:SoundChannel=new SoundChannel;	
		public var pisteHeros2:SoundChannel=new SoundChannel;	
		public var pisteArme3:SoundChannel=new SoundChannel;
		public var pisteArme4:SoundChannel=new SoundChannel;
		public var pisteMonstre5:SoundChannel=new SoundChannel;
		public var pisteMonstre6:SoundChannel=new SoundChannel;
		public var pisteItem7:SoundChannel=new SoundChannel;
		public var pisteItem8:SoundChannel=new SoundChannel;
		public var pisteInvt9:SoundChannel=new SoundChannel;
		public var pisteInvt10:SoundChannel=new SoundChannel;
		public var pisteInvt11:SoundChannel=new SoundChannel;
		public var pistePS12:SoundChannel=new SoundChannel;
		public var pistePS13:SoundChannel=new SoundChannel;
		public var pisteDial14:SoundChannel=new SoundChannel;		
//VAR PLATEFORME========================================
		var sautAutorise:Boolean=false;
//VAR===================================================
		private var derapage:Boolean=false;
		private var derapageT:Boolean=false;
		
		private var autoriseSonArme:Boolean=true;
		private var appuieTape:Boolean=false;
		private var mort:Boolean=true;
		
		private var time:int=0;
		
		public var sonsZone=0;
		public var volumeSonZone:int=0;
		
		public var blocker:Boolean=false;
//CONSTRUCTEUR============================================================================================================
		public function Sounds(){
			
		}
//COMANDE EXTERNES================================================================================================================
		public function gestionSon(pcontrolesHeros:Array,
								   pcontrolesMonstres:Array,
								   pcontrolesItems:Array,
								   pcontrolesInvt:Array,
								   pcontrolesDial:Array,
								   pcontrolesPS:Array,
								   pcontrolesGame:Array,
								   pcontrolesPad:Array,
								   pcontrolesDecor:Array){
			
			if(pcontrolesGame[4]==true){
				gestionSonHeros(pcontrolesHeros,pcontrolesPad,pcontrolesDecor);
				gestionSonArme(pcontrolesHeros);
				gestionSonMonstres(pcontrolesMonstres);
				gestionSonItem(pcontrolesItems,pcontrolesInvt[2]);
				gestionSonPS(pcontrolesPS);
			}
			if(pcontrolesGame[2]==true){
				gestionSonInventaire(pcontrolesInvt);
			}
			if(pcontrolesGame[3]==true){
				gestionSonDialogues(pcontrolesDial);
			}
		}
//SONS PLATEFORME====================================================================================================
	//GESTION SON HEROS==========================================================
		private function gestionSonHeros(controlesHeros:Array,controlesPad:Array,controlesDecor:Array){
			if(controlesPad[1]==0){sautAutorise=true;}
			if(controlesPad[1]==1&&controlesDecor[1]==2&&sautAutorise==true){jouerSonHeros("saut");modulerVolumeHeros(0,75);sautAutorise=false;}
			else if(controlesHeros[0]==2){jouerSonHeros("marche");
				if(controlesPad[0]!=0){modulerVolumeHeros(0);}else{modulerVolumeHeros(0,10);}
			}
			if(controlesHeros[0]==5){jouerSonHeros("echeles");modulerVolumeHeros(0,20);}
			
			if(controlesHeros[0]==9){jouerSonHeros("cours");modulerVolumeHeros(0);
				if(controlesPad[0]!=0){modulerVolumeHeros(0);}else{modulerVolumeHeros(0,20);}
			}
			if(controlesDecor[1]==5){jouerSonHeros("atterir");}
			if(controlesHeros[3][0]==4){jouerSonHeros("boom");}
			if(controlesHeros[3][0]==2){jouerSonHeros("coucou");}
			if(controlesDecor[3]==1){jouerSonHeros("derapage");}else{pisteHeros1.stop();tableauFinSon[1]=true;}
			
			if(controlesDecor[10]==0){mort=false;}else{
				if(mort==false){
					if(controlesDecor[10]==10){jouerSonHeros("mortEau");}
					if(controlesDecor[10]!=0){jouerSonHeros("mort");}
					mort=true;
				}
			}
		}
	//GESTION SON ARME==========================================================
		private function gestionSonArme(controlesHeros:Array){
			var tapeArme:int=armeAction(controlesHeros[2][0]);
			if(tapeArme==1){jouerSonArmeDebut(controlesHeros[2][1]);}
			if(tapeArme==2){modulerVolumeArme(100,true);jouerSonArmeFin(controlesHeros[2][1]);}
			if(controlesHeros[2][1]==2&&controlesHeros[2][0]==1){modulerVolumeArme(1);}
		}
	//GESTION SON MONSTRES======================================================
		private function gestionSonMonstres(controlesMonstres:Array){
			if(controlesMonstres[1]==true){jouerSonMonstre(controlesMonstres[0]);}
		}
	//GESTION SON ITEMS=========================================================
		private function gestionSonItem(controlesItem:Array,controlesItemInvt:Array){
			if(controlesItemInvt){
				if(controlesItemInvt[0]==true){
					jouerSonItem(controlesItemInvt[1],controlesItemInvt[2]);
				}
			}
			for(var i=0;i<controlesItem.length;i++){
				if(controlesItem[i]==true){jouerSonItem(i+4);}
			}
		}
	//GESTION SON PS=============================================================
		private function gestionSonPS(controlesPS:Array){
			if(controlesPS[0]!=0){jouerSonPS("boisCraque");}
		}
//SON INVENTAIRE===================================================================================================================================
	//GESTION SON INVENTAIRE====================================================
		private function gestionSonInventaire(controlesInvt:Array){
			var appuie:Boolean=controlesInvt[0][0];
			var imageSelecteur:int=controlesInvt[0][1];
			var objet_0:int=controlesInvt[0][2][0];
			var objet_1:int=controlesInvt[0][2][1];
			var objetSelect_0:int=controlesInvt[0][3][0];0
			var objetSelect_1:int=controlesInvt[0][3][1];
			var sonDep:Boolean=controlesInvt[1];
			var sonFact:Boolean=controlesInvt[3];
		//GESTION APPUIE SELECTEUR---------------------------
			if(imageSelecteur==3){jouerSonInvt("selection","not");}
			if(appuie==true){
				if(imageSelecteur==4){jouerSonInvt("selection","not");}
				if(imageSelecteur==1||imageSelecteur==2){
					if(objetSelect_0==1){jouerSonInvt("selection","prendPieces",objetSelect_1);}
					if(objetSelect_0==2){jouerSonInvt("selection","prendCle");}
					if(objetSelect_0==3){jouerSonInvt("selection","prendArme");}
					if(objetSelect_0==4){jouerSonInvt("selection","prendItem");}
					if(objetSelect_0>=5&&objetSelect_0<=7){jouerSonInvt("selection","prendHabit");}
					if(objet_0==3){jouerSonInvt("selection","poseArme");}
					if(objet_0==4){jouerSonInvt("selection","poseItem");}
					if(objet_0>=5&&objet_0<=7){jouerSonInvt("selection","poseHabit");}
				}
			}
		//GESTION DEPLACEMENT--------------------------------
			if(sonDep==true){
				jouerSonInvt("deplacement");
			}
		//GESTION FACTURE------------------------------------
			if(sonFact==true){
				jouerSonInvt("facture");
			}
		}
//SON DIALOGUES===================================================================================================================================
	//GESTION SON DIALOGUES============================================================
		private function gestionSonDialogues(controlesDial:Array){
			var sonActif:Boolean=controlesDial[0];
			var typeLettre:String=controlesDial[1];
			if(sonActif==true){
				jouerSonDial(typeLettre);
			}
		}
//JOUER SON HEROS==================================================================================================================================
		private function jouerSonHeros(pson:String){
			switch(pson){
				case "marche": 
					if(tableauFinSon[0]!=false){
						var m:int=Math.round(Math.random()*20);
						pisteHeros0=sonMarche.play(m);
						tableauFinSon[0]=false;
						pisteHeros0.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros0);
					}
				;break;
				case "cours": 
					if(tableauFinSon[0]!=false){
						pisteHeros0=sonMarche.play(90);
						tableauFinSon[0]=false;
						pisteHeros0.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros0);
					}
				;break;
				case "saut": 
						pisteHeros0=sonMarche.play(90);
				;break;
				case "derapage": 
					if(tableauFinSon[1]!=false){
						pisteHeros1=sonDerapage.play();
						tableauFinSon[1]=false;
						pisteHeros1.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros1);
					}
				;break;
				case "atterir": 
					if(tableauFinSon[2]!=false){
						pisteHeros2=sonToucheSol.play();
						tableauFinSon[2]=false;
						pisteHeros2.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros2);
					}
				;break;
				case "echeles": 
					if(tableauFinSon[0]!=false){
						var e:int=Math.round(Math.random()*20);
						pisteHeros0=sonEchelle.play(e);
						tableauFinSon[0]=false;
						pisteHeros0.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros0);
					}
				;break;
				case "boom": 
					if(tableauFinSon[2]!=false){
						pisteHeros2=sonBoom.play(120);
						tableauFinSon[2]=false;
						pisteHeros2.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros2);
					}
				;break;
				case "coucou": 
					if(tableauFinSon[2]!=false){
						pisteHeros2=sonCoucou.play();
						tableauFinSon[2]=false;
						pisteHeros2.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros2);
					}
				;break;
				case "mort": 
					if(tableauFinSon[2]!=false){
						pisteHeros2=sonMort.play(120);
						tableauFinSon[2]=false;
						pisteHeros2.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros2);
					}
				;break;
				case "mortEau": 
					if(tableauFinSon[0]!=false){
						pisteHeros0=sonPlouf.play(120);
						tableauFinSon[0]=false;
						pisteHeros0.addEventListener(Event.SOUND_COMPLETE,finSonpisteHeros0);
					}
				;break;
			}
			
		}
//JOUER SON ARMES====================================================================================================================
		private function jouerSonArmeDebut(arme:int){
			if(tableauFinSon[3]!=false){
				tableauFinSon[3]=false;
				switch(arme){
					case 0: pisteArme3=sonPoing.play();break;
					case 1: pisteArme3=sonEpee.play();break;
					case 2: pisteArme3=sonBandeArc.play();modulerVolumeArme(0,true);break;
					case 3: pisteArme3=sonMarteau.play();break;
				}
				pisteArme3.addEventListener(Event.SOUND_COMPLETE,finSonpisteArme3);
			}
		}
		private function jouerSonArmeFin(arme:int){
			switch(arme){
				case 2: pisteArme3=sonTireArc.play();break;
			}
		}
//JOUER SON MONSTRES===================================================================================================================
		private function jouerSonMonstre(typeMonstre:int){
			switch(typeMonstre){
				case 1: pisteMonstre5=sonCriMarchant.play();break;
				case 2: pisteMonstre5=sonCriVolant.play();break;
				case 3: pisteMonstre5=sonCriPlante.play();break;
				case 4: pisteMonstre5=sonCriRocher.play();break;
				case 5: pisteMonstre5=sonCriRocher.play();break;
				case 6: pisteMonstre5=sonCriRonces.play();break;
				case 7: pisteMonstre5=sonCriRonces.play();break;
			}
		}
//JOUER SON ITEMS=====================================================================================================================
		private function jouerSonItem(typeItem:int,typeComp:int=0){
			switch(typeItem){
				case 0: 
					switch(typeComp){
						case 1: pisteItem7=sonPieces.play(100);break;
						case 3: horloge(50,3,"piece");break;
						case 5: horloge(50,5,"piece");break;
					};break;
				case 1: pisteItem7=sonCle.play(100);break;
				case 2:	pisteItem7=sonPrendreArme.play();break;
				case 3: pisteItem7=sonPrendreObjet.play();break;
				case 4: pisteItem7=sonCoffreOuvrir.play();break;
				case 5: pisteItem7=sonSerrureOuvrir.play();break;
				case 6: pisteItem7=sonPorteOuvrir.play();break;
				case 7: pisteItem7=sonPorteFermer.play();break;
			}
		}
//JOUER SON INVENTAIRE=================================================================================================================
		private function jouerSonInvt(sonInvt:String,sonSelect:String="",pObjet:int=0){
			switch(sonInvt){
				case "deplacement": pisteInvt9=sonDeplacerInvt.play(30);break;
				case "facture": pisteInvt9=sonCaissePrix.play(30);break;
				case "selection": switch(sonSelect){
					case "not": 
						if(tableauFinSon[10]!=false){
							pisteInvt10=sonBeepNotInvt.play(30);
							tableauFinSon[10]=false;
							pisteInvt10.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
						}
					;break;
					case "prendPieces":
						if(tableauFinSon[10]!=false){
							switch(pObjet){
								case 2: pisteInvt10=sonPieces.play(100);break;
								case 3: horloge(50,3,"pieceCoffre");break;
								case 4: horloge(50,5,"pieceCoffre");break;
							};break;
							tableauFinSon[10]=false;
							pisteInvt10.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
						}
					;break;
					case "prendCle":
						if(tableauFinSon[10]!=false){
							pisteInvt10=sonCle.play(100);
							tableauFinSon[10]=false;
							pisteInvt10.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
						}
					;break;
					case "prendArme":
						if(tableauFinSon[10]!=false){
							pisteInvt10=sonPrendreArme.play();
							tableauFinSon[10]=false;
							pisteInvt10.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
						}
					;break;
					case "prendItem":
						if(tableauFinSon[10]!=false){
							pisteInvt10=sonPrendreObjet.play();
							tableauFinSon[10]=false;
							pisteInvt10.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
						}
					;break;
					case "prendHabit":
						if(tableauFinSon[10]!=false){
							pisteInvt10=sonPrendreObjet.play();
							tableauFinSon[10]=false;
							pisteInvt10.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
						}
					;break;
					case "poseArme":
						if(tableauFinSon[11]!=false){
							pisteInvt11=sonPrendreArme.play();
							tableauFinSon[11]=false;
							pisteInvt11.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt11);
						}
					;break;
					case "poseItem":
						if(tableauFinSon[11]!=false){
							pisteInvt11=sonPrendreObjet.play();
							tableauFinSon[11]=false;
							pisteInvt11.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt11);
						}
					;break;
					case "poseHabit":
						if(tableauFinSon[11]!=false){
							pisteInvt11=sonPrendreObjet.play();
							tableauFinSon[11]=false;
							pisteInvt11.addEventListener(Event.SOUND_COMPLETE,finSonpisteInvt11);
						}
					;break;
				}
				;break;
			}
		}
//JOUER SON PS========================================================================================================================
		public function jouerSonPS(nomSon:String){
			switch(nomSon){
				case "boisCraque": 
					if(tableauFinSon[12]!=false){
						pistePS12=sonBoisCraque.play(100);
						tableauFinSon[12]=false;
						pistePS12.addEventListener(Event.SOUND_COMPLETE,finSonpistePS12);
					}
				;break;
			}
		}
//JOUER SON DIALOGUES================================================================================================================
		public function jouerSonDial(typeLettre:String){
			switch(typeLettre){
				case "a":pisteDial14=sonVoixA.play(50);break;
				case "e":pisteDial14=sonVoixE.play(50);break;
				case "i":pisteDial14=sonVoixI.play();break;
				case "o":pisteDial14=sonVoixO.play(50);break;
				case "u":pisteDial14=sonVoixU.play();break;
			}
			var mixage:SoundTransform=pisteDial14.soundTransform;
			mixage.volume=0.2;
			pisteDial14.soundTransform=mixage;
		}
//MODULER VOLUME======================================================================================================================
	//VOLUME HEROS===============================================================
		private function modulerVolumeHeros(n:int,volP:int=100){
			var volumePas:Number=0;
			if(volP!=100){volumePas=volP;}else{volumePas=Math.round(25+Math.random()*25);}
			var mixage:SoundTransform=pisteHeros0.soundTransform;
			mixage.volume=(volumePas/100);
			switch(n){
				case 0: pisteHeros0.soundTransform=mixage;break;
				case 1: pisteHeros1.soundTransform=mixage;break;
			}
		}
	//VOLUME ARME================================================================
		private function modulerVolumeArme(volP:int,controlV=false){
			var mixage:SoundTransform=pisteArme3.soundTransform;
			if(controlV==true){mixage.volume=(volP/100);}
			if(controlV==false&&mixage.volume<1){mixage.volume+=((volP+mixage.volume*35)/100);}
			pisteArme3.soundTransform=mixage;
		}
//FONCTION FIN SON=====================================================================================================================
		private function finSonpisteHeros0(e:Event){
			tableauFinSon[0]=true;
			pisteHeros0.removeEventListener(Event.SOUND_COMPLETE,finSonpisteHeros0);
		}
		private function finSonpisteHeros1(e:Event){
			tableauFinSon[1]=true;
			pisteHeros1.removeEventListener(Event.SOUND_COMPLETE,finSonpisteHeros1);
		}
		private function finSonpisteHeros2(e:Event){
			tableauFinSon[2]=true;
			pisteHeros2.removeEventListener(Event.SOUND_COMPLETE,finSonpisteHeros2);
		}
		private function finSonpisteArme3(e:Event){
			tableauFinSon[3]=true;
			pisteArme3.removeEventListener(Event.SOUND_COMPLETE,finSonpisteArme3);
		}
		private function finSonpisteArme4(e:Event){
			tableauFinSon[4]=true;
			pisteArme4.removeEventListener(Event.SOUND_COMPLETE,finSonpisteArme4);
		}
		private function finSonpisteInvt10(e:Event){
			tableauFinSon[10]=true;
			pisteInvt10.removeEventListener(Event.SOUND_COMPLETE,finSonpisteInvt10);
		}
		private function finSonpisteInvt11(e:Event){
			tableauFinSon[11]=true;
			pisteInvt11.removeEventListener(Event.SOUND_COMPLETE,finSonpisteInvt11);
		}
		private function finSonpistePS12(e:Event){
			tableauFinSon[12]=true;
			pistePS12.removeEventListener(Event.SOUND_COMPLETE,finSonpistePS12);
		}
//FUNCTION TIMER=======================================================================================================================
		private function horloge(temps:int,nb:int,son:String){
			var minuteur:Timer=new Timer(temps,nb);
			minuteur.addEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
			minuteur.addEventListener(TimerEvent.TIMER,minuteurTic);
			minuteur.start();
			function minuteurStop(e:Event){
				minuteur.removeEventListener(TimerEvent.TIMER_COMPLETE,minuteurStop);
				minuteur.removeEventListener(TimerEvent.TIMER_COMPLETE,minuteurTic);
			}
			function minuteurTic(e:Event){
				switch(son){
					case "piece": pisteItem7=sonPieces.play(50);
					case "pieceCoffre": pisteInvt10=sonPieces.play(50);
				}
			}
		}
//FUNCTION AFFINAGE====================================================================================================================
		private function armeAction(appuieTouche:int):int{
			var control:int=0;
			if(appuieTouche==1&&appuieTape==false){control=1;appuieTape=true;}
			if(appuieTouche==0&&appuieTape==true){control=2;appuieTape=false;}
			return (control);
		}
		public function block(){blocker=true;}
		public function deblock(){blocker=false;}
	}
}
		