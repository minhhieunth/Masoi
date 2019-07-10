TESTBR     ACCEPT W-TEMPS FROM TIME                                     
           INITIALIZE VARIABLES                                         
           SET PAS-ERREUR      TO TRUE                                  
F611TM* Si Code Origine = 3 (Axa) , pas de Opérations Commerciales(OC)  
F611TM     IF RPE560FS-ORG-AXA                                          
F611TM        PERFORM FINIR                                             
F611TM     END-IF                                                       
           PERFORM S000-INITIALISATION                                  
      *                                                                 
      *-----------------------TRAITEMENT DES OPERATIONS DEJA EXISTANTES 
      *                                                                 
           PERFORM S050-TRAITER-ANC-OPERATIONS                          
                                                                        
      *                                                                 
      *-----------------------------TRAITEMENT FENETRE DE SOUSCRIPTION. 
      *                                                                 
           IF PAS-ERREUR                                                
              IF EVENEMENT-DANS-LA-CIBLE                                
                 SET OPERATION-RFS       TO TRUE                        
                 PERFORM S100-TRAITEMENT-RFS                            
      *                                                                 
      *--------------------------------TRAITEMENT TROIS MOIS GRATUITS.  
      *                                                                 
                 IF PAS-ERREUR                                          
                    IF CONTRAT-HORS-CIBLE                               
                       SET OPERATION-TMG       TO TRUE                  
                       PERFORM S200-TRAITEMENT-TMG                      
                    END-IF                                              
                 END-IF                                                 
              END-IF                                                    
           END-IF                                                       
           PERFORM S900-SORTIE                                          
F611TM     PERFORM FINIR                                                
F611TM     .                                                            
F611TM*------*                                                          
F611TM FINIR.                                                           
F611TM*------*                                                          
           GOBACK.                                                      
                                                                        
      *----------------------------------------------------------       
       FIN-PROGRAMME-RPE560FS.                                          
      *----------------------------------------------------------       
           EXIT.                                                        
                                                                        
      *----------------------------------------------------------       
       S000-INITIALISATION                  SECTION.                    
      *----------------------------------------------------------       
                                                                        
      *    RECHERCHE DATE DU JOUR                                       
                                                                        
                                                                        
                                                                        
                                                                        
           CALL 'RGNSYDTE' USING LGNSYDTE                               
      *    INITIALISATION WORKING                                       
                                                                        
           MOVE ZEROES       TO J                                       
           MOVE ZEROES       TO Y                                       
           MOVE ZEROES       TO Z                                       
           MOVE SPACES       TO  RPE560FS-CODRET                        
           MOVE SPACES       TO  RPE560FS-CRSERV.                       
                                                                        
      *----------------------------------------------------------       
       FIN-S000.                                                        
      *----------------------------------------------------------       
           EXIT.                                                        
                                                                        
      *----------------------------------------------------------       
       S050-TRAITER-ANC-OPERATIONS    SECTION.                          
      *----------------------------------------------------------       
           PERFORM S055-INIT-TABLE-PROMO                                
