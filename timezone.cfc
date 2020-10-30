<cfcomponent name="TZDateFormat">



    <cffunction name="calendarToString" access="public" returntype="string" output="false" hint="I take a given instance of java.util.GregorianCalendar and return a readable date/time string.">
    
        <!--- Define arguments. --->
        <cfargument name="calendar" type="any" required="true" hint="I am the Java calendar for which we are creating a user-friendly date string."            />
    	<cfargument name="inputDate" required="no" default="#now()#">
        <cfargument name="tzone" required="yes" >
        
		<cfset variables.dteDate = arguments.inputDate >
        
        
        
         
        <!--- Define the local scope. --->
        <cfset var local = {} />
    
        <!---
            Create a simple date formatter that will take our calendar
            date and output a nice date string.
        --->
        <cfset local.formatter = createObject( "java", "java.text.SimpleDateFormat" ).init(
            javaCast( "string", "MM/dd/yyyy 'at' h:mm aa" )
            ) />
    
        <!---
            By default, the date formatter uses the date in the default
            timezone. However, since we are working with given calendar,
            we want to set the timezone of the formatter to be that of
            the calendar.
        --->
 
 
 
		  <!---
              Let's get the UTC timezone. This will help us convert to and
              from other timezone offsets.
          --->
          <cfset variables.utcTimezone = createObject( "java", "java.util.TimeZone" )
              .getTimeZone(
                  javaCast( "string", "UTC" )
                  )
              />
          
          <!--- Create an UTC Start calendar. --->
          <cfset variables.utcCalendar = createObject( "java", "java.util.GregorianCalendar" ).init(
              variables.utcTimezone
              ) />

          
          <!---
              Set the year, month, day, hour, and seconds.
          
              NOTE: In the Java calendar, months start at 1 (not zero as in
              ColdFusion). This is why we are subtracting 1 in the second
              parameter in the following method call.
          --->
          <cfset variables.utcCalendar.set(
              javaCast( "int", year( variables.dteDate ) ),
              javaCast( "int", (month( variables.dteDate ) - 1) ),
              javaCast( "int", day( variables.dteDate ) ),
              javaCast( "int", hour( variables.dteDate ) ),
              javaCast( "int", minute( variables.dteDate ) ),
              javaCast( "int", second( variables.dteDate ) )
              ) />

          
          <!---
              Set the milliseconds in order to get a static time (otherwise
              the calendar will be adding milliseconds based on the system
              clock).
          --->
          <cfset variables.utcCalendar.set(
              javaCast( "int", variables.utcCalendar.MILLISECOND ),
              javaCast( "int", 0 )
              ) />



		  <!--- -------------------default start---------------------------------- --->
          <!--- ----------------------------------------------------- --->
          
          
          <!---
              Now, let's create a passed timezone to see if we can convert time
              back and forth between the two calendars.
          --->
          <cfset variables.defaultTimezone = createObject( "java", "java.util.TimeZone" )
              .getTimeZone(
                  javaCast( "string", "#arguments.tzone#" )
                  )
              />
          
          <!--- Create an EST Start / End calendar. --->
          <cfset variables.defaultCalendar = createObject( "java", "java.util.GregorianCalendar" ).init(
              variables.defaultTimezone
              ) />

          
          <!---
              Set the time of the ETC calendar using the time of the passed
              calendar. This should take into account all of the offsets and
              the daylight saving time calculations.
          --->
          <cfset variables.defaultCalendar.setTimeInMillis(
              variables.utcCalendar.getTimeInMillis()
              ) />
 
 
 
         <cfset local.formatter.setTimeZone(
            variables.defaultCalendar.getTimeZone()
            ) />

 
 
    
        <!--- Return the formatted date in the given timezone. --->
        <cfreturn local.formatter.format(
            variables.defaultCalendar.getTime()
            ) />
    </cffunction>








 
</cfcomponent>