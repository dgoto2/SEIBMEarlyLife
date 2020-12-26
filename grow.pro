function grow, lengths, weights, store, struc, e_cons, e_loss, temps


n=n_elements(weights)
m=n-1
e_change=e_cons-e_loss
optrho=0.0253*(lengths^0.6547)

for i=0L,m do begin
	if (lengths[i] gt 150) then optrho[i]=0.7
endfor

wtX=store
optwtX=optrho*weights
newX=fltarr(n)
newY=fltarr(n)
newwt=fltarr(n)
potX=wtX+(e_change/10000)
e_left=(potX-optwtX)*10000
pcentX=5*optrho/6
pcentY=(1-optrho)/6

for i=0L,m do begin
	if (e_change[i] ge 0) then begin
		if (wtX[i] ge optwtX[i]) then begin
			newX[i]=store[i]+(pcentX[i]/(pcentX[i]+pcentY[i]))*(e_change[i]/10000)
			newY[i]=struc[i]+(pcentY[i]/(pcentX[i]+pcentY[i]))*(e_change[i]/2000)
			newwt[i]=newX[i]+newY[i]
		endif
		if (wtX[i] lt optwtX[i]) then begin
			if (potX[i] lt optwtX[i]) then begin
				newX[i]=potX[i]
				newY[i]=struc[i]
				newwt[i]=newX[i]+newY[i]
			endif
			if (potX[i] ge optwtX[i]) then begin
				newX[i]=optwtX[i]+(pcentX[i]/(pcentX[i]+pcentY[i]))*(e_change[i]/10000)
				newY[i]=struc[i]+(pcentY[i]/(pcentX[i]+pcentY[i]))*(e_change[i]/2000)
				newwt[i]=newX[i]+newY[i]
			endif
		endif
	endif
	if (e_change[i] lt 0) then begin
		newX[i]=potX[i]
		newY[i]=struc[i]
		newwt[i]=newX[i]+newY[i]
	endif
end

potlgth=fltarr(n)
newlgth=fltarr(n)
for i=0L,m do begin
	if (lengths[i] lt 20) then potlgth[i]=((newwt[i]/0.0000003)^(1/3.553))
	if (lengths[i] gt 40) then potlgth[i]=((newwt[i]/0.0000031)^(1/3.194))
	if ((lengths[i] ge 20) and (lengths[i] le 40)) then potlgth[i]=(((40-lengths[i])/20)*((newwt[i]/0.0000003)^(1/3.553)))+(((-20+lengths[i])/20)*((newwt[i]/0.0000031)^(1/3.194)))
	if (lengths[i] lt 10) then potlgth[i]=(((10-lengths[i])/10)*((newwt[i]/0.0000291)^(1/1.394)))+(((lengths[i])/10)*((newwt[i]/0.0000003)^(1/3.553)))
endfor

for i=0L,m do begin
	if (potlgth[i] gt lengths[i]) then newlgth[i]=potlgth[i] else newlgth[i]=lengths[i]
endfor

atributes=fltarr(4,n)
atributes[0,*]=newlgth
atributes[1,*]=newwt
atributes[2,*]=newX
atributes[3,*]=newY

InactPart = WHERE(temps LE 0., Inactcount)
If Inactcount gt 0. then begin
  atributes[0,InactPart]=lengths[InactPart]
  atributes[1,InactPart]=weights[InactPart]
  atributes[2,InactPart]=store[InactPart] 
  atributes[3,InactPart]=struc[InactPart]
endif

;print, 'temps'
;print,temps[50000:50049]
;print,'lengths'
;print,lengths[50000:50049]


return, atributes

end