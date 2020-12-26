function pval, depth, bath, lgth, cut, scenario
n=n_elements(depth)
m=n-1
pvalue=fltarr(n)

; no depth effect
for i=0,m do begin
    if (lgth[i] ge cut) then pvalue[i]=0.75
    if (lgth[i] lt cut) then pvalue[i]=0.6
endfor

;; with a depth effect
;for i=0L,m do begin
;   ; IF Scenario EQ '' THEN
;    pvalue[i]=0.3+0.6*exp(-0.08*bath[i]); 'baseline'    
;
;   ; IF Scenario EQ '' THEN
;    ;pvalue[i]=0.3+0.6*exp(-0.005*bath[i]); high decrease
;   ; IF Scenario EQ '' THEN
;    ;pvalue[i]=0.3+0.6*exp(-0.1*bath[i]); low decrease
;   ; IF Scenario EQ '' THEN    
;    ;;pvalue[i]=0.2+0.1*exp(0.01*bath[i]); medium increase
;   ; IF Scenario EQ '' THEN    
;    ;pvalue[i]=0.2+0.1*exp(0.03*bath[i]); high increase
;    ;if pvalue[i] gt 0.9 then pvalue[i] = 0.9
;   ; IF Scenario EQ '' THEN    
;    ;pvalue[i]=0.2+0.1*exp(0.005*bath[i]); low increase
;    ;if pvalue[i] gt 0.9 then pvalue[i] =0.9
;    
;    if (lgth[i] ge cut) then pvalue[i]=0.75
;endfor

;print, pvalue
return, pvalue
end

;for i=0,m do begin
    ;pvalue[i]=0.3+0.6*exp(-0.03*depth[i])
    ;if (lgth[i] ge cut) then pvalue[i]=0.75
;endfor