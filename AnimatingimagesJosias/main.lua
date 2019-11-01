-- Title: AnimatingImages
-- Name: Josias.N 
-- Course: ICS3C
-- This program moves a Astronaut across the screen and then makes it fade out.

-- hide the status bar 
display.setStatusBar(display.HiddenStatusBar)

------------------------------------------------creation Images and variables----------------------------------------------
scrollSpeed = 3

-- background image with the width and height 
local backgroundImage = display.newImageRect("Images/spacebackground.png", 2048, 1536)

-- character image with width and height 
local Astronaut = display.newImageRect("Images/Astronaut.png", 200, 200)

-- character image with width and height
local Astronaut2 = display.newImageRect("Images/Astronaut2.png", 200, 200)

local Spaceship = display.newImageRect("Images/Spaceship.png", 200, 200)

-- set the initial x and y position of the Astronaut
Astronaut.x = 0
Astronaut.y = display.contentHeight/3

-- set the initial x and y position of the Astronaut2
Astronaut2.x = 1000
Astronaut2.y = display.contentHeight/1.5

-- make it face the opposite direction
Astronaut2:scale(-1,1)

-- set initial x and y position of the spaceship
Spaceship.x = 0
Spaceship.y = display.contentHeight/1.2

-----------------------------------------------------------Functions----------------------------------------------------------

-- Function: Moveship
-- Input: this function accepts an event listener
-- Output: none
-- Description:  This fuction adds the scroll speed to the x-value of the ship
local function MoveAstronaut(event)

    -- add the scroll speed to the x-value of the ship
    Astronaut.x = Astronaut.x + scrollSpeed
    -- change the tansparency of the ship every time it moves so that it fades out 
    Astronaut.alpha = Astronaut.alpha + 0.01

    Astronaut:scale( 1.002, 1.002) 
end 


-- Function: Moverocketship
-- Input: this function accepts an event listener
-- Output: none
-- Description:  This fuction adds the scroll speed to the x-value of the ship
local function MoveAstronaut2(event)
	-- add the scroll speed to the x-value of the ship
	Astronaut2.x = Astronaut2.x - scrollSpeed
	-- change the transparency of the ship every time it moves so that it fades out 
	Astronaut2.alpha = Astronaut2.alpha + 0.01
end	

local function MoveSpaceship(event)
	-- add the scroll speed to the x-value of the ship
	Spaceship.x = Spaceship.x + scrollSpeed
	-- add the scroll speed speed to the y-value of ship
	Spaceship.y = Spaceship.y - scrollSpeed 
	-- change the transparency of the ship every time it moves so that it fades out 
	Spaceship.alpha = Spaceship.alpha + 0.01
end	

----------------------------------Event Listener-----------------------------------------------------------------------

-- movespaceship will be able over and over again
Runtime:addEventListener("enterFrame", MoveSpaceship)

-- MoveShip will be able over and over again
Runtime:addEventListener("enterFrame", MoveAstronaut)

-- MoveRocketShip will be able over and over again
Runtime:addEventListener("enterFrame", MoveAstronaut2)