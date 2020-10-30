<cfset TZDateFormat 	= createobject("component","timezone")>

<cfset timezone = "US/Eastern,US/Central,US/Pacific,US/Arizona" >
<cfset date1 = '2020-10-30T13:00:00' >
<cfset date2 = '2020-10-30T16:15:00'>

<!--- 
yriaz : calls timesZone.cfc to convert given dates in UTC to equivalant passed timeszones
this automalically takes care of DLS also i beleive ( day light savings )  
 --->

<cfloop list="#timezone#" index="i" delimiters=",">

	<cfset startdate = TZDateFormat.calendarToString(calendar='default' , inputDate = '#date1#' , tzone = "#i#")>
	<cfset enddate = TZDateFormat.calendarToString(calendar='default' , inputDate = '#date2#' , tzone = "#i#" )>
	<cfdump var="#i# -- Start - #startdate# ------ "><cfdump var="End - #enddate#"> <br>


</cfloop>


Results : 

US/Eastern -- Start - 10/30/2020 at 9:00 AM ------ End - 10/30/2020 at 12:15 PM
US/Central -- Start - 10/30/2020 at 8:00 AM ------ End - 10/30/2020 at 11:15 AM
US/Pacific -- Start - 10/30/2020 at 6:00 AM ------ End - 10/30/2020 at 9:15 AM
US/Arizona -- Start - 10/30/2020 at 6:00 AM ------ End - 10/30/2020 at 9:15 AM
