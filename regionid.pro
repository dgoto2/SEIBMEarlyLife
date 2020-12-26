; region-specific output
openr, lun, 'gb.txt', /get_lun
gb_ids=intarr(1141)
readf, lun, gb_ids
free_lun, lun

openr, lun, 'musk.txt', /get_lun
musk_ids=intarr(99)
readf, lun, musk_ids
free_lun, lun

openr, lun, 'tr.txt', /get_lun
tr_ids=intarr(99)
readf, lun, tr_ids
free_lun, lun

openr, lun, 'ii.txt', /get_lun
ii_ids=intarr(99)
readf, lun, ii_ids
free_lun, lun

openr, lun, 'nm.txt', /get_lun
nm_ids=intarr(99)
readf, lun, nm_ids
free_lun, lun

openr, lun, 'rest.txt', /get_lun
rest_ids=intarr(1778)
readf, lun, rest_ids
free_lun, lun

all_ids=(indgen(3315)+1L) # REPLICATE(1., 30L)

; green bay
gb_el=lonarr(1141*30L)
for i=0L,1141L-1L do begin
    gb_el1=where(all_ids eq gb_ids[i], gb_el1count)
    if gb_el1count gt 0. then gb_el[i*30L:i*30L+29L]=gb_el1
;print, gb_el1
;print, gb_el[i*30L:i*30L+29L]
endfor
;print, gb_el
print,all_ids[gb_el]
print, N_elements(gb_el)


print, 'end'
end