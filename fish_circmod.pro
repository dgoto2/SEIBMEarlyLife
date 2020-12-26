function fish_circmod, year_data, scenario

;pro fish_circmod, year_data; FOR TESTING ONLY

circdata= year_data; 35802000L
;Particle id, simulation day, x-location, y-location, latitude, longitude, bathymetric depth, depth below surface, temperature

;ActPart = WHERE(circdata[8, *] GE 0., ActPartcount)
ActPart = WHERE(circdata[6, *] LT 0., ActPartcount, complement = Inactpart, ncomplement=Inactpartcount)
IF ActPartcount GT 0. THEN circdata[6, ActPart] = circdata[6, ActPart] *(-1.) else circdata[6, Inactpart] = 0.
ActPart2 = WHERE(circdata[7, *] LT 0., ActPart2count, complement = Inactpart2, ncomplement=Inactpart2count)
IF ActPart2count GT 0. THEN circdata[7, ActPart2] = circdata[7, ActPart2] *(-1.) else circdata[7, Inactpart2] = 0.
ActPart3 = WHERE(circdata[8, *] GT 0., ActPart3count, complement = Inactpart3, ncomplement=Inactpart3count)
;IF ActPart3count GT 0. THEN circdata[8, ActPart3] = circdata[8, ActPart3] else circdata[8, Inactpart3] = 0.
IF Inactpart3count GT 0. THEN circdata[8, Inactpart3] = 0.

; cutoff fish length for transport susceptibility
IF Scenario EQ 'Baseline20mm_Depth_pval' THEN cut = 20.
IF Scenario EQ 'Baseline10mm_Depth_pval' THEN cut = 10.   
IF Scenario EQ 'Baseline30mm_Depth_pval' THEN cut = 30.

IF Scenario EQ 'Baseline20mm_NoDepth' THEN cut = 20.
IF Scenario EQ 'Baseline10mm_NoDepth' THEN cut = 10.
IF Scenario EQ 'Baseline30mm_NoDepth' THEN cut = 30.

; For the following scenarios, the cutoff size is 20mm
IF Scenario EQ 'Pval_base' THEN cut = 20.
IF Scenario EQ 'Pval_HighDec' THEN cut = 20.
IF Scenario EQ 'Pval_LowDec' THEN cut = 20.
IF Scenario EQ 'Pval_HighInc' THEN cut = 20.
IF Scenario EQ 'Pval_LowInc' THEN cut = 20.
IF Scenario EQ 'Pred_base' THEN cut = 20.
IF Scenario EQ 'Pred_HighDec' THEN cut = 20.
IF Scenario EQ 'Pred_LowDec' THEN cut = 20.
IF Scenario EQ 'Pred_HighInc' THEN cut = 20.
IF Scenario EQ 'Pred_LowInc' THEN cut = 20.
IF Scenario EQ 'Pval_HighDec+Pred_HighInc' THEN cut = 20.
IF Scenario EQ  'Pval_HighInc+Pred_HighInc' THEN cut = 20.
IF Scenario EQ 'Pval_HighDec+Pred_HighDec' THEN cut = 20.
IF Scenario EQ 'Pval_HighInc+Pred_HighDec' THEN cut = 20.
print, 'larva size threshold', cut

preyed=2150.0
;st=3315
nParticle=99450L
;lengths=fltarr(st)+4
;weights=fltarr(st)+0.0002
lengths=fltarr(nParticle)+4
weights=fltarr(nParticle)+0.0002
struc=(1-0.0253*(lengths^0.6547))*weights
store=0.0253*(lengths^0.6547)*weights

;no_fish=fltarr(st)+1000000
no_fish=fltarr(nParticle)+1000000
  
;inds=fltarr(14,3315)
inds=fltarr(34, nParticle)
actinds=fltarr(nParticle)

;settle=fltarr(st)
settle=fltarr(nParticle) 

temps2=fltarr(nParticle)
depths2=fltarr(nParticle)
bath2=fltarr(nParticle)

temps3=fltarr(nParticle)
depths3=fltarr(nParticle)
bath3=fltarr(nParticle)

;inds[0,*]=circdata[0,0:3314]
inds[0,*]=circdata[0, 0:nParticle-1L]

inds[29,*]=(indgen(3315)+1L) # REPLICATE(1., 30L)

;inds[3,*]=lengths
;inds[4,*]=weights
;inds[5,*]=store
;inds[6,*]=struc
;inds[7,*]=no_fish
; 8 = settle day
; 9 = settle lon
; 10 = settle logt
inds[11,*]=circdata[4, 0:nParticle-1L]
inds[12,*]=circdata[5, 0:nParticle-1L]
;for i=0,3314 do begin
;  for i=0L, nParticle-1L do begin
for i=0L, 99449L do begin 
    inds[11,i]=circdata[4, i]
    inds[12,i]=circdata[5, i]
