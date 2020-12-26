Pro extract

; set the directory 
CD, 'D:\alewife_seibm'; Directory; F:\SNS_SEIBM

;file = FILEPATH('alewife1998_whole.dat', Root_dir = 'C:', SUBDIR = 'Users\DGOTO\IDLWorkspace80\AlewifeCirc')

; cutoff size for transport
;Scenario1 = 'Baseline10mm_Depth_pval'
;Scenario2 = 'Baseline20mm_Depth_pval'
;Scenario3 = 'Baseline30mm_Depth_pval' 
Scenario1 = 'Baseline10mm_NoDepth'
Scenario2 = 'Baseline20mm_NoDepth'
Scenario3 = 'Baseline30mm_NoDepth'

; For the following scenarios, the cutoff size is 20mm
Scenario4 = 'Pval_base'
Scenario5 = 'Pval_HighDec'
Scenario6 = 'Pval_LowDec'
Scenario7 = 'Pval_HighInc'
Scenario8 = 'Pval_LowInc'
Scenario9 = 'Pred_base'
Scenario10 = 'Pred_HighDec'
Scenario11 = 'Pred_LowDec'
Scenario12 = 'Pred_HighInc'
Scenario13 = 'Pred_LowInc'
Scenario14 = 'Pval_HighDec+Pred_HighInc'
Scenario15 = 'Pval_HighInc+Pred_HighInc'
Scenario16 = 'Pval_HighDec+Pred_HighDec'
Scenario17 = 'Pval_HighInc+Pred_HighDec'

; Set the simulation scenario
Scenario = Scenario1; for all years 1998-2003

tstart1 = SYSTIME(/seconds); timer to annual simulations

; Year 1998
Year='1998_'
Filename98=Year+Scenario+'_output.csv'
Filename98sum=Year+Scenario+'_summary.csv'

;openr, lun, 'alewife1998_whole.dat', /GET_LUN
openr, lun, 'inputfiles\AW_PHYS_1998s.dat', /GET_LUN
;array=fltarr(9,2095080)
array=fltarr(9,35802000L)
readf, lun, array
free_lun, lun

arr=fltarr(10,35802000L)
;arr=array[*,1299480:2095079]
arr[0:8,*]=array
;arr[9, *]=(indgen(3315)+1L) # REPLICATE(1., 90*4*30L)

output=awf_circmod(arr, scenario)
summary=summarize(output, Filename98sum)

; Export the output
s = Size(output, /Dimensions)
xsize = s[0]
lineWidth = 1600000
comma = ","  
openw, lun, Filename98, /get_lun, Width=lineWidth
sOutput = StrTrim(output, 2)
sOutput[0:xsize-2, *] = sOutput[0:xsize-2, *] + comma
PrintF, lun, sOutput
free_lun, lun

;s = Size(summary, /Dimensions)
;xsize = s[0]
;lineWidth = 1600000
;comma = ","  
;openw, lun, Filename98sum, /get_lun, Width=lineWidth
;sSummary = StrTrim(Summary, 2)
;sSummary[0:xsize-2, *] = sSummary[0:xsize-2, *] + comma
;PrintF, lun, sSummary
;free_lun, lun

t_elapsed = systime(/seconds) - tstart1
;PRINT, 'Elapesed time (seconds) for all simulations:', t_elapsed 
PRINT, 'Elapesed time (minutes) for all simulations for 1998:', t_elapsed/60.


; Year 1999
Year='1999_'
Filename99=Year+Scenario+'_output.csv'
Filename99sum=Year+Scenario+'_summary.csv'

;openr, lun, 'alewife1999_whole.dat', /GET_LUN
openr, lun, 'inputfiles\AW_PHYS_1999s.dat', /GET_LUN
;array=fltarr(9,2095080)
array=fltarr(9,35802000L)
readf, lun, array
free_lun, lun

