function cmax, temps, lengths, weights
n=n_elements(weights)
m=n-1
lCmax=0.5*(weights^(-0.1504))
yCmax=0.8464*(weights^(-0.3))
C_max=yCmax

for i=0L,m do begin
	if ((lengths[i] ge 30) and (lengths[i] le 60)) then C_max[i]=(((60-lengths[i])/30)*lCmax[i])+(((-30+lengths[i])/30)*yCmax[i])
endfor

for i=0L,m do begin
	if (lengths[i] lt 30) then C_max[i]=lCmax[i]
endfor

Gone=0.28828671378
Gtwo=2.82898004942
Lone=exp((temps-5)*Gone)
Ltwo=exp((31-temps)*Gtwo)
KA=(Lone*0.17)/(1+(0.17*(Lone-1)))
KB=(Ltwo*0.01)/(1+(0.01*(Ltwo-1)))
f_t=KA*KB
C_maxx=C_max*weights*f_t

return, C_maxx
end