endfor
; 13 = settle bath

trackdays = 90L
days=circdata[1,*]
for day=1L,trackdays do begin
  print, 'day', day
      ;dayy=float(day)
  ;    j=(dayy-1)*13260; 3315particlers*4obs
  ;    k=j+13259
 ;     j=(dayy-1)*397800L;(99450*4)
    j=(day-1)*397800L;(99450*4)      
    k=j+397799L;99450*4-1
    ;print,j, k

    daydata=circdata[*, j:k]
    daydata1=daydata[*, 0L:nParticle-1L]
    ;print, daydata[*, 99449L:397799L:99450L]
    ;print, (inds[*, 99449L])     
    
    IF Day eq 1L then begin
      InitActPart = WHERE(daydata1[8, *] GT 0., InitActPartcount)
      IF InitActPartcount GT 0. then begin 
        actinds[InitActPart] = 1
        inds[3,InitActPart]=lengths[InitActPart]
        inds[4,InitActPart]=weights[InitActPart]
        inds[5,InitActPart]=store[InitActPart]
        inds[6,InitActPart]=struc[InitActPart]
        inds[7,InitActPart]=no_fish[InitActPart]
        inds[14,InitActPart]=daydata1[1, InitActPart]
        inds[15,InitActPart]=daydata1[4, InitActPart]
        inds[16,InitActPart]=daydata1[5, InitActPart]
        Print, '#particles release', InitActPartcount
      endif
    ENDIF
    
   IF Day GT 1L then begin
    InactPart = WHERE(actinds LE 0., Inactcount)    
    IF Inactcount GT 0L then begin
      NewActPart = WHERE(daydata1[8, InactPart] GT 0., NewActPartcount)
      IF NewActPartcount GT 0. THEN begin
        actinds[InactPart[NewActPart]] = 1
        inds[3,InactPart[NewActPart]]=lengths[InactPart[NewActPart]]
        inds[4,InactPart[NewActPart]]=weights[InactPart[NewActPart]]
        inds[5,InactPart[NewActPart]]=store[InactPart[NewActPart]]
        inds[6,InactPart[NewActPart]]=struc[InactPart[NewActPart]]
        inds[7,InactPart[NewActPart]]=no_fish[InactPart[NewActPart]]        
        inds[14,InactPart[NewActPart]]=daydata1[1, InactPart[NewActPart]]
        inds[15,InactPart[NewActPart]]=daydata1[4, InactPart[NewActPart]]
        inds[16,InactPart[NewActPart]]=daydata1[5, InactPart[NewActPart]]
        Print, '#particles release', NewActPartcount
      endif
    endif
   endif
    ;Release day = 14
    ;Release Latitude = 15
    ;Release Longitude = 16
   ;print, (inds[*, 99449L])     
    
;      temps=fltarr(st)
;      depths=fltarr(st)
;      lat=fltarr(st)
;      longit=fltarr(st)
;      bath=fltarr(st)
    temps=fltarr(nParticle)
    depths=fltarr(nParticle)
    lat=fltarr(nParticle)
    longit=fltarr(nParticle)
    bath=fltarr(nParticle)      
    
      ;for i=0,3314 do begin
  ;        temps[i]=mean([daydata[8,i],daydata[8,i+3315],daydata[8,i+6630],daydata[8,i+9945]])
  ;       if (lengths[i] ge cut) then temps[i]=20.0
  ;        depths[i]=mean([daydata[7,i],daydata[7,i+3315],daydata[7,i+6630],daydata[7,i+9945]])
  ;        bath[i]=mean([daydata[6,i],daydata[6,i+3315],daydata[6,i+6630],daydata[6,i+9945]])
  ;        lat[i]=daydata[4,i+9945]
  ;        longit[i]=daydata[5,i+9945]
  
;      for i=0L, nParticle-1L do begin  
    for i=0L, 99449L do begin; daily mean temp, depth, bathy, lat, and lon                 
        temps[i]=mean([daydata[8, i], daydata[8, i+nParticle], daydata[8, i+nParticle*2L], daydata[8, i+nParticle*3L]])
         ;print, 'mean temp-nm',temps[3100]
         ;print, 'mean temp-tr',temps[830]   
        if (lengths[i] ge cut) then temps[i]=20.0
        depths[i]=mean([daydata[7, i], daydata[7, i+nParticle], daydata[7, i+nParticle*2L], daydata[7, i+nParticle*3L]])
        bath[i]=mean([daydata[6, i], daydata[6, i+nParticle], daydata[6, i+nParticle*2L], daydata[6, i+nParticle*3L]])
        lat[i]=daydata[4, i+nParticle*3L]
        longit[i]=daydata[5, i+nParticle*3L]        
    endfor
    
