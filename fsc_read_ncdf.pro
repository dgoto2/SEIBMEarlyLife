PRO FSC_Read_NCDF
; this function is to read the contents of a NETCDF format file

tstart1 = SYSTIME(/seconds); timer for each daily time step

;Reading NetCDF Files
;tempdata1=fltarr(2L, 32881L)
tempdata2=fltarr(3L, 32881L*19L)
;tempdata3=fltarr(4L, 499791200L)

;The following commands should be used to read data from a netCDF file:
Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
;Tempfileformat = NCDF_INQUIRE(Tempfile) ; Call this function to find the format of the netCDF file.
;PRINT, 'File format: {Ndims, Nvars, Ngatts, Recdim}'
;PRINT,Tempfileformat; { NDIMS:0L, NVARS:0L, NGATTS:0L, RECDIM:0L }

;DimID = NCDF_DIMID(Tempfile, 'time')
;PRINT, DimID
;;NCDF_DIMINQ, Tempfile, DimID, 'time', 800  ; Retrieve the names and sizes of dimensions in the file.
VarID = INTARR(7)
VarID[0] = NCDF_VARID(Tempfile, 'time')
VarID[1] = NCDF_VARID(Tempfile, 'lon')
VarID[2] = NCDF_VARID(Tempfile, 'lat')
VarID[3] = NCDF_VARID(Tempfile, 'depth')
VarID[4] = NCDF_VARID(Tempfile, 'sigma')
VarID[5] = NCDF_VARID(Tempfile, 'd3d')
VarID[6] = NCDF_VARID(Tempfile, 'temp')
NCDF_CLOSE, Tempfile ; Close the file.

;VarID2 = string([VarID[0], VarID[1], VarID[2], VarID[3]])
;PRINT, VarID2
; VarID: 0=tiem; 1=lon; 2=lat; 3=depth; 4=sigma; 5=d3d; 6=temp
;VarStruc = NCDF_VARINQ(Tempfile, 6)    ; Retrieve the names, types, and sizes of variables in the file.
;PRINT, '{ NAME:"", DATATYPE:"", NDIMS:0L, NATTS:0L, DIM:LONARR(NDIMS) }'
;PRINT, VarStruc
;AttName = NCDF_ATTNAME(Tempfile, 6, /GLOBAL)   ; Optionally, retrieve attribute names.
;PRINT, AttName
;AttStruc = NCDF_ATTINQ(Tempfile, 0, /GLOBAL)    ; Optionally, retrieve the types and lengths of attributes.

;DIRECTORY:   c:\~
;FILENAME:   m99091.t.nc
;INSTITUTION:   University of Michigan
;COMMENT1:   Lake Michigan  2 km bathymetric grid
;COMMENT2:   6-hourly model output starting at validtime plus 6 hr
;VALIDTIME:   01-APR-1999 00:00 GMT
;VALIDTIME_DOY:   091, 1999 00:00 GMT
;AUTHOR:   beletsky@umich.edu
;CREATION_DATE:   Wed Apr 24 15:35:57 2013 GMT

;NCDF_ATTGET,Tempfile, /GLOBAL, 'CREATION_DATE', filename; Optionally, retrieve the attributes.

;; Read the data back out:
;NCDF_VARGET, id, vid, output_data
;NCDF_ATTGET, id, vid, 'long_name', ztitle
;NCDF_ATTGET, id, hid, 'long_name', ytitle
;NCDF_ATTGET, id, vid, 'units', subtitle
;!P.CHARSIZE = 2.5
;!X.TITLE = 'Location'
;!Y.TITLE = STRING(ytitle) ; Convert from bytes to strings.
;!Z.TITLE = STRING(ztitle) + '!C' + STRING(subtitle)
;NCDF_CLOSE, id ; Close the NetCDF file.
;SHOW3, output_data ; Display the data.
;n = 196608
;tempfile2 = FLTARR(4L, N)

Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
NCDF_VARGET, Tempfile, VarID[0], timedata ; Read the data from the variables.
print, n_elements(timedata)
;tempdata3 = FLTARR(3L, n_elements(timedata))
;tempdata3[0, *] = timedata
NCDF_CLOSE, Tempfile ; Close the file.

Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
NCDF_VARGET, Tempfile, VarID[1], londata ; Read the data from the variables.
print, n_elements(londata)
;Tempdata1[0,*] = londata
NCDF_CLOSE, Tempfile ; Close the file.
;Tempdata1[0,*] = londata

Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
NCDF_VARGET, Tempfile, VarID[2], latdata ; Read the data from the variables.
print, n_elements(latdata)
;Tempdata1[1,*] = latdata
NCDF_CLOSE, Tempfile ; Close the file.
;Tempdata1[1,*] = latdata

;Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
;NCDF_VARGET, Tempfile, VarID[3], depthdata ; Read the data from the variables.
;;print, n_elements(depthdata)
;NCDF_CLOSE, Tempfile ; Close the file.

Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
NCDF_VARGET, Tempfile, VarID[4], sigmadata ; Read the data from the variables.
print, n_elements(sigmadata);
NCDF_CLOSE, Tempfile ; Close the file.
;print, sigmadata

Tempfile = NCDF_OPEN('m99091.t.nc', /NOWRITE) ; Open an existing netCDF file.
NCDF_VARGET, Tempfile, VarID[6], tempdata ; Read the data from the variables.
print, n_elements(tempdata)
;Tempdata3[3,*] = tempdata
NCDF_CLOSE, Tempfile ; Close the file.

; Create 19-vertical layer array for each x&y cell 
;depth = INDGEN(20) + 1L; 1 = top layer; 20 = bottom layer
zl = (sigmadata) # REPLICATE(1., 32881L)
;print, zl

n=32881L
;FOR i = 0L, n - 1L, 19L DO BEGIN
;  Tempdata4[0, i:i+18L] = londata[i]; # REPLICATE(1., 19L)
;  Tempdata4[1, i:i+18L] = latdata[i]; # REPLICATE(1., 19L)
;ENDFOR
FOR i = 0L, n - 1L, 19L DO Tempdata2[0, i:i+18L] = londata[i]; # REPLICATE(1., 19L)
FOR i = 0L, n - 1L, 19L DO Tempdata2[1, i:i+18L] = latdata[i]; # REPLICATE(1., 19L)
Tempdata2[2, *]=zl
;print, tempdata2[*, 0:100L]

londata2 = transpose(Tempdata2[0,*]) # REPLICATE(1., 800L)
latdata2 = transpose(Tempdata2[1,*]) # REPLICATE(1., 800L)
sigmadata2 = transpose(Tempdata2[2,*]) # REPLICATE(1., 800L)
;print, londata2[0:100L]
;print, latdata2[0:100L]
;print, sigmadata2[0:100L]
;print, tempdata[0:100L]

t_elapsed = systime(/seconds) - tstart1
;PRINT, 'Elapesed time (seconds) for all simulations:', t_elapsed 
PRINT, 'Elapesed time (minutes) for all simulations:', t_elapsed/60.
PRINT, 'end of input'
;tempdata2[3, *] = tempdata
;NCDF_CLOSE, Tempfile ; Close the file.
END