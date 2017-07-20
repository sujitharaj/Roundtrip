*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

Library           DateTime

Test Teardown     Close Browser
	
*** Test Cases ***
Valid open
    Open Browser To Home Page
	Input OriginAirport    PDX
	Input DestinationAirport    EWR
	${departureDate} =	Get Current Date
	${departureDate} =	Add Time To Date	${departureDate}	21 days
	${departureDateStr} =	Convert Date	${departureDate}	result_format=%m/%d
	
	${arrivalDate} =	Add Time To Date	${departureDate}	4 days
	${arrivalDateStr} =	Convert Date	${arrivalDate}	result_format=%m/%d
	
	Input DepartureDate    ${departureDateStr}
	Input ReturnDate    ${arrivalDateStr}
	
	Search Flights
	
	${firstOutBound}=    Get Matching XPath Count    //tr[@id='outbound_flightRow_1']
	Should Be Equal    ${firstOutBound}    1

	${firstInBound}=    Get Matching XPath Count    //tr[@id='inbound_flightRow_1']
	Should Be Equal    ${firstInBound}    1
	
	[Teardown]    Close Browser
	