;  IF ActPartcount GT 0. THEN BEGIN  
;      swim_spd[ActPart]=swim(temps[ActPart], lengths[ActPart], weights[ActPart])
;      c_max[ActPart]=cmax(temps[ActPart], lengths[ActPart], weights[ActPart])
;      p_value[ActPart]=pval(depths[ActPart], bath[ActPart], lengths[ActPart], cut)
      
      swim_spd=swim(temps, lengths, weights)
      c_max=cmax(temps, lengths, weights)
      p_value=pval(depths, bath, lengths, cut, scenario)
      
      ;e_cons=fltarr(st)
      e_cons=fltarr(nParticle)
        
      ;for i=0,3314 do begin
      ;for i=0L, nParticle-1L do begin
      for i=0L, 99449L do begin                         
          e_cons[i]=p_value[i]*c_max[i]*preyed
      endfor
  
      e_loss=respire(temps, swim_spd, lengths, weights, e_cons)
      no_fish=pred(lengths, no_fish, depths, bath, cut, temps, scenario)
      no_fish=starve(lengths, weights, store, struc, no_fish, temps)
      traits=grow(lengths, weights, store, struc, e_cons, e_loss, temps)
      
;      e_loss[ActPart]=respire(temps[ActPart], swim_spd[ActPart], lengths[ActPart], weights[ActPart], e_cons[ActPart])      
;      no_fish[ActPart]=pred(lengths[ActPart], no_fish[ActPart], depths[ActPart], bath[ActPart], cut)
;      no_fish[ActPart]=starve(lengths[ActPart], weights[ActPart], store[ActPart], struc[ActPart], no_fish[ActPart])
;      traits[*, ActPart]=grow(lengths[ActPart], weights[ActPart], store[ActPart], struc[ActPart], e_cons[ActPart], e_loss[ActPart])
   ;ENDIF
      
      ;for i=0,st-1 do begin
 ;     for i=0L, nParticle-1L do begin
;      for i=0L, 99449L do begin 
;        if (settle[i] eq 0.) then begin
;           inds[26, i]=temps[i]
;           inds[27, i]=depths[i]
;           inds[28, i]=bath[i]
;          ;Mean Temperature experienced before Settlement = 26
;          ;Mean Vertical Depth Before Settlement = 27
;          ;Mean Bathymetric depth before settlement = 28                       
;        endif
         
        for i=0L, 99449L do begin
          if (settle[i] eq 0.) and (actinds[i] ge 1.) then begin
            temps2[i]=(temps2[i]+temps[i]);/(DAY-(inds[14,i]-166L))
            depths2[i]=(depths2[i]+depths[i]);/(DAY-(inds[14,i]-166L))
            bath2[i]=(bath2[i]+bath[i]);/(DAY-(inds[14,i]-166L))
            ;print, 'pre-settlement mean temps',temps[i], temps2[i]

;            inds[26, i]=temps2[i]
;            inds[28, i]=bath2[i]
;            inds[27, i]=depths2[i]
            ;Mean Temperature experienced before Settlement = 26
            ;Mean Vertical Depth Before Settlement = 27
            ;Mean Bathymetric depth before settlement = 28
          endif
          if (lengths[i] lt cut) and (traits[0,i] ge cut) then begin
              settle[i]=1
             ;if (settle[i] eq 1) then begin
             inds[25, i]=depths[i];Settlement Depth = 25
             inds[21, i]=no_fish[i];number of inds = 21
             inds[8, i]=daydata[1, i]
             inds[9, i]=lat[i]
             inds[10, i]=longit[i]
             inds[13, i]=bath[i]
             
             inds[26, i]=temps2[i]/(DAY-(inds[14,i]-166L))
             inds[27, i]=depths2[i]/(DAY-(inds[14,i]-166L))
             inds[28, i]=bath2[i]/(DAY-(inds[14,i]-166L))             
          endif
          if (actinds[i] ge 1.) and ((DAY-(inds[14,i]-166L)) LE 20) then begin
            temps3[i]=(temps3[i]+temps[i])
            depths3[i]=(depths3[i]+depths[i])
            bath3[i]=(bath3[i]+bath[i])
            inds[31, i]=temps3[i]/(DAY-(inds[14,i]-166L))
            inds[32, i]=depths3[i]/(DAY-(inds[14,i]-166L))
            inds[33, i]=bath3[i]/(DAY-(inds[14,i]-166L))
            ;print, (DAY-(inds[14,i]-166L)) 
          endif          
          ;if (settle[3100] eq 0.) and (actinds[3100] ge 1.) then print, 'mean temp-nm',temps2[3100]/(DAY-(inds[14,3100]-166L))
          ;if (settle[830] eq 0.) and (actinds[830] ge 1.) then print, 'mean temp-tr',temps2[830]/(DAY-(inds[14,830]-166L))         
      endfor
  
      ;for i=0,st-1 do begin
