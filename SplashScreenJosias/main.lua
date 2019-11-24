-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local companyLogo1
local companyLogo2
local scrollXSpeed1 = 5
local scrollYSpeed1 = -3
local scrollXSpeed2 = 5 
local scrollYSpeed2 = 3


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- This function moves the company logo across the screen
local function movecompanyLogo1()
	print(companyLogo1.x)
    companyLogo1.x = companyLogo1.x + scrollXSpeed1
    companyLogo1.y = companyLogo1.y + scrollYSpeed1 

if ( companyLogo1.x == 510 ) then 
	scrollYSpeed1 = 0
	scrollXSpeed1 = 0
end



end


-- This function moves the company logo across the screen
local function movecompanyLogo2()
	print(companyLogo2.x)
    companyLogo2.x = companyLogo2.x + scrollXSpeed2
    companyLogo2.y = companyLogo2.y + scrollYSpeed2

if ( companyLogo2.x == 510/1 ) then 
	scrollYSpeed2 = 0
	scrollXSpeed2 = 0
end



end

---------------------------------------------------------------------------------------------
--CREATING IMAGES 
---------------------------------------------------------------------------------------------

-- Addind company logo to the screen and placing it
companyLogo1 = display.newImageRect("Images/CompanyLogoJosias@2x.png", 200, 200)
companyLogo1.x = 0
companyLogo1.y = 600

-- change the size of th ecompany logo 
companyLogo1.xScale = 2
companyLogo1.yScale = 2

-- Addind company logo to the screen and placing it
companyLogo2 = display.newImageRect("Images/CompanyLogoJosias@2x.png", 200, 200)
companyLogo2.x = 0
companyLogo2.y = 0

-- change the size of th ecompany logo 
companyLogo2.xScale = 2
companyLogo2.yScale = 2

-- set the background colour 
display.setDefault("background", 250, 250, 250)

----------------------------------------------------------------------------------------------
--EVENT LISTENERS
-----------------------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", movecompanyLogo1)
Runtime:addEventListener("enterFrame", movecompanyLogo2)

