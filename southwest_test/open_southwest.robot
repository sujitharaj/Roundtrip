*** Settings ***
Documentation     A test suite for testing Roundtrip flight itinerary in southwest Airlines.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

Library           DateTime

Test Teardown     Close Browser
	
*** Test Cases ***
Valid open
    Open Browser To Home Page                          # SouthWest Airlines Home page is opened
	Input OriginAirport    PDX                         # Depart Airport is given as Portland
	Input DestinationAirport    EWR                    # Arrival Airport is given as Newyork
          # departuredate is taken as 3 weeks from current date		  
	${departureDate} =	Get Current Date               
	${departureDate} =	Add Time To Date	${departureDate}	21 days
	${departureDateStr} =	Convert Date	${departureDate}	result_format=%m/%d
	
	      # Arrival date is given after 4 days from departuredate
	${arrivalDate} =	Add Time To Date	${departureDate}	4 days
	${arrivalDateStr} =	Convert Date	${arrivalDate}	result_format=%m/%d
	
	Input DepartureDate    ${departureDateStr}
	Input ReturnDate    ${arrivalDateStr}
	
	      # Displays the web page with Outbound and Inbound flight details
	Search Flights
	
	      # Validates the test result by fetching the first row of Outbound flight 
	${firstOutBound}=    Get Matching XPath Count    //tr[@id='outbound_flightRow_1']
	Should Be Equal    ${firstOutBound}    1
	
	      # Validates the test result by fetching the first row of Inbound flight
	${firstInBound}=    Get Matching XPath Count    //tr[@id='inbound_flightRow_1']
	Should Be Equal    ${firstInBound}    1
	
	      # Close Southwest Airlines Browser
	[Teardown]    Close Browser
	
