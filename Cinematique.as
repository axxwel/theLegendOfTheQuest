package{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	
	public class Cinematique extends MovieClip{
		
		public var donnee_cineXML:XML;
		public var idCine:int;
		public var conteneurVideo:Sprite=new Sprite();
		
		public var nom:String;
		public var nom_fond:String;
		public var numeroHorizon:int;
		
		public var colonne:int;
		public var ligne:int;
		public var zoom:int;
		public var cam:int;
		public var vitesseDG:int;
		public var vitesseHB:int;
		public var tempo:int=0;
		public var postureHeros:String;
		public var video:String;
		
		public var niveauArrive:String="";
		public var porteArrive:int=0;
		
		public var niveau:Array=new Array();
		public var donnee_niveau:Array=new Array();
		public var donnee_cine:Array=new Array();
		
		public var secance:int=-1;
		public var nombreSecance:int=0;
		public var donneeDepart:Array=new Array();
		public var donneeArrive:Array=new Array();
		public var deplacementFini=true;
		
		public var colonneEnCours:Number=0;
		public var ligneEnCours:Number=0;
		public var timeEnCours:Number=0;
		public var changementDecorEffectue:Boolean=false;
		public var videoInit:Boolean=false;
		public var videoFin:Boolean=false;
		
		public var nomNiveauArrive:String="";
		public var numeroPorteArrive:int=0;
		
		public var nomNiveau:String;
		
		public var deplacer:Array=new Array;
		public var afficher:Array=new Array;
		
		public var cineInitialized:Boolean=false;
		public var voileOuvert:Boolean=false;

		public function Cinematique(pdonnee_cineXML:XML,pidCine:int,pniveau:Array){
			donnee_niveau=classerDonneeNiveau(pniveau);
			donnee_cineXML=pdonnee_cineXML;
			idCine=pidCine;
			addChild(conteneurVideo);
		}
//RUN============================================================================================================
		public function run(){
			if(secance==-1){
				cineInitialized=false;
				donneeDepart=chargerDonnee(donnee_niveau);
				chargerDepartCine(idCine);
				donneeArrive=chargerDonnee(donnee_cine);
				
				ligneEnCours=donneeDepart[3];
				colonneEnCours=donneeDepart[4];
				donneeArrive[7]=64;
				donneeArrive[8]=64;
				
				deplacementFini=false;
				secance+=1;
			}
			if(secance>=0&&deplacementFini==true){cineInitialized=true;}
			if(secance>=0&&deplacementFini==true&&voileOuvert==true){
				if(secance<nombreSecance){
					donneeDepart=chargerDonnee(donneeArrive);
					chargerCine(idCine,secance);
					donneeArrive=chargerDonnee(donnee_cine);
					timeEnCours=donneeArrive[9];
					deplacementFini=false;
				}
				if(secance==nombreSecance){
					donneeDepart=chargerDonnee(donneeArrive);
					donneeArrive=chargerDonnee(donnee_niveau);
					donneeArrive[7]=16;
					donneeArrive[8]=16;
					deplacementFini=false;
				}
				if(secance>nombreSecance&&deplacementFini==true){
					deplacer[2]=4;//reinit vitesse DG
					deplacer[3]=4;//reinit vitesse HB
					stage.dispatchEvent(new Event("cinematique_termine"));
				}
				secance+=1;
			}
			runSecance();
		}
		public function runSecance(){
	//AFFICHE HEROS----------------------------------------------------------------------------------
			/*pied,arme,visage,oeil,casque,habit,bras,sac,effets,INVISIBLE*/
			if(donneeArrive[10]!=""){fAfficher(donneeArrive[10]);}else{afficher=[1,1,13,2,1,1,1,false];}
	//CHANGE DECOR----------------------------------------------------------------------------------
			var niveauArriveTemp:String=donneeArrive[11];
			if(niveauArriveTemp!=""&&niveauArriveTemp!=null&&deplacementFini==false&&changementDecorEffectue==false){
				changementDecor();
			}
	//DEPLACEMENT-----------------------------------------------------------------------------------
			if(deplacementFini==false&&temporisation()==false){
				runDeplacement(donneeArrive[3],donneeArrive[4],donneeArrive[7],donneeArrive[8]);
			}
	//VIDEO-----------------------------------------------------------------------------------------
			var videoTemp:String=donneeArrive[13];
			if(videoTemp!=""&&videoTemp!=null&&deplacementFini==false){
				if(videoInit==false){initializeVideo();}
				if(videoInit==true&&videoFin==false){runVideo();}
				if(videoFin==true){suprimVideo();}
			}
		}
//CHARGEMENT DONNEE=================================================================================================================
	//DONNEE DEPART ARRIVE------------------------------------------------------
		public function chargerDonnee(donnee:Array){
			var control:Array=new Array();
			for(var n:int=0;n<14;n++){
				control[n]=donnee[n];
			}
			return(control);
		}
	//DONNEE DEPART-------------------------------------------------------------
		public function chargerDepartCine(pnumeroCine:int){
			
			nom=donnee_cineXML.cinematique.(@id==pnumeroCine).@nom;
			nom_fond=donnee_cineXML.cinematique.(@id==pnumeroCine).@nom_fond;
			numeroHorizon=donnee_cineXML.cinematique.(@id==pnumeroCine).@numeroHorizon;
			
			colonne=donnee_cineXML.cinematique.(@id==pnumeroCine).@colonne;
			ligne=donnee_cineXML.cinematique.(@id==pnumeroCine).@ligne;
			zoom=donnee_cineXML.cinematique.(@id==pnumeroCine).@zoom;
			cam=donnee_cineXML.cinematique.(@id==pnumeroCine).@cam;
			
			postureHeros=donnee_cineXML.cinematique.(@id==pnumeroCine).@posture_heros;
			
			nombreSecance=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.length();
			retour();
		}
	//DONNEE SECANCE--------------------------------------------------------------
		public function chargerCine(pnumeroCine:int,pnumeroSecance:int):void{
			
			colonne=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@colonne;
			ligne=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@ligne;
			zoom=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@zoom;
			cam=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@cam;
			
			vitesseDG=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@vitesseDG;
			vitesseHB=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@vitesseHB;
			tempo=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@tempo;
			postureHeros=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@posture_heros;
			
			niveauArrive=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@nom_niveau;
			porteArrive=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@porte_arrive;
			
			video=donnee_cineXML.cinematique.(@id==pnumeroCine).secance.(@numero==pnumeroSecance).@video;

			retour();
		}
	//RETOUR DONNEE-----------------------------------------------------------------
		public function retour(){
			donnee_cine[0]=nom;
			donnee_cine[1]=nom_fond;
			donnee_cine[2]=numeroHorizon;
				
			donnee_cine[3]=ligne;
			donnee_cine[4]=colonne;
			donnee_cine[5]=zoom;
			donnee_cine[6]=cam;
				
			donnee_cine[7]=vitesseDG;
			donnee_cine[8]=vitesseHB;
			
			donnee_cine[9]=tempo;
			donnee_cine[10]=postureHeros;
				
			donnee_cine[11]=niveauArrive;
			donnee_cine[12]=porteArrive;
			
			donnee_cine[13]=video;
		}
	//CLASSEMENT DONNEE---------------------------------------------------------------
		public function classerDonneeNiveau(donnee:Array){
			var control:Array=new Array();
			control[0]=donnee[0];
			control[1]=donnee[1];
			control[2]=donnee[2];
				
			control[3]=donnee[3];
			control[4]=donnee[4];
			control[5]=donnee[5];
			control[6]=donnee[6];
			
			return(control);
		}
//TEMPORISATION=======================================================================================================================
		public function temporisation():Boolean{
			var control:Boolean=true;
			if(timeEnCours>0){timeEnCours-=1;}else{control=false;}
			return(control);
		}
//DEPLACEMENT CINE=====================================================================================================================
		public function runDeplacement(arriveL:int,arriveC:int,vDG:int,vHB:int){
			var ligneArrive:Boolean=false;
			var colloneArrive:Boolean=false;
			
			if(colonneEnCours>arriveC){
				deplacer[0]=-1;
				deplacer[2]=vDG;
				colonneEnCours-=vDG/64;
			}
			else if(colonneEnCours<arriveC){
				deplacer[0]=+1;
				deplacer[2]=vDG;
				colonneEnCours+=vDG/64;
			}else{deplacer[0]=0;deplacer[2]=0;colloneArrive=true;}
			
			if(ligneEnCours>arriveL){
				deplacer[1]=-1;
				deplacer[3]=vHB;
				ligneEnCours-=vHB/64;
			}
			else if(ligneEnCours<arriveL){
				deplacer[1]=+1;
				deplacer[3]=vHB;
				ligneEnCours+=vHB/64;
			}else{deplacer[1]=0;deplacer[3]=0;ligneArrive=true;}
			if(colloneArrive==true&&ligneArrive==true){deplacementFini=true;}
		}
//CHANGEMENT DECOR===========================================================================================================
		public function changementDecor(){
			nomNiveauArrive=donnee_cine[11];
			numeroPorteArrive=donnee_cine[12];
			stage.dispatchEvent(new Event("changement_decor"));
			changementDecorEffectue=true;
		}
//VIDEO====================================================================================================================
	//INIT VIDEO------------------------------------------------------------------
		public function initializeVideo(){
			var videoName:String=donnee_cine[13];
			var videoClass:Class=getDefinitionByName(videoName)as Class;
			var videoTemp:MovieClip=new videoClass();
			videoTemp.name="video";
			videoTemp.x=0;
			videoTemp.y=0;
			conteneurVideo.addChild(videoTemp);
			videoTemp.gotoAndStop(0);
			videoInit=true;
			videoFin=false;
		}
	//RUN VIDEO--------------------------------------------------------------------
		public function runVideo(){
			if(MovieClip(conteneurVideo.getChildByName("video")).currentFrame>=(MovieClip(conteneurVideo.getChildByName("video")).totalFrames-35)){
				
			}
			if(MovieClip(conteneurVideo.getChildByName("video")).currentFrame>=MovieClip(conteneurVideo.getChildByName("video")).totalFrames){
				MovieClip(conteneurVideo.getChildByName("video")).stop();
				videoFin=true;
			}else{
				MovieClip(conteneurVideo.getChildByName("video")).play();
			}
		}
	//SUPRIM VIDEO-----------------------------------------------------------------
		public function suprimVideo(){
			if(conteneurVideo.numChildren>0){
				conteneurVideo.removeChildAt(0);
			}else{
				deplacementFini=true;
			}
		}
//AFFICHAGE HEROS===========================================================================================================
		public function fAfficher(postureHeros:String){
			/*pied,arme,visage,oeil,casque,habit,bras,sac,effets,INVISIBLE*/
			if(postureHeros=="invisible")	{afficher=[1,2,1,10,1,1,1,1,true]}
			if(postureHeros=="peur")		{afficher=[1,2,2,10,1,1,1,1]}
			if(postureHeros=="content")	{afficher=[1,2,2,13,1,1,1,1]}
		}
	}
}