arr=fltarr(10,35802000L)
;arr=array[*,1299480:2095079]
arr[0:8,*]=array
;arr[9, *]=(indgen(3315)+1L) # REPLICATE(1., 90*4*30L)

output=awf_circmod(arr, scenario)
summary=summarize(output, Filename99sum)

; Export the output
s = Size(output, /Dimensions)
xsize = s[0]
lineWidth = 1600000
comma = ","  
openw, lun, Filename99, /get_lun, Width=lineWidth
sOutput = StrTrim(output, 2)
sOutput[0:xsize-2, *] = sOutput[0:xsize-2, *] + comma
PrintF, lun, sOutput
free_lun, lun

;s = Size(summary, /Dimensions)
;xsize = s[0]
;lineWidth = 1600000
;comma = ","  
;openw, lun, Filename99sum, /get_lun, Width=lineWidth
;sSummary = StrTrim(Summary, 2)
;sSummary[0:xsize-2, *] = sSummary[0:xsize-2, *] + comma
;PrintF, lun, sSummary
;free_lun, lun

t_elapsed = systime(/seconds) - tstart1
PRINT, 'Elapesed time (minutes) for all simulations for 1999:', t_elapsed/60.

; Year 2000
Year='2000_'
Filename00=Year+Scenario+'_output.csv'
Filename00sum=Year+Scenario+'_summary.csv'

;openr, lun, 'alewife2000_whole.dat', /GET_LUN
openr, lun, 'inputfiles\AW_PHYS_2000s.dat', /GET_LUN
;array=fltarr(9,2095080)
array=fltarr(9,35802000L)
readf, lun, array
free_lun, lun

arr=fltarr(10,35802000L)
;arr=array[*,1299480:2095079]
arr[0:8,*]=array
;arr[9, *]=(indgen(3315)+1L) # REPLICATE(1., 90*4*30L)

output=awf_circmod(arr, scenario)
summary=summarize(output, Filename00sum)

; Export the output
s = Size(output, /Dimensions)
xsize = s[0]
lineWidth = 1600000
comma = ","  
openw, lun, Filename00, /get_lun, Width=lineWidth
sOutput = StrTrim(output, 2)
sOutput[0:xsize-2, *] = sOutput[0:xsize-2, *] + comma
PrintF, lun, sOutput
free_lun, lun

;s = Size(summary, /Dimensions)
;xsize = s[0]
;lineWidth = 1600000
;comma = ","  
;openw, lun, Filename00sum, /get_lun, Width=lineWidth
;sSummary = StrTrim(Summary, 2)
;sSummary[0:xsize-2, *] = sSummary[0:xsize-2, *] + comma
;PrintF, lun, sSummary
;free_lun, lun

t_elapsed = systime(/seconds) - tstart1
PRINT, 'Elapesed time (minutes) for all simulations for 2000:', t_elapsed/60.


; Year 2001
Year='2001_'
Filename01=Year+Scenario+'_output.csv'
Filename01sum=Year+Scenario+'_summary.csv'

;openr, lun, 'alewife2001_whole.dat', /GET_LUN
openr, lun, 'inputfiles\AW_PHYS_2001s.dat', /GET_LUN
;array=fltarr(9,2095080)
array=fltarr(9,35802000L)
readf, lun, array
free_lun, lun

arr=fltarr(10,35802000L)
;arr=array[*,1299480:2095079]
arr[0:8,*]=array
;arr[9, *]=(indgen(3315)+1L) # REPLICATE(1., 90*4*30L)

output=awf_circmod(arr, scenario)
summary=summarize(output, Filename01sum)

; Export the output
s = Size(output, /Dimensions)
xsize = s[0]
lineWidth = 1600000
comma = ","  
openw, lun, Filename01, /get_lun, Width=lineWidth
sOutput = StrTrim(output, 2)
sOutput[0:xsize-2, *] = sOutput[0:xsize-2, *] + comma
PrintF, lun, sOutput
free_lun, lun