A                                                                
      *                                                          
      *  EN AFFAIRE NOUVELLE ON RECHERCHE SI ON EST DANS LA CIBLE
      *  D UNE OPERATION COMMERCIALE STANDARD                    
      *                                                          
                                                                 
           IF EVT-AN                                             
              SET EVENEMENT-DANS-LA-CIBLE     TO TRUE            
              GO TO FIN-S050                                     
           END-IF                                                
                                                                 
      * ACTION FORCEE SER ON RECONDUIT SI POSSIBLE               
                                                                 
           MOVE RPE560FS-ACTCOM-PREC      TO ACTCOM-1-8          
           IF ACTCOM-3 = 'C'                                     
           IF (RPE560FS-TYPAFF = 'SR AN' ) OR                    
              (RPE560FS-TYPAFF = 'SR RP' )                       
              IF RPE560FS-ACTCOM-ENCOURS NOT = SPACES            
                 PERFORM S060-RECONDUCTION-PROMO                 
                 GO TO FIN-S050                                 
              ELSE                                              
                 SET EVENEMENT-DANS-LA-CIBLE       TO TRUE      
                 GO TO FIN-S050                                 
              END-IF                                            
           END-IF                                               
           END-IF                                               
                                                                
      * ACTION FORCEE REPRISE INSTANCE                          
           MOVE RPE560FS-ACTCOM-RI        TO ACTCOM-1-8         
           IF ACTCOM-3 = 'C'                                    
           IF RPE560FS-TYPAFF = 'DV RP' OR 'IN RP' OR 'DV AN' OR
                                'IN AN'                         
              IF RPE560FS-ACTCOM-ENCOURS NOT = SPACES           
                 MOVE RPE560FS-ACTCOM-ENCOURS TO ACTCOM-1-8     
                 IF ACTCOM-3 = 'C'                              
                    SET EVENEMENT-HORS-CIBLE      TO TRUE       
                    GO TO FIN-S050                              
                 ELSE                                           
				
                    SET EVENEMENT-DANS-LA-CIBLE   TO TRUE
                    GO TO FIN-S050                       
                 END-IF                                  
              ELSE                                       
                 SET EVENEMENT-DANS-LA-CIBLE   TO TRUE   
                 GO TO FIN-S050                          
              END-IF                                     
           END-IF                                        
           END-IF                                        
                                                         
           IF RPE560FS-TYPAFF = 'IN AN' OR 'DV AN' OR    
                                'SR AN'                  
              SET EVENEMENT-DANS-LA-CIBLE     TO TRUE    
              GO TO FIN-S050                             
           END-IF                                        
                                                         
           IF RPE560FS-TYPAFF = 'IN RP' OR 'DV RP'       
              PERFORM S060-RECONDUCTION-PROMO            
              GO TO FIN-S050                             
           END-IF                                                
                                                                 
           IF EVT-RP OR RPE560FS-TYPAFF = 'SR RP'                
              PERFORM S060-RECONDUCTION-PROMO                    
           END-IF                                                
           .                                                     
                                                                 
      *----------------------------------------------------------
       FIN-S050.                                                 
      *----------------------------------------------------------
           EXIT.                                                 
                                                                 
      *----------------------------------------------------------
       S055-INIT-TABLE-PROMO                SECTION.             
      *----------------------------------------------------------
      *                                                          
           MOVE RPE560FS-ACTCOM-PREC      TO W-ACTCOM            
                                                                 
           PERFORM VARYING A FROM 1 BY 1 UNTIL A > 6             
              IF RPE560FS-SEXE(A) NOT = LOW-VALUE AND SPACES  
                 MOVE RPE560FS-ETAT-PERS(A)  TO W-ETAT(A)     
                 MOVE RPE560FS-NO-PERS(A)    TO W-NO-BENEF(A) 
                 MOVE RPE560FS-BENEF-RABI(A) TO W-BENEF-RAB(A)
                 MOVE RPE560FS-MT-RABI(A)    TO W-MT-RAB(A)   
              ELSE                                            
                 MOVE SPACES                 TO W-ETAT(A)     
                 MOVE ZEROES                 TO W-NO-BENEF(A) 
                 MOVE SPACES                 TO W-BENEF-RAB(A)
                 MOVE ZEROES                 TO W-MT-RAB(A)   
              END-IF                                          
           END-PERFORM.                                       
      *----------------------------------------------------------
       FIN-S055.                                                 
      *----------------------------------------------------------
           EXIT.                                                 
                                                                 
      *----------------------------------------------------------
       S060-RECONDUCTION-PROMO              SECTION.             
	   *----------------------------------------------------------
           IF RPE560FS-ACTCOM-PREC NOT = LOW-VALUE AND SPACES    
              MOVE RPE560FS-ACTCOM-PREC    TO ACTCOM-1-8         
MGS0LH* -- AJOUTER TYPE OFFER K                                  
MGS0LH        IF ACTCOM-6          = 'I' OR 'J' OR 'K'           
F004TM        AND ACTCOM-3 NOT = 'C'                             
F701FO           SET OPERATION-RFS           TO TRUE             
F701FO           MOVE 1                      TO I                
F701FO           MOVE RPE560FS-ACTCOM-PREC   TO TRI1-NO-ACTCOM(1)
F701FO           PERFORM S530-CONTROLE-FORMULE                   
F701FO           IF CONTRAT-HORS-CIBLE                           
F701FO              SET CONTRAT-DANS-LA-CIBLE   TO TRUE          
F701FO              SET EVENEMENT-DANS-LA-CIBLE TO TRUE          
F701FO              PERFORM S620-RAZ-PROMOTION-CONTRAT           
F701FO              GO TO FIN-S060                               
F701FO           END-IF                                          
F701FO        END-IF                                             
                                                                 
MGS0LH* -- AJOUTER TYPE OFFER 4                                  
MGS0LH        IF ACTCOM-6          = '1' OR '2' OR '3' OR '4'    
                 SET EVENEMENT-DANS-LA-CIBLE TO TRUE             
                 GO TO FIN-S060                                       
              ELSE                                                    
      *---------------------------------SI OPERATION PRECEDENTE = RFS 
                                                                      
                 SET EVENEMENT-HORS-CIBLE    TO TRUE                  
                                                                      
      *----------------------CHANGEMENT DE CLAUSE PROFESSION MEDICALES
                                                                      
                 PERFORM VARYING A FROM 1 BY 1 UNTIL A > 4            
                    IF RPE560FS-CLAMED-PREC(A) NOT =                  
                       RPE560FS-CLAMED(A)                             
                       PERFORM S620-RAZ-PROMOTION-CONTRAT             
                       SET EVENEMENT-DANS-LA-CIBLE    TO TRUE         
                       GO TO FIN-S060                                 
                    END-IF                                            
                 END-PERFORM                                          
      *----------------------------------------CHANGEMENT DE GARANTIES
                                                                      