;      for i=0L, nParticle-1L do begin
      for i=0L, 99449L do begin                              
          lengths[i]=traits[0, i];lengths
          weights[i]=traits[1, i];weights
          store[i]=traits[2, i];store
          struc[i]=traits[3, i];struc
      endfor

      ;No individuals represented by SI 15 days after its release = 18
      ;No individuals represented by SI 30 days after its release = 19
      ;No individuals represented by SI 60 days after its release = 20
      ;No individuals represented by SI at the time of its settlement = 21
      ;SI Length 15 days after release = 22
      ;SI Length 30 days after release = 23
      ;SI Length 60 days after release = 24

    ActPart = WHERE(actinds GT 0., actcount)
    
    IF actcount GT 0L then inds[30, ActPart] = day - (inds[14, ActPart] - 166L)    
    ;IF actcount GT 0L then print,transpose(inds[30, ActPart[3000:3299L]])
    ;IF actcount GT 0L  and day gt 25 then print,transpose(inds[30, ActPart[50000:50299L]])

    IF actcount GT 0L then begin
      Act15 = WHERE(inds[30, ActPart] EQ 15, Act15count)
      IF Act15count GT 0 THEN BEGIN
        inds[18, ActPart[Act15]]=no_fish[ActPart[Act15]]
        inds[22, ActPart[Act15]]=lengths[ActPart[Act15]]
      ENDIF
      Act30 = WHERE(inds[30, ActPart] EQ 30, Act30count)
      IF Act30count GT 0 THEN BEGIN
        inds[19, ActPart[Act30]]=no_fish[ActPart[Act30]]
        inds[23, ActPart[Act30]]=lengths[ActPart[Act30]]
      ENDIF
      Act60 = WHERE(inds[30, ActPart] EQ 60, Act60count)
      IF Act60count GT 0 THEN BEGIN
        inds[20, ActPart[Act60]]=no_fish[ActPart[Act60]]
        inds[24, ActPart[Act60]]=lengths[ActPart[Act60]]
      ENDIF    
    ENDIF
    
;    IF actcount GT 0L then begin
;     IF day eq 15 then begin
;      inds[18, ActPart]=no_fish[ActPart]
;      inds[22, ActPart]=lengths[ActPart]
;     endif
;     IF day eq 30 then begin
;      inds[19, ActPart]=no_fish[ActPart]
;      inds[23, ActPart]=lengths[ActPart]
;     endif
;     IF day eq 60 then begin
;      inds[20, ActPart]=no_fish[ActPart]
;      inds[24, ActPart]=lengths[ActPart]
;     endif
     
     ;IF day eq 90 then begin
        inds[1, ActPart]=lat[ActPart]
        inds[2, ActPart]=longit[ActPart]
        inds[3, ActPart]=lengths[ActPart]
        inds[4, ActPart]=weights[ActPart]
        inds[5, ActPart]=store[ActPart]
        inds[6, ActPart]=struc[ActPart]
        inds[7, ActPart]=no_fish[ActPart]
     ;endif
    ;endif
;    print, (inds[*, 99449L]) 
  endfor

;Particle id = 0 (this is an array# = column A in the spreadsheet)
;SI lat Final = 1
;SI longit Final = 2
;SI Length Final = 3
;SI Weight Final = 4
;SI Storage Final = 5
;SI Structure Final = 6
;No individuals represented by SI at the end of the simulation (day 90) = 7
;Day of Settlement (DOY) = 8
;Settlement Latitude = 9
;Settlement Longitude = 10
;*(11 & 12 seem to be Release lat and longtit and redundant)
;Bathmetric Depth at Settlement = 13
;Release day (DOY) = 14
;Release Latitude = 15
;Release Longitude = 16
;Spatial grouping = 17
;(0=nothing, 1=Green Bay, 2= Two Rivers (n=90 per released day; i.e., 2700 total)
;, 3=Illinois-Indiana (n=90), 4=Muskegon (n=90), 5=Northern Michigan (n=90))
;No individuals represented by SI 15 days after its release = 18
;No individuals represented by SI 30 days after its release = 19
;No individuals represented by SI 60 days after its release = 20
;No individuals represented by SI at the time of its settlement = 21
;SI Length 15 days after release = 22
;SI Length 30 days after release = 23
;SI Length 60 days after release = 24
;Settlement Depth = 25
;Mean Temperature experienced before Settlement = 26
;Mean Vertical Depth Before Settlement = 27
;Mean Bathymetric depth before settlement = 28
;Particle region ID = 29
;days since release

print, 'end of fish_circmod'
return, inds
end