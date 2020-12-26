Pro InputTest

;openr, lun, 'AW_PHYS_1998s.dat', /GET_LUN
;;array=fltarr(9,2095080)
;readf, lun, array
;PRINT, lun
;free_lun, lun

;NCDF_INQUIRE('AW_PHYS_1998s.dat')

;file = 'm99091.t.nc'
;nCDF_Browser, file

;READING ASCII FILES
file = 'AW_PHYS_1998s.dat'
tstart1 = SYSTIME(/seconds); timer for each daily time step

; Determine the number of rows in the file.
rows = File_Lines(file)
print,'#rows', rows
; Determine the number of colums in the file by reading
; the first line and parsing it into column units.
OpenR, lun, file, /Get_Lun
line = ""
ReadF, lun, line

 ; Find the number of columns in the line.
cols = N_Elements(StrSplit(line, /RegEx, /Extract))
print,'#columns', cols

; Create a variable to hold the data.
data = FltArr(cols, rows)

; Rewind the data file to its start.
Point_Lun, lun, 0

; Read the data.

ReadF, lun, data
;inputdata1 = (data[0, *])
;inputdata2 = (data[1, *])
;inputdata3 = (data[2, *])
;inputdata4 = (data[3, *])
;inputdata5 = (data[4, *])
;inputdata6 = (data[5, *])
;inputdata7 = (data[6, *])
;inputdata8 = (data[7, *])
;inputdata9 = (data[8, *])
Free_Lun, lun
print, 'inputdata'
print,data[*, 99449L:35801999L:99450L]

;print,data[*, 99449L]
;print,data[*, 99449L+99450L*1L]
;print,data[*, 99449L+99450L*2L]
;print,data[*, 99449L+99450L*3L]
;print,data[*, 99449L+99450L*4L]
;print,data[*, 99449L+99450L*5L]
;print,data[*, 99449L+99450L*6L]
;print,data[*, 99449L+99450L*7L]
;print,data[*, 99449L+99450L*8L]

;print,data[*, 3315L:3315L+3315L]

;print,data[*, 35798684L]
;print,data[*, 35801999L]
;inputdata=fltarr(10, 99450L*30*4*90)
;inputdata[0:8L,*]=data[*,0L:99449L]
;inputdata[9,*]=(indgen(3315)+1L) # REPLICATE(1., 30*4*90L)
;print,inputdata[*, 0L:99449L*10]
PartSpaceID=(indgen(3315)+1L) # REPLICATE(1., 30*4*90L)

;s = Size(inputdata, /Dimensions)
;xsize = s[0]
;lineWidth = 1600
;comma = ","  
;openw, lun, 'testinput', /get_lun, Width=lineWidth
;sdata = StrTrim(inputdata, 2)
;sdata[0:xsize-2, *] = sdata[0:xsize-2, *] + comma
;PrintF, lun, sdata
;free_lun, lun



t_elapsed = systime(/seconds) - tstart1
;PRINT, 'Elapesed time (seconds) for all simulations:', t_elapsed 
PRINT, 'Elapesed time (minutes) for all simulations:', t_elapsed/60.
PRINT, 'end of input'

;PRO readNetCDFtest  
;  filename = "m99091.t.nc"
;  
;  ;Get an ID for the netcdf file and open it 
;  id = NCDF_OPEN(filename)
;  ;Extract event data
;  NCDF_VARGET, id, "event" , eventData
;  ;Extract altitude data
;  NCDF_VARGET, id, "Altitude" , altitudeData
;  ;Extract temperature data
;  NCDF_VARGET, id, "Temperature" , temperatureData
;  
;
;  NCDF_CLOSE,id  ;Close the file
;
;  PRINT,"Events in datafile: "
;  PRINT, eventData
;  PRINT,"Altitude grid in datafile: "
;  PRINT, altitudeData
;  PRINT,"Temperature for first event in datafile: "
;  PRINT, temperatureData[*, 0]
  
;The Structure of the netCDF File
;This sections describes how the data files are built up internally. Usually you won't have to bother about that. It's just reference information for people who have to deal with how read_sm, write_sm and other procedures work internally.

