; region-specific output
openr, lun, 'gb.txt', /get_lun
gb_ids=fltarr(1141)
readf, lun, gb_ids
free_lun, lun

openr, lun, 'musk.txt', /get_lun
musk_ids=fltarr(99)
readf, lun, musk_ids
free_lun, lun

openr, lun, 'tr.txt', /get_lun
tr_ids=fltarr(99)
readf, lun, tr_ids
free_lun, lun

openr, lun, 'ii.txt', /get_lun
ii_ids=fltarr(99)
readf, lun, ii_ids
free_lun, lun

openr, lun, 'nm.txt', /get_lun
nm_ids=fltarr(99)
readf, lun, nm_ids
free_lun, lun

nonothers=([gb_ids,musk_ids, tr_ids, ii_ids, nm_ids])
;print,transpose(nonothers)

;print,n_elements(nonothers)
;print, 3315-n_elements(nonothers)
allpart=indgen(3315)+1L
ot_ids=fltarr(3315-1141-99-99-99-99)
ot_ids1=fltarr(3315-1141)

;print,
;for i2=0L, n_elements(nonothers) do begin
for i1=0L,3315-1L do begin

ot_ids1=where(nonothers ne i1, ot_ids1count)
;print,ot_ids1count
if ot_ids1count eq 1537 then print, i1

;endfor
;=n_elements(i1)+n_elements(i1)
endfor
;print, ot_ids1count

print, 'end'
end