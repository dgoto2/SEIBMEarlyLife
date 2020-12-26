function respire, temps, swim_spd, lengths, weights, e_cons
n=n_elements(weights)
m=n-1
F=e_cons*0.16
U=(e_cons-F)*0.1
S=(e_cons-F)*0.175

lR=(weights^1.007)*(exp(0.083*temps))*(0.00528)
yR=(weights^(1-0.2152))*(exp(0.0548*temps))*(0.00367)*(exp(0.03*swim_spd))
l_loss=F+U+S+(lR*13560)
y_loss=F+U+S+(yR*13560)
e_loss=y_loss

for i=0L,m do begin
	if ((lengths[i] ge 40) and (lengths[i] le 70)) then e_loss[i]=(((70-lengths[i])/30)*l_loss[i])+(((-40+lengths[i])/30)*y_loss[i])
endfor

for i=0L,m do begin
	if (lengths[i] lt 40) then e_loss[i]=l_loss[i]
endfor

InactPart = WHERE(temps LE 0., Inactcount)
If Inactcount gt 0. then e_loss[InactPart] = 0.

return, e_loss
end