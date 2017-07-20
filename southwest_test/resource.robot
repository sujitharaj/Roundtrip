*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library           DateTime			

*** Variables ***
${BROWSER}        Chrome
${DELAY}          0
${HOME URL}      https://www.southwest.com/
${HOME TITLE}   Southwest Airlines | Book Flights, Airline Tickets, Airfare

*** Keywords ***
Open Browser To Home Page
    Open Browser    ${HOME URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Location Should Be    ${HOME URL}
	Title Should Be    ${HOME TITLE}
	
Check Radio button
	Page Should Contain Radio Button	trip-type-round-trip

 Input OriginAirport
    [Arguments]    ${origin}
    Input Text    air-city-departure    ${origin}
	
	
Input DestinationAirport
    [Arguments]    ${destination}
    Input Text    air-city-arrival    ${destination}

	
Input DepartureDate
    [Arguments]    ${departureDate}
    Input Text    air-date-departure    ${departureDate}
	
	
Input ReturnDate
    [Arguments]    ${ReturnDate}
    Input Text    air-date-return    ${ReturnDate}
	
Input AdultCount
	[Arguments]    ${adultCount}
    Input Text    air-pax-count-adults    ${adultCount}
	
Search Flights
    Click Button 	jb-booking-form-submit-button