MGS0LH* -- AJOUTER TYPE OFFER K                                       
F701FO           IF  ACTCOM-6 NOT = 'I'                               
F701FO           AND ACTCOM-6 NOT = 'J'                               
MGS0LH           AND ACTCOM-6 NOT = 'K'                               
                    IF RPE560FS-GARFS-PREC NOT = RPE560FS-GARFS       
                       PERFORM S620-RAZ-PROMOTION-CONTRAT             
                       SET EVENEMENT-DANS-LA-CIBLE    TO TRUE         
                       GO TO FIN-S060                                 
                    END-IF                                            
F701FO           END-IF                                               
                                                                      
      *----------------------------------------AJOUT D UNE PERSONNE   
                                                                      
MGS0LH           IF ACTCOM-6 = 'J' OR 'I' OR 'K'                      
F701FO              PERFORM VARYING A FROM 1 BY 1 UNTIL A > 6         
F701FO                 IF RPE560FS-ETAT-PERS(A) = 'C'                 
F701FO                    MOVE 'O'           TO W-BENEF-RAB(A)        
F701FO                    MOVE ZEROES        TO W-MT-RAB(A)           
F701FO                 END-IF                                 
F701FO              END-PERFORM                               
F701FO           ELSE                                         
                    IF RPE560FS-TYPAFF NOT = 'SR AN'          
                    PERFORM VARYING A FROM 1 BY 1 UNTIL A > 6 
                       IF RPE560FS-ETAT-PERS(A) = 'C'         
                          MOVE 'N'           TO W-BENEF-RAB(A)
                          MOVE ZEROES        TO W-MT-RAB(A)   
                       END-IF                                 
                    END-PERFORM                               
                    END-IF                                    
                                                              
                    IF RPE560FS-TYPAFF  = 'SR AN'             
                    PERFORM VARYING A FROM 1 BY 1 UNTIL A > 6 
                       IF RPE560FS-ETAT-PERS(A) = 'C' AND     
                          RPE560FS-REGIME-PREC (A) = SPACES   
                          MOVE 'N'           TO W-BENEF-RAB(A)
                          MOVE ZEROES        TO W-MT-RAB(A)   
                       END-IF                                 
V                   END-PERFORM                                     
                    END-IF                                          
F701FO           END-IF                                             
      *-----------------------------CHANGEMENT DE REGIME D UNE PERSO
F102TM* NE PAS INITIALISER L'OC EN REMPLACEMENT                     
                 PERFORM VARYING A FROM 1 BY 1 UNTIL A > 6          
F102TM                                               OR EVT-RP      
                    IF (RPE560FS-REGIME-PREC(A) = '01' OR '02') AND 
                       (RPE560FS-REGIME(A) NOT = '01' AND '02')     
                        MOVE 'N'       TO W-BENEF-RAB(A)            
                        MOVE ZEROES        TO W-MT-RAB(A)           
                    END-IF                                          
                    IF (RPE560FS-REGIME-PREC(A) = '03' OR '04') AND 
                       (RPE560FS-REGIME(A) NOT = '03' AND '04')     
                        MOVE 'N'       TO W-BENEF-RAB(A)            
                        MOVE ZEROES        TO W-MT-RAB(A)           
                    END-IF                                          
                    IF (RPE560FS-REGIME-PREC(A) = '05' OR '06') AND 
                       (RPE560FS-REGIME(A) NOT = '05' AND '06')     
                        MOVE 'N'       TO W-BENEF-RAB(A)               
                        MOVE ZEROES        TO W-MT-RAB(A)              
                    END-IF                                             
                 END-PERFORM                                           
                                                                       
      *------------------------AUCUN ASSURE NE BENEFIE PLUS DE LA PROMO
                                                                       
                 MOVE SPACES              TO TOP-AU-MOINS-1            
                                                                       
                 PERFORM VARYING A FROM 1 BY 1 UNTIL A > 6             
                    IF W-NO-BENEF(A) NOT = ZEROES                      
                       IF W-BENEF-RAB(A) = 'O' OR                      
                          W-MT-RAB(A) NOT = ZEROES                     
                          MOVE 'OUI'      TO TOP-AU-MOINS-1            
                       END-IF                                          
                    END-IF                                             
                 END-PERFORM                                           
                 IF TOP-AU-MOINS-1 = SPACES                            
                    PERFORM S620-RAZ-PROMOTION-CONTRAT                 
	                    SET EVENEMENT-DANS-LA-CIBLE    TO TRUE       
                 END-IF                                          
              END-IF                                             
           ELSE                                                  
              SET EVENEMENT-DANS-LA-CIBLE    TO TRUE             
           END-IF.                                               
                                                                 
      *----------------------------------------------------------
       FIN-S060.                                                 
      *----------------------------------------------------------
           EXIT.                                                 