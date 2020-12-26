function swim, temps, lengths, weights
;print, 'temps'
;print,temps[3315:3350]
;print,'weights'
;print,weights[3315:3350]
n=n_elements(weights)
m=n-1
l_swim=2.93*(weights^0.274)*(exp(0.056*temps))
y_swim=fltarr(n)
wat=temps

for i=0L,m do begin
	if (wat[i] gt 9) then y_swim[i]=22.08*((weights[i])^(-0.045)) else y_swim[i]=5.78*((weights[i])^(-0.045))*EXP(0.149*wat[i])
endfor

swm_spd=y_swim 
for i=0L,m do begin
	if ((lengths[i] ge 40) and (lengths[i] le 70)) then swm_spd[i]=(((70-lengths[i])/30)*l_swim[i])+(((-40+lengths[i])/30)*y_swim[i])
endfor

for i=0L,m do begin
	if (lengths[i] lt 40) then swm_spd[i]=l_swim[i]
endfor

return, swm_spd
end