;We use the netCDF data format for STXM data files. Information can be found at http://www.unidata.ucar.edu/packages/netcdf/. IDL has a lot of built-in functions to deal with netCDF files. Information can be found in the help-index under netcdf, and all the functions start with ncdf_.

;To open and read from a netCDF file in IDL, do
;datafile = "m99091.t.nc"
;id=ncdf_open(datafile,/nowrite)
;You will have to refer to id on all the following commands. When you are done with the file, you should close it:
;ncdf_close, id
;The following are stored in the netCDF file: dimensions, variables and global attributes. You can get information about the datafile by doing the following:
;info=ncdf_inquire(id)
;help,info,/str
;    ** Structure<152b0d0>, 4 tags, length=16, data length=16, refs=1:
;      NDIMS           LONG                 3
;      NVARS           LONG                 3
;      NGATTS          LONG                97
;      RECDIM          LONG                -1
;which gives you the number of dimensions, the number of variables and the number of global attributes. We won't worry about RECDIM.

;END


;;Reading Data in netCDF
;;Much of this will look similar to the HDF methodology, so some of the commentary is reduced. Those who want a fuller explanation may refer to similar sections above.
;
;;1. Open the file and assign it a file ID
;;filename = "m99091.t.nc"
;    fileID = ncdf_open('m99091.t.nc')
;;When you are completely through with the file you should close it using the ncdf_close, fileID command.
;
;;2. Find the number of file attributes and datasets (or variables). The information will be contained in the structure variable that we have named 'fileinq_struct', but you may give it any name you wish so long as you use the proper record names.
;
;    fileinq_struct=ncdf_inquire(fileID)
;
;  nvars = fileinq_struct.nvars 
;;  natts = fileinq_struct.natts
;
;;3. Read the file (global) attributes
;
;    global_attname=ncdf_attname(fileID,attndx,/global) 
;    ncdf_attget,fileID,global_attname,value,/global
;
;;4. Use the variable index to get the name, dimensions, and number of attributes
;
;    varinq_struct=ncdf_varinq(fileID,varndx) 
;    variable_name = varinq_struct.name 
;    dimensions = varinq_struct.dims 
;    numatts = varinq_struct.natts 
;;Note that the lack of a NameToIndex function such as found in HDF means you'll have to explore the variables one by one by index in order to find the one you want.
;
;;5. Read the variable attributes
;
;;First get the name of the attribute by index
;    attname=ncdf_attname(fileID,varndx,attndx)
;
;;Now read the attribute
;    ncdf_attget,fileID,varndx,attname,value
;
;;Note how this uses the same command as for getting global attributes, but the variable index must be included when the /global switch is not set.
;
;;6. Get an ID for the variable
;    varID=ncdf_varid(fileID,varname)
;
;;7. Import the selected dataset
;    ncdf_varget,fileID,varID,variable
;
;;If the data is in integerized form, you will need to convert it to the true values using the scale factor and offset that (hopefully) is stored in the attributes for the variable.
;;Now you're done!



;IDL Procedures for Exploring and Reading netCDF Data
;You will need to copy the goes data file to your directory, as well as the IDL procedures 'ncdfshow.pro' and 'ncdfread.pro'.
;The ncdfshow.pro procedure will find the number of variables, the number of attributes per variable, and loop through them in order to write them into a text file that you specify. To run it from the IDL command line type:
   ;ncdfshow,'fileinfo.txt'

;Where you should typically provide something more descriptive than 'fileinfo' to write the result into. You will be prompted to select a file, so select the GOES data file provided. After it runs, open fileinfo.txt and see what information is in the file.
;Now that you know the name of the variable you want to look at, you can run the ncdfread.pro procedure to get the data in raw form. You will want to put the actual filename into a variable that's a little easier to handle first.

   ;filename = dialog_pickfile() 
    ;ncdfread,filename,'variable_name',data_variable,dims 
;Where 'variable_name' is a string that must match exactly the name you found in 'fileinfo.txt', data_variable is where the data ends up, and dims is a vector of the array dimensions.
;Now you have the data in an IDL variable, you may need to use any offset and scale information found in the attributes to scale it to a physically meaningful quantity.

END