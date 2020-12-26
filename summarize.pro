function summarize, inds, filename

;Particle id = 0
;SI lat Final = 1
;SI longit Final = 2

;SI Length Final = 3
;SI Weight Final = 4
;SI Storage Final = 5
;SI Structure Final = 6
;No individuals represented by SI at the end of the simulation (day 90) = 7

;Day of Settlement (DOY) = 8
;Release day (DOY) = 14

;Settlement Latitude = 9
;Settlement Longitude = 10

;Bathmetric Depth at Settlement = 13

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


;SumOutput =fltarr(5,35)
;doy = inds[14,*]

Nstatevariable = 21
output=fltarr(Nstatevariable*7,5)

for doy=166, 195 do begin
  counter = (doy - 166L)
  pointer0 = (doy - 166L)*5

; select daily outputs
daydata = where(inds[14,*] eq doy, daydatacount)

;n=N_elements(inds[0,*])
n=daydatacount
print, 'a number of SIs', n

data=fltarr(Nstatevariable,n)
data[0,*]=inds[3,daydata];/inds[30,daydata]; final lengths
data[1,*]=inds[4,daydata];/inds[30,daydata]; final weights
data[2,*]=inds[5,daydata];/inds[30,daydata]; final storage
data[3,*]=inds[6,daydata];/inds[30,daydata]; final structure
data[4,*]=inds[7,daydata];/inds[30,daydata]; final no_inds
data[5,*] = inds[8,daydata] - inds[14,daydata]
data[6,*]=inds[13,daydata]; depth at settlement
data[7,*]=inds[18,daydata]; no_fish on day 15
data[8,*]=inds[19,daydata]; no_fish on day 30
data[9,*]=inds[20,daydata]; no_fish on day 60
data[10,*]=inds[21,daydata]; no_fish at settlement
data[11,*]=inds[22,daydata]; lengths on day 15
data[12,*]=inds[23,daydata]; lengths on day 30
data[13,*]=inds[24,daydata]; lengths on day 60
data[14,*]=inds[25,daydata]; depth at settlement
data[15,*]=inds[26,daydata]; mean temp before settlement
data[16,*]=inds[27,daydata]; mean vert depth before settlement
data[17,*]=inds[28,daydata]; mean bath depth before settlement
data[18,*]=inds[31,daydata]; mean temp before settlement
data[19,*]=inds[32,daydata]; mean vert depth before settlement
data[20,*]=inds[33,daydata]; mean bath depth before settlement
      
all_ids=inds[29,daydata]
      
