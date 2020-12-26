function pred, lengths, no_fish, depth, bath, cut, temps, scenario
n=n_elements(lengths)
m=n-1
z=fltarr(n)
multp=fltarr(n)+1.0

; Depth effect
;for i=0L,m do begin
;   ; IF Scenario EQ '' THEN
;   multp[i]=0.5+2.5*EXP(-0.02*bath[i]); 'baseline'
;   ; IF Scenario EQ '' THEN   
;   ;multp[i]=0.5+2.5*EXP(-0.005*bath[i]); high decrease
;   ; IF Scenario EQ '' THEN
;   ;multp[i]=0.5+2.5*EXP(-0.1*bath[i]); low decrease
;   ; IF Scenario EQ '' THEN   
;   ;;multp[i]=0.4+0.1*EXP(0.027*bath[i]); medium increase
;   ; IF Scenario EQ '' THEN   
;   ;multp[i]=0.4+0.1*EXP(0.055*bath[i]); high increase
;   ;if multp[i] gt 3. then multp[i] = 3.
;   ; IF Scenario EQ '' THEN   
;   ;multp[i]=0.4+0.1*EXP(0.015*bath[i]); low increase
;   ;if multp[i] gt 3. then multp[i] = 3.
;    
;   if (lengths[i] ge cut) then multp[i]=1.0
;endfor
;print, multp

; No depth effect
for i=0L, m do begin;
    if (lengths[i] le 30) then z[i]=multp[i]*0.5*EXP(-0.1*lengths[i])
    if (lengths[i] gt 30) then z[i]=0.02
endfor

no_ind=fltarr(n)
for i=0L, m do begin
    no_ind[i]=no_fish[i]*(EXP(-z[i]))
endfor

InactPart = WHERE(temps LE 0., Inactcount)
If Inactcount gt 0. then no_ind[InactPart] = no_fish[InactPart]

;print, 'inactive particles#=', Inactcount
;print, 'no_fish'
;print,no_fish[50000:50049]

return, no_ind
end

;for i=0,m do begin
    ;multp[i]=0.5+2.5*EXP(-0.02*depth[i])
    ;if (lengths[i] ge cut) then multp[i]=1.0
;endfor

;for i=0,m do begin
    ;multp[i]=0.5+2.5*EXP(-0.02*bath[i])
    ;if (lengths[i] ge cut) then multp[i]=1.0
;endfor