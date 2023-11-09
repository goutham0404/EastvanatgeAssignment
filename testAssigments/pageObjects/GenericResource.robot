*** Settings ***
Documentation                 my 1st login script to execute
Library                       SeleniumLibrary

*** Variables ***
${mail_id}                        optimyautomationtester@gmail.com
${password}                       yRMhojb7
${url}                            https://automationinterface1.front.staging.optimy.net/en/
${browser_name}                   chrome


*** Keywords ***
open the test browser
	#Create Webdriver    Chrome  executable_path=/Users/gouthambs/Documents/chromedriver-mac-arm64/chromedriver
	#Go To    https://rahulshettyacademy.com/loginpagePractise/
	#=/Users/gouthambs/Downloads/chromedriver_mac64/chromedriver
    Open Browser	${url}	browser=${browser_name}   options=add_experimental_option("detach", True)


close the test browser
	Close Browser

wait until element for laoding page is visible
	[Arguments]                             ${element_name}
	Wait Until Element Is Visible           ${element_name}