; 1.all fish
for i=0,20 do begin
    PosValue0 = where(data[i,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(data[i,PosValue0])
    PosValue1 = where(data[i,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(data[i,PosValue1])
    PosValue2 = where(data[i,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(data[i,PosValue2])
    PosValue3 = where(data[i,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(data[i,PosValue3])
    PosValue4 = where(data[i,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(data[i,PosValue4]) 
    
    m = 99
    n = PosValue0count; multiSIpreycount
    ;im = findgen(n)+1 ; input array
    im = PosValue0;[multiSIprey]
    IF n GT 0 THEN arr = RANDOMU(seed, n)
    ind = SORT(arr)
    SubsampleID = im[ind[0:m-1]]
    ;Print, N_ELEMENTS(SubsampleID), SubsampleID
    
    PosValue0sub = where(data[i,SubsampleID] gt 0, PosValue0subcount)
    IF PosValue0subcount gt 0 then begin
      output[i,0]=mean(data[i,SubsampleID[PosValue0sub]])
      output[i,1]=min(data[i,SubsampleID[PosValue0sub]])
      output[i,2]=max(data[i,SubsampleID[PosValue0sub]])
      output[i,3]=stddev(data[i,SubsampleID[PosValue0sub]])
      output[i,4]=total(data[i,SubsampleID[PosValue0sub]])
    ENDIF  
endfor

;for i=3,4 do begin
;    jj=where(data[i,*] gt 0.0, jjcount)
;    If jjcount GT 0 then begin
;      output[i,0]=mean(data[i,jj])
;      output[i,1]=min(data[i,jj])
;      output[i,2]=max(data[i,jj])
;      output[i,3]=n_elements(data[i,jj])
;      output[i,4]=n_elements(data[i,*])-n_elements(data[i,jj]) 
;    endif
;endfor

; region-specific output
; 2.green bay
openr, lun, 'inputfiles\gb.txt', /get_lun
gb_ids=intarr(1141)
readf, lun, gb_ids
free_lun, lun
; 3.two rivers
openr, lun, 'inputfiles\tr.txt', /get_lun
tr_ids=intarr(99)
readf, lun, tr_ids
free_lun, lun
; 4.muskegon 
openr, lun, 'inputfiles\musk.txt', /get_lun
musk_ids=intarr(99)
readf, lun, musk_ids
free_lun, lun
; 5.Illinois-Indiana
openr, lun, 'inputfiles\ii.txt', /get_lun
ii_ids=intarr(99)
readf, lun, ii_ids
free_lun, lun
; 6.northern michigan
openr, lun, 'inputfiles\nm.txt', /get_lun
nm_ids=intarr(99)
readf, lun, nm_ids
free_lun, lun
; 7.rest
openr, lun, 'inputfiles\rest.txt', /get_lun
rest_ids=intarr(1778)
readf, lun, rest_ids
free_lun, lun

; 2.green bay
;gb_el=lonarr(1141*30L)
;for i=0L,1141L-1L do begin
;    gb_el1=where(all_ids eq gb_ids[i], gb_el1count)
;    if gb_el1count gt 0. then gb_el[i*30L:i*30L+29L]=gb_el1
;    inds[17, gb_el] = 1
;endfor

gb_el=lonarr(1141)
for i=0L,1141L-1L do begin
    gb_el1=where(all_ids eq gb_ids[i], gb_el1count)
    if gb_el1count gt 0. then begin
       inds[17, daydata[gb_el1]] = 1

    endif
endfor

gbdata=data[*,gb_ids]
for i=21,41 do begin
    PosValue0 = where(gbdata[i-Nstatevariable,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(gbdata[i-Nstatevariable,PosValue0])
    PosValue1 = where(gbdata[i-Nstatevariable,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(gbdata[i-Nstatevariable,PosValue1])
    PosValue2 = where(gbdata[i-Nstatevariable,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(gbdata[i-Nstatevariable,PosValue2])
    PosValue3 = where(gbdata[i-Nstatevariable,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(gbdata[i-Nstatevariable,PosValue3])
    PosValue4 = where(gbdata[i-Nstatevariable,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(gbdata[i-Nstatevariable,PosValue4]) 
endfor

;for i=3,4 do begin
;    jj=where(gbdata[i,*] gt 0.0, jjcount)
;    If jjcount GT 0 then begin
;      output[i,5]=mean(gbdata[i,jj])
;      output[i,6]=min(gbdata[i,jj])
;      output[i,7]=max(gbdata[i,jj])
;      output[i,8]=n_elements(gbdata[i,jj])
;      output[i,9]=n_elements(gbdata[i,*])-n_elements(gbdata[i,jj])
;    endif
;endfor

; 3.two rivers
;tr_el=lonarr(99*30L)
tr_el=lonarr(99)
for i=0L,99L-1L do begin
    tr_el1=where(all_ids eq tr_ids[i], tr_el1count)
    if tr_el1count gt 0. then begin
      inds[17, daydata[tr_el1]] = 2

    endif
endfor

trdata=data[*,tr_ids]
for i=42,62 do begin  
    PosValue0 = where(trdata[i-Nstatevariable*2,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(trdata[i-Nstatevariable*2,PosValue0])
    PosValue1 = where(trdata[i-Nstatevariable*2,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(trdata[i-Nstatevariable*2,PosValue1])
    PosValue2 = where(trdata[i-Nstatevariable*2,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(trdata[i-Nstatevariable*2,PosValue2])
    PosValue3 = where(trdata[i-Nstatevariable*2,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(trdata[i-Nstatevariable*2,PosValue3])
    PosValue4 = where(trdata[i-Nstatevariable*2,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(trdata[i-Nstatevariable*2,PosValue4]) 
endfor

;for i=3,4 do begin
;    jj=where(trdata[i,*] gt 0.0, jjcount)
;    If jjcount GT 0 then begin
;      output[i,10]=mean(trdata[i,jj])
;      output[i,11]=min(trdata[i,jj])
;      output[i,12]=max(trdata[i,jj])
;      output[i,13]=n_elements(trdata[i,jj])
;      output[i,14]=n_elements(trdata[i,*])-n_elements(trdata[i,jj]); trdata ne data
;    endif
;endfor

; 4.muskegon 
;musk_el=lonarr(99*30L)
musk_el=lonarr(99)
for i=0L,99L-1L do begin
    musk_el1=where(all_ids eq musk_ids[i], musk_el1count)
    if musk_el1count gt 0. then begin
      inds[17, daydata[musk_el1]] = 4
      
    endif
endfor

muskdata=data[*,musk_ids]
for i=63,83 do begin
    PosValue0 = where(muskdata[i-Nstatevariable*3,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(muskdata[i-Nstatevariable*3,PosValue0])
    PosValue1 = where(muskdata[i-Nstatevariable*3,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(muskdata[i-Nstatevariable*3,PosValue1])
    PosValue2 = where(muskdata[i-Nstatevariable*3,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(muskdata[i-Nstatevariable*3,PosValue2])
    PosValue3 = where(muskdata[i-Nstatevariable*3,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(muskdata[i-Nstatevariable*3,PosValue3])
    PosValue4 = where(muskdata[i-Nstatevariable*3,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(muskdata[i-Nstatevariable*3,PosValue4]) 
endfor

;for i=3,4 do begin
;    jj=where(muskdata[i,*] gt 0.0, jjcount)
;    If jjcount GT 0 then begin
;      output[i,15]=mean(muskdata[i,jj])
;      output[i,16]=min(muskdata[i,jj])
;      output[i,17]=max(muskdata[i,jj])
;      output[i,18]=n_elements(muskdata[i,jj])
;      output[i,19]=n_elements(muskdata[i,*])-n_elements(muskdata[i,jj])
;    endif
;endfor

; 5.Illinois-Indiana
;ii_el=lonarr(99*30L)
ii_el=lonarr(99)
for i=0L,99L-1L do begin
    ii_el1=where(all_ids eq ii_ids[i], ii_el1count)
    if ii_el1count gt 0. then begin
      inds[17, daydata[ii_el1]] = 3

    endif  
endfor

iidata=data[*,ii_ids]
for i=84,104 do begin
    PosValue0 = where(iidata[i-Nstatevariable*4,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(iidata[i-Nstatevariable*4,PosValue0])
    PosValue1 = where(iidata[i-Nstatevariable*4,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(iidata[i-Nstatevariable*4,PosValue1])
    PosValue2 = where(iidata[i-Nstatevariable*4,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(iidata[i-Nstatevariable*4,PosValue2])
    PosValue3 = where(iidata[i-Nstatevariable*4,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(iidata[i-Nstatevariable*4,PosValue3])
    PosValue4 = where(iidata[i-Nstatevariable*4,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(iidata[i-Nstatevariable*4,PosValue4]) 
endfor

;for i=3,4 do begin
;    jj=where(iidata[i,*] gt 0.0)
;    If jjcount GT 0 then begin    
;      output[i,20]=mean(iidata[i,jj])
;      output[i,21]=min(iidata[i,jj])
;      output[i,22]=max(iidata[i,jj])
;      output[i,23]=n_elements(iidata[i,jj])
;      output[i,24]=n_elements(iidata[i,*])-n_elements(iidata[i,jj])
;    endif
;endfor

; 6.northern michigan
;nm_el=lonarr(99*30L)
nm_el=lonarr(99)
for i=0L,99L-1L do begin
    nm_el1=where(all_ids eq nm_ids[i], nm_el1count)
    if nm_el1count gt 0. then begin 
      inds[17, daydata[nm_el1]] = 5
      
    endif
endfor
nmdata=data[*,nm_ids]
for i=105,125 do begin
    PosValue0 = where(nmdata[i-Nstatevariable*5,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(nmdata[i-Nstatevariable*5,PosValue0])
    PosValue1 = where(nmdata[i-Nstatevariable*5,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(nmdata[i-Nstatevariable*5,PosValue1])
    PosValue2 = where(nmdata[i-Nstatevariable*5,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(nmdata[i-Nstatevariable*5,PosValue2])
    PosValue3 = where(nmdata[i-Nstatevariable*5,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(nmdata[i-Nstatevariable*5,PosValue3])
    PosValue4 = where(nmdata[i-Nstatevariable*5,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(nmdata[i-Nstatevariable*5,PosValue4]) 
endfor

;for i=3,4 do begin
;    jj=where(nmdata[i,*] gt 0.0)
;    If jjcount GT 0 then begin    
;      output[i,25]=mean(nmdata[i,jj])
;      output[i,26]=min(nmdata[i,jj])
;      output[i,27]=max(nmdata[i,jj])
;      output[i,28]=n_elements(nmdata[i,jj])
;      output[i,29]=n_elements(nmdata[i,*])-n_elements(nmdata[i,jj])
;    endif
;endfor

; 7.rest
;rest_el=lonarr(1778*30L)
;for i=0L,1778L-1L do begin
;    rest_el1=where(all_ids eq rest_ids[i], rest_el1count)
;    if rest_el1count gt 0. then rest_el[i*30L:i*30L+29L]=rest_el1
;endfor

rest_el=lonarr(1778L)
for i=0L,1778L-1L do begin
    rest_el1=where(all_ids eq rest_ids[i], rest_el1count)
    if rest_el1count gt 0. then begin
      inds[17, daydata[rest_el1]] = 0
      
    endif
endfor
restdata=data[*,rest_ids]
for i=126,146 do begin
    PosValue0 = where(restdata[i-Nstatevariable*6,*] gt 0, PosValue0count)
    IF PosValue0count gt 0 then output[i,0]=mean(restdata[i-Nstatevariable*6,PosValue0])
    PosValue1 = where(restdata[i-Nstatevariable*6,*] gt 0, PosValue1count)
    IF PosValue1count gt 0 then output[i,1]=min(restdata[i-Nstatevariable*6,PosValue1])
    PosValue2 = where(restdata[i-Nstatevariable*6,*] gt 0, PosValue2count)
    IF PosValue2count gt 0 then output[i,2]=max(restdata[i-Nstatevariable*6,PosValue2])
    PosValue3 = where(restdata[i-Nstatevariable*6,*] gt 0, PosValue3count)
    IF PosValue3count gt 0 then output[i,3]=stddev(restdata[i-Nstatevariable*6,PosValue3])
    PosValue4 = where(restdata[i-Nstatevariable*6,*] gt 0, PosValue4count)
    IF PosValue4count gt 0 then output[i,4]=total(restdata[i-Nstatevariable*6,PosValue4]) 
endfor

;for i=3,4 do begin
;    jj=where(restdata[i,*] gt 0.0)
;    If jjcount GT 0 then begin
;    output[i,30]=mean(restdata[i,jj])
;    output[i,31]=min(restdata[i,jj])
;    output[i,32]=max(restdata[i,jj])
;    output[i,33]=n_elements(restdata[i,jj])
;    output[i,34]=n_elements(restdata[i,*])-n_elements(restdata[i,jj])
;    endif
;endfor

  summary = output
  
  ; Export the output
  s = Size(summary, /Dimensions)
  xsize = s[0]
  lineWidth = 1600000
  comma = ","
  
  ; Open the data file for writing.
  ; Write the summary data to the file.
  IF counter EQ 0L THEN BEGIN;
    OpenW, lun, filename, /Get_Lun, Width=lineWidth
  ENDIF
  IF counter GT 0L THEN BEGIN;
    OpenU, lun, filename, /Get_Lun, Width=lineWidth
    SKIP_LUN, lun, pointer0, /lines
    READF, lun
  ENDIF
  sData = StrTrim(Summary, 2)
  sData[0:xsize-2, *] = sData[0:xsize-2, *] + comma
  PrintF, lun, sData
  
  ; Close the file.
  Free_Lun, lun
  
endfor

print, 'end of summarize'
return, output
end