;s = Size(summary, /Dimensions)
;xsize = s[0]
;lineWidth = 1600000
;comma = ","  
;openw, lun, Filename01sum, /get_lun, Width=lineWidth
;sSummary = StrTrim(Summary, 2)
;sSummary[0:xsize-2, *] = sSummary[0:xsize-2, *] + comma
;PrintF, lun, sSummary
;free_lun, lun

t_elapsed = systime(/seconds) - tstart1
PRINT, 'Elapesed time (minutes) for all simulations for 2001:', t_elapsed/60.


; Year 2002
Year='2002_'
Filename02=Year+Scenario+'_output.csv'
Filename02sum=Year+Scenario+'_summary.csv'

;openr, lun, 'alewife2002_whole.dat', /GET_LUN
openr, lun, 'inputfiles\AW_PHYS_2002s.dat', /GET_LUN
;array=fltarr(9,2095080)
array=fltarr(9,35802000L)
readf, lun, array
free_lun, lun

arr=fltarr(10,35802000L)
;arr=array[*,1299480:2095079]
arr[0:8,*]=array
;arr[9, *]=(indgen(3315)+1L) # REPLICATE(1., 90*4*30L)

output=awf_circmod(arr, scenario)
summary=summarize(output, Filename02sum)

; Export the output
s = Size(output, /Dimensions)
xsize = s[0]
lineWidth = 1600000
comma = ","  
openw, lun, Filename02, /get_lun, Width=lineWidth
sOutput = StrTrim(output, 2)
sOutput[0:xsize-2, *] = sOutput[0:xsize-2, *] + comma
PrintF, lun, sOutput
free_lun, lun

;s = Size(summary, /Dimensions)
;xsize = s[0]
;lineWidth = 1600000
;comma = ","  
;openw, lun, Filename02sum, /get_lun, Width=lineWidth
;sSummary = StrTrim(Summary, 2)
;sSummary[0:xsize-2, *] = sSummary[0:xsize-2, *] + comma
;PrintF, lun, sSummary
;free_lun, lun

t_elapsed = systime(/seconds) - tstart1
PRINT, 'Elapesed time (minutes) for all simulations for 2002:', t_elapsed/60.


; Year 2003
Year='2003_'
Filename03=Year+Scenario+'_output.csv'
Filename03sum=Year+Scenario+'_summary.csv'

;openr, lun, 'alewife2003_whole.dat', /GET_LUN
openr, lun, 'inputfiles\AW_PHYS_2003s.dat', /GET_LUN
;array=fltarr(9,2095080)
array=fltarr(9,35802000L)
readf, lun, array
free_lun, lun

arr=fltarr(10,35802000L)
;arr=array[*,1299480:2095079]
arr[0:8,*]=array
;arr[9, *]=(indgen(3315)+1L) # REPLICATE(1., 90*4*30L)

output=awf_circmod(arr, scenario)
summary=summarize(output, Filename03sum)

; Export the output
s = Size(output, /Dimensions)
xsize = s[0]
lineWidth = 1600000
comma = ","  
openw, lun, Filename03, /get_lun, Width=lineWidth
sOutput = StrTrim(output, 2)
sOutput[0:xsize-2, *] = sOutput[0:xsize-2, *] + comma
PrintF, lun, sOutput
free_lun, lun

;s = Size(summary, /Dimensions)
;xsize = s[0]
;lineWidth = 1600000
;comma = ","  
;openw, lun, Filename03sum, /get_lun, Width=lineWidth
;sSummary = StrTrim(Summary, 2)
;sSummary[0:xsize-2, *] = sSummary[0:xsize-2, *] + comma
;PrintF, lun, sSummary
;free_lun, lun

t_elapsed = systime(/seconds) - tstart1
PRINT, 'Elapesed time (minutes) for all simulations for 2003:', t_elapsed/60.

END