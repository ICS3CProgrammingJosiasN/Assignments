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
local companyLogo
local scrollXSpeed = 5
local scrollYSpeed = -3


--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- This function moves the company logo across the screen
local function movecompanyLogo()
	print(companyLogo.x)
    companyLogo.x = companyLogo.x + scrollXSpeed
    companyLogo.y = companyLogo.y + scrollYSpeed 

if ( companyLogo.x == 510 ) then 
	scrollYSpeed = 0
	scrollXSpeed = 0
end



end

---------------------------------------------------------------------------------------------
--CREATING IMAGES 
---------------------------------------------------------------------------------------------

-- Addind company logo to the screen and placing it
companyLogo = display.newImageRect("Images/CompanyLogoJosias@2x.png", 200, 200)
companyLogo.x = 0
companyLogo.y = 600

-- change the size of th ecompany logo 
companyLogo.xScale = 2
companyLogo.yScale = 2

-- set the background colour 
display.setDefault("background", 250, 250, 250)

----------------------------------------------------------------------------------------------
--EVENT LISTENERS
-----------------------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", movecompanyLogo)

