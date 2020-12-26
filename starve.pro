function starve, lengths, weights, stor, struc, no_fish, temps
n=n_elements(weights)
m=n-1
same=no_fish
optrho=0.0253*(lengths^0.6547)

for i=0L,m do begin
    if (lengths[i] gt 150) then optrho[i]=0.7
endfor

storage=stor
structure=struc
actrho=storage/(storage+structure)
p_starve=fltarr(n)

for i=0L,m do begin
    p_starve[i]=1.5-2*(actrho[i]/optrho[i])
    if (actrho[i] gt 0.75*optrho[i]) then p_starve[i]=0
    if (actrho[i] lt 0.25*optrho[i]) then p_starve[i]=1
endfor

no_ind=fltarr(n)
for i=0L,m do begin
    no_ind[i]=no_fish[i]*(1-p_starve[i])
endfor

InactPart = WHERE(temps LE 0., Inactcount)
If Inactcount gt 0. then no_ind[InactPart] = no_fish[InactPart]

;print, 'inactive particles#=', inactpart
;print, 'no_fish'
;print,no_fish[50000:50049]


return, no_ind
end