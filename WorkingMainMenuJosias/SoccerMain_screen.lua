-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "SoccerMain_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local SoccerInstructionButton
local PlayButton
local BackButton
local soccerSound = audio.loadStream( "Sounds/soccerSound.mp3")
local soccerSoundChannel = audio.play( soccerSound, { channel=1, loops=-1} )


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function PlayTransition( )       
    composer.gotoScene( "Soccerlevel3_screen", {effect = "flipFadeOutIn", time = 500})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Soccer Screen
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomInOutFade", time = 1000})

end    

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO Baking SCREEN 

local function SoccerInstructionTransition()
    composer.gotoScene( "SoccerInstruction_screen", {effect = "flipFadeOutIn", time = 500})
end     

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenuLogan@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    BackButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*7/9,
            y = display.contentHeight*7/9,
            -- sets the size of the button 
            width = 250,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/BackbuttonUnpressedJosias@2x.png",
            overFile = "Images/BackButtonPressedJosias@2x.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = BackTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    PlayButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*4.5/9,
            y = display.contentHeight*4.5/9,
            -- sets the size of the button 
            width = 250,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressed@2x.png",
            overFile = "Images/PlayButtonPressed@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = PlayTransition
        } ) 
    
    -- ADD INSTRUCTIONS BUTTON WIDGET

    -----------------------------------------------------------------------------------------

    -- Creating Instructions Button
    SoccerInstructionButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*2/7,
            y = display.contentHeight*2/7,
            -- sets the size of the button 
            width = 250,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = SoccerInstructionTransition
        } ) 
    
    -- ADD INSTRUCTIONS BUTTON WIDGET

    -----------------------------------------------------------------------------------------
    -- Associating button widgets with this scene
    sceneGroup:insert( PlayButton )
    sceneGroup:insert( BackButton )
    sceneGroup:insert( SoccerInstructionButton)
    
    -- INSERT INSTRUCTIONS BUTTON INTO SCENE GROUP

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).   
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then 
        -- plays the soccer sound 
        soccerSoundChannel = audio.play(soccerSound)      
        

    end

end  
function 
    scene:show( event )
end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        -- stop the soccer sound 
        soccerSound = audio.stop()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene