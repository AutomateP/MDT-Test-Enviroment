' //#########################################################################################
' //#   MICROSOFT LEGAL STATEMENT FOR SAMPLE SCRIPTS/CODE
' //#########################################################################################
' //#
' //#   THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY 
' //#   OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED 
' //#   WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
' //#
' //#   We grant You a nonexclusive, royalty-free right to use and modify the Sample Code 
' //#   and to reproduce and distribute the object code form of the Sample Code, provided 
' //#   that You agree: 
' //#   (i)      to not use Our name, logo, or trademarks to market Your software product 
' //#            in which the Sample Code is embedded; 
' //#   (ii)     to include a valid copyright notice on Your software product in which 
' //#            the Sample Code is embedded; and 
' //#   (iii)    to indemnify, hold harmless, and defend Us and Our suppliers from and 
' //#            against any claims or lawsuits, including attorneys� fees, that arise 
' //#            or result from the use or distribution of the Sample Code.
' //#########################################################################################
' //***************************************************************************
' // ***** Script Header *****
' //
' // Solution:  Custom Script for use with the Microsoft ZTI Solution
' // File:      MachineNameExit.vbs
' //
' // Purpose:   User exit script to get computername based on chassis and location.
' //            LocationID should be set in the MDT deployment database
' //            
' // Usage:     Modify CustomSettings.ini similar to this:
' //
' //              [Settings]
' //              Priority=BuildComputerName, Default 
' //              Properties=MyCustomProperty, BuildComputerName, LocationID
' // 
' //              [BuildComputerName]
' //              UserExit=MachineNameExit.vbs
' //              BuildComputerName=#BuildComputerName()#
' //
' // Version:   1.0.0
' //
' // ***** End Header *****
' //***************************************************************************

Function UserExit(sType, sWhen, sDetail, bSkip)

    oLogging.CreateEntry "USEREXIT:MachineNameExit.vbs started: " & sType & " " & sWhen & " " & sDetail, LogTypeInfo

    UserExit = Success

End Function


Function BuildComputerName()
	
     oLogging.CreateEntry "------------ Initialization USEREXIT:MachineNameExit.vbs|BuildComputerName -------------", LogTypeInfo
   
    sLocID = oEnvironment.Item("LocationID")
    sShopCode = oEnvironment.Item("ShopCode")
    sChassisLaptop = oEnvironment.Item("isLaptop")
    sChassisDesktop = oEnvironment.Item("isDesktop")
    sChassisVM = oEnvironment.Item("isVM")
    sSerialNumber = oEnvironment.Item("SerialNumber")
  
    BuildComputerLocID = ""
    BuildComputerShopCode = ""
    BuildComputerChassis = ""
    BuildComputerSerial = ""
    BuildComputerName = ""
    
    ' Set the Location part of the computername
    BuildComputerLocID = sLocID
    If BuildComputerLocID = "" then BuildComputerLocID = "XX"						
    oLogging.CreateEntry "USEREXIT:MachineNameExit.vbs|BuildComputerName - Location element has been set to " & BuildComputerLocID, LogTypeInfo
 
    ' Set the ShopCode part of the computername
    BuildComputerShopCode = sShopCode
    If BuildComputerShopCode = "" then BuildComputerShopCode = "XX"						
    oLogging.CreateEntry "USEREXIT:MachineNameExit.vbs|BuildComputerName - Location element has been set to " & BuildComputerShopCode, LogTypeInfo

    ' Set the Chassis part of the computername
    If sChassisLaptop = "" then BuildComputerChassis = "X"
    if sChassisLaptop = "True" then BuildComputerChassis = "L"
    If sChassisDesktop = "True" then BuildComputerChassis = "W"
    If sChassisVM = "True" then BuildComputerChassis = "V"
    oLogging.CreateEntry "USEREXIT:MachineNameExit.vbs|BuildComputerName - Chassis element has been set to " & BuildComputerChassis, LogTypeInfo

    'set the serial number part of the name to the last seven characters and replace spaces with -
    BuildComputerSerial = right(sSerialNumber,2)
    BuildComputerSerial = Replace(BuildComputerSerial, " ", "-")
    oLogging.CreateEntry "USEREXIT:MachineNameExit.vbs|BuildComputerName - serial number element has been set to " & BuildComputerSerial, LogTypeInfo

    'Create the Computername
    BuildComputerName = BuildComputerShopCode & "TILL" & "01"
    oLogging.CreateEntry "USEREXIT:MachineNameExit.vbs|BuildComputerName - OSDComputername will be set to " & BuildComputerName, LogTypeInfo

    oLogging.CreateEntry "------------ Departing USEREXIT:MachineNameExit.vbs|BuildComputerName -------------", LogTypeInfo

End Function

