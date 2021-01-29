package{
	import flash.display.*
	import flash.events.Event;
	
	public class CameraGestion extends Sprite{
		
		public var decalageCamX:Number=0;
		public var decalageCamY:Number=0;
		public var zoomCam:Number=1;
		
		private const zoomCamCoef:Number=0.03125;
		public var zoomCamPas:int=0;
		public var zoomIn:Boolean=false;
		
		public var herosDG:int=0;
		public var sensDG:int=-1;
		public var herosHB:int=0;
		public var vitesseDG:int=0;
		public var vitesseHB:int=0;
		public var saut:Boolean=true;
		
		public var carte:Array=new Array;
		public var mesCases:Cases=new Cases;
		
		public var carte_ligne:int=0;
		public var carte_colonne:int=0;
		public var carte_ligne_depart:int=0;
		public var carte_colonne_depart:int=0;
		
		public var porte:Boolean=false;
		public var numeroPorte:int=0;
		
		public var decalage_Fond_x:int=0;
		public var decalageX:int=0;
		public var decalageX_colonne:int=0;
		
		public var decalage_Fond_y:Number=0;
		public var decalageY:int=0;
		public var decalageY_abs:int=0;
		
		public var decalageZoom:Number=0;
		
		public var bordCarteHB:Boolean=false;
		public var bordCarteHB_decor:Boolean=false;
		public var monterCam:Boolean=false;
		public var descendreCam:Boolean=false;
		public var touche_sol:Boolean=false;
		
		public var arretDG:Boolean=true;
		public var arretHB:Boolean=true;
		
		public var blockDG:Boolean=false;
		
		public var blocker:Boolean=false;
		
		public function CameraGestion(){
			
		}
//RUN====================================================================================
		public function run(){
			
			decalageCamX=decalageX+decalageZoom;
			decalageCamY=decalageY+(decalageZoom*1.2);
			if(tester_cases_HB()==-1&&touche_sol==true){descendreCam=true;}else{descendreCam=false;}
			if(tester_cases_HB()==1&&touche_sol==true&&saut==false){monterCam=true;}else{monterCam=false;}
			if(tester_cases_zoom()==-10){zoomIn=true;}
			if(tester_cases_zoom()==10){zoomIn=false;}
			gestionZoom();
			
			if(monterCam==true){funcMonterCam();}
			if(descendreCam==true){funcDescendreCam();}
		}
//gestion X=================================================================================
		public function gestionCameraX(pherosDG:int,pvitesseDG:int){
			herosDG=pherosDG;
			vitesseDG=pvitesseDG;
			if(testBordCarteDG()[0]==false){
				if(herosDG==-1){
				   if(decalageX>-127){decalageX-=vitesseDG;}
				   if(decalageX<-127){decalageX+=vitesseDG;}
				}
				if(herosDG==1){
					if(decalageX<127){decalageX+=vitesseDG;}
					if(decalageX>127){decalageX-=vitesseDG;}
				}
			}
			if(testBordCarteDG()[0]==true){
				if(testBordCarteDG()[1]==true){decalageX-=vitesseDG*herosDG;}
				else{
					if(herosDG==-1){
						if(decalageX<127){decalageX+=vitesseDG;}
					}
					if(herosDG==1){
						if(decalageX>-127){decalageX-=vitesseDG;}
					}
				}
			}
		}
//gestion Y=================================================================================
		public function gestionCameraY(pherosHB:int,pvitesseHB:int){
			herosHB=pherosHB;
			vitesseHB=pvitesseHB;
			if(herosHB==-1){
				if(decalageY>-127){decalageY-=vitesseHB;}
			}
			if(herosHB==1){
				if(decalageY<0){decalageY+=vitesseHB;}
			}			
		}
		public function funcMonterCam(){
			if(decalageY<0){
				decalageY+=8;
			}else{
				decalageY=0;
			}
		}
		public function funcDescendreCam(){
			if(decalageY>-127){
				
				decalageY-=8;
			}else{
				decalageY=-128;
			}
		}
//ZOOM============================================================================
		public function gestionZoom(){
			if(zoomCamPas>=0&&zoomCamPas<=15&&zoomIn==true){zoomCamPas+=1;}
			if(zoomCamPas>=1&&zoomCamPas<=16&&zoomIn==false){zoomCamPas-=1;}
			
			zoomCam=1+zoomCamCoef*zoomCamPas;
			decalageZoom=-zoomCamPas*12.5;
		}
//BORD CARTE============================================================================
		public function testBordCarteDG():Array{
			var retourArray:Array=new Array;
			var bordCarte_control:Boolean=false;
			var porte_control:Boolean=false;
			var porteN:int=0;
			
			for(var c:int=3;c<=13;c++){
				if(tester_cases_DG(c)==true){
					if(herosDG==-1&&c>=9){bordCarte_control=true;}
					if(herosDG==1&&c<=6){bordCarte_control=true;}
				}
				if(tester_cases_DG_porte(c)==true){
					if(herosDG==-1&&c>=9){bordCarte_control=true;}
					if(herosDG==1&&c<=6){bordCarte_control=true;}
					if((tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)-11)>=0){porte_control=true;}
					numeroPorte=porteN=(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+c+carte_colonne_depart)-11);
				}
				
			}
			retourArray[0]=bordCarte_control;
			retourArray[1]=porte_control;
			retourArray[2]=porteN;
			return(retourArray)
		}
//TEST CASE========================================================================================================================
		public function tester_cases_DG(casesDG:int):Boolean{
			if (tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)==31){return true;}
			if ((decalage_Fond_y>0)&&tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)==31){return true;}
			if ((decalage_Fond_y<0)&&tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)==31){return true;}
			else{return false;}
		}
		public function tester_cases_DG_porte(casesDG:int):Boolean{
			if (tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)>=11&&
				tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)<=30){return true;}
			if ((decalage_Fond_y>0)&&tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)>=11&&
				tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)<=30){return true;}
			if ((decalage_Fond_y<0)&&tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)>=11&&
				tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+casesDG+carte_colonne_depart)<=30){return true;}
			else{return false;}
		}
		public function tester_cases_HB():int{
			var control:int;
			if ((decalage_Fond_y<1)&&tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==34){control=1;}
			else if((decalage_Fond_y<1)&&(decalage_Fond_x>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==34){control=1;}
			else if((decalage_Fond_y<1)&&(decalage_Fond_x<0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==34){control=1;}
			else if((decalage_Fond_y<1)&&tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8+carte_colonne_depart)==35){control=-1;}
			else if((decalage_Fond_y<1)&&(decalage_Fond_x>0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+9+carte_colonne_depart))==35){control=-1;}
			else if((decalage_Fond_y<1)&&(decalage_Fond_x<0)&&(tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+7+carte_colonne_depart))==35){control=-1;}
			else{control=0;}
			return(control);
		}
		public function tester_cases_zoom():int{
			var control:int;
			if (tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)==32){control=10;}
			else if(decalage_Fond_y>0&&tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)==32){control=10;}
			else if(decalage_Fond_y<0&&tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)==32){control=10;}
			else if(tester_case(carte_ligne+8+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)==33){control=-10;}
			else if(decalage_Fond_y>0&&tester_case(carte_ligne+9+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)==33){control=-10;}
			else if(decalage_Fond_y<0&&tester_case(carte_ligne+7+carte_ligne_depart,carte_colonne+8-herosDG+carte_colonne_depart)==33){control=-10;}
			else{control=0;}
			return(control);
		}
		public function tester_case(ligne:int,colonne:int):int{
			var pligne:int=ligne;
			var pcolonne:int=colonne;
			var control:int;
			var decorControl:int=mesCases.tester_case(pligne,pcolonne,carte);
			if(decorControl==0||decorControl>200){control=0;}else{control=decorControl;}
			return(control);
		}
	}
}