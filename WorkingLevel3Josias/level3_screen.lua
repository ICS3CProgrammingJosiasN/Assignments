-----------------------------------------------------------------------------------------
--
-- game_level1.lua
-- Created by: Daniel
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------


-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level3_screen"

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- sounds
local soccerSound = audio.loadSound( "Sounds/soccerSound.mp3")
local soccerSoundChannel
local correctSound = audio.loadSound( "Sounds/correctSound.mp3")
local correctSoundChannel
local wrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local wrongSoundChannel

-- hearts 
local lives = 4 
local heart1 
local heart2 
local heart3 
local heart4 

-- The background image and soccer ball for this scene
local bkg_image
local soccerball

--the text that displays the question
local questionText 
local correctObject
local incorrectObject
--the alternate numbers randomly generated
local correctAnswer
local alternateAnswer1
local alternateAnswer2    

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box was touched
local answerboxAlreadyTouched = false
local alternateAnswerBox1AlreadyTouched = false
local alternateAnswerBox2AlreadyTouched = false

--create textboxes holding answer and alternate answers 
local answerbox
local alternateAnswerBox1
local alternateAnswerBox2

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
local answerboxPreviousY
local alternateAnswerBox1PreviousY
local alternateAnswerBox2PreviousY

local answerboxPreviousX
local alternateAnswerBox1PreviousX
local alternateAnswerBox2PreviousX

-- the black box where the user will drag the answer
local userAnswerBoxPlaceholder

-- sound effects
local correctSound
local booSound
local points = 0


-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function BackTransition()
    composer.gotoScene( "main_menu", {effect = "flipFadeOutIn", time = 500})
end 

local function DisplayQuestion()
    local randomOperator 
    local randomNumber1
    local randomNumber2
    local tempRandomNumber

    --set random numbers
    randomNumber1 = math.random(2, 15)
    randomNumber2 = math.random(2, 15)
    randomOperator = math.random(1, 2)

    if (randomOperator == 1) then
       

        --calculate answer
        correctAnswer = randomNumber1 + randomNumber2

        --change question text in relation to answer
        questionText.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 

        -- put the correct answer into the answerbox
        answerbox.text = correctAnswer

        -- make it possible to click on the answers again
        answerboxAlreadyTouched = false
        alternateAnswerBox1AlreadyTouched = false
        alternateAnswerBox2AlreadyTouched = false
    elseif (randomOperator == 2) then

        if (randomNumber1 < randomNumber2)then
            tempRandomNumber = randomNumber1
            randomNumber1 = randomNumber2
            randomNumber2 = tempRandomNumber
        end          
    
        -- calculate answer 
        correctAnswer = randomNumber1 - randomNumber2

        -- change the question text in relation to answer 
        questionText.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

        -- put the correct answer intio the answerbox
        answerbox.text = correctAnswer

        -- make it possible to click on the answers again
        answerboxAlreadyTouched = false
        alternateAnswerBox1AlreadyTouched = false
        alternateAnswerBox2AlreadyTouched = false        
    end 

end

local function HideCorrect()
    correctObject.isVisible = false
    DisplayQuestion()
end

local function Hideincorrect()
    incorrectObject.isVisible = false
    DisplayQuestion()
end    

local function DetermineAlternateAnswers()    

        
    -- generate incorrect answer and set it in the textbox
    alternateAnswer1 = correctAnswer + math.random(3, 5)
    alternateAnswerBox1.text = alternateAnswer1

    -- generate incorrect answer and set it in the textbox
    alternateAnswer2 = correctAnswer - math.random(1, 2)
    alternateAnswerBox2.text = alternateAnswer2

-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    answerbox.x = display.contentWidth * 0.9
    alternateAnswerBox1.x = display.contentWidth * 0.9
    alternateAnswerBox2.x = display.contentWidth * 0.9


end

local function PositionAnswers()
    local randomPosition

    -------------------------------------------------------------------------------------------
    --ROMDOMLY SELECT ANSWER BOX POSITIONS
    -----------------------------------------------------------------------------------------
    randomPosition = math.random(1,3)

    -- random position 1
    if (randomPosition == 1) then
        -- set the new y-positions of each of the answers
        answerbox.y = display.contentHeight * 0.4

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.70

        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.55

        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        answerboxPreviousY = answerbox.y 

    -- random position 2
    elseif (randomPosition == 2) then

        answerbox.y = display.contentHeight * 0.55
        
        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.4

        --alternateAnswerBox1AlreadyTouched
        alternateAnswerBox1.y = display.contentHeight * 0.7

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        answerboxPreviousY = answerbox.y 

    -- random position 3
     elseif (randomPosition == 3) then
        answerbox.y = display.contentHeight * 0.70

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.55

        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.4

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        answerboxPreviousY = answerbox.y 
    end
end


-- Function to Restart Level 1
local function RestartLevel3()
    DisplayQuestion()
    DetermineAlternateAnswers()
    PositionAnswers()    
end

-- Function to Check User Input
local function CheckUserAnswerInput()

    if (userAnswer == correctAnswer)then
        correctObject.isVisible = true

        correctSoundChannel = audio.play(correctSound)
        timer.performWithDelay(2000, HideCorrect)

        points = points + 1

            -- update it in the display object
            pointsText.text = "Points = " .. points 

        if ( points == 5 ) then 
            youWin = display.newImageRect("Images/Winscreen.png", 1304, 769)
            youWin.x = display.contentCenterX
            youWin.y = display.contentCenterY 
            heart1.isVisible = false
            heart2.isVisible = false
            heart3.isvisible = false
            heart4.isvisible = false
            incorrectObject.isVisible = false 
            correctObject.isVisible = false 
            questionText.isVisible = false  
            heart3.isVisible = false 
            heart4.isVisible = false
            correctSoundChannel = audio.play(correctSound)
            timer.performWithDelay(2000, HideCorrect)            
        end      
    else
        lives = lives - 1
        secondsLeft = totalSeconds
        incorrectObject.isVisible = true 
        wrongSoundChannel = audio.play(wrongSound)
        timer.performWithDelay(2000, Hideincorrect)

        if (lives == 3) then
            heart4.isVisible = false
             
        elseif (lives == 2) then
            heart3.isVisible = false

        elseif (lives == 1) then
            heart2.isVisible = false

        elseif (lives == 0) then 
            heart1.isVisible = false 
        end

        

            if ( lives == 0 ) then 
                gameOver = display.newImageRect("Images/Losescreen.png", 1304, 769)
                gameOver.x = display.contentCenterX
                gameOver.y = display.contentCenterY
                wrongSoundChannel = audio.play(wrongSound)
                timer.performWithDelay(2000, Hideincorrect)                
            end     


            -- clear text        
    end    
          
    timer.performWithDelay(1600, RestartLevel3) 
    
end

local function TouchListenerAnswerbox(touch)
    --only work if none of the other boxes have been touched
    if (alternateAnswerBox1AlreadyTouched == false) and 
        (alternateAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            answerboxAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            answerbox.x = touch.x
            answerbox.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            answerboxAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < answerbox.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > answerbox.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < answerbox.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > answerbox.y ) ) then

                -- setting the position of the number to be in the center of the box
                answerbox.x = userAnswerBoxPlaceholder.x
                answerbox.y = userAnswerBoxPlaceholder.y
                userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()
                

            --else make box go back to where it was
            else
                answerbox.x = answerboxPreviousX
                answerbox.y = answerboxPreviousY
            end
        end
    end                
end 

local function TouchListenerAnswerBox1(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (alternateAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswerBox1.x = touch.x
            alternateAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox1.y ) ) then

                alternateAnswerBox1.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()
                

            --else make box go back to where it was
            else
                alternateAnswerBox1.x = alternateAnswerBox1PreviousX
                alternateAnswerBox1.y = alternateAnswerBox1PreviousY
            end
        end
    end
end 

local function TouchListenerAnswerBox2(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (alternateAnswerBox1AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox2AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            alternateAnswerBox2.x = touch.x
            alternateAnswerBox2.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox2.y ) ) then

                alternateAnswerBox2.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox2.y = userAnswerBoxPlaceholder.y
                userAnswer = alternateAnswer2

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()
               
 
            --else make box go back to where it was
            else
                alternateAnswerBox2.x = alternateAnswerBox2PreviousX
                alternateAnswerBox2.y = alternateAnswerBox2PreviousY
            end
        end
    end
end 

-- Function that Adds Listeners to each answer box
local function AddAnswerBoxEventListeners()
    answerbox:addEventListener("touch", TouchListenerAnswerbox)
    alternateAnswerBox1:addEventListener("touch", TouchListenerAnswerBox1)
    alternateAnswerBox2:addEventListener("touch", TouchListenerAnswerBox2)
end 

-- Function that Removes Listeners to each answer box
local function RemoveAnswerBoxEventListeners()
    answerbox:removeEventListener("touch", TouchListenerAnswerbox)
    alternateAnswerBox1:removeEventListener("touch", TouchListenerAnswerBox1)
    alternateAnswerBox2:removeEventListener("touch", TouchListenerAnswerBox2)
end



----------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
----------------------------------------------------------------------------------


----------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
----------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ----------------------------------------------------------------------------------
    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*0.5/5,
        y = display.contentHeight*0.5/5,
        -- sets the size of the button
        width = 150,
        height = 75,

        -- Setting Dimensions
        -- width = 1000,
        -- height = 106,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressedJosias@2x.png",
        overFile = "Images/BackButtonPressedJosias@2x.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )
    ----------------------------------------------------------------------------------
    --Inserting backgroud image and lives
    ----------------------------------------------------------------------------------


    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level3ScreenLogan.png", 2048, 1536)
    bkg_image.anchorX = 0
    bkg_image.anchorY = 0
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    --the text that displays the question
    questionText = display.newText( "" , 0, 0, nil, 100)
    questionText.x = display.contentWidth * 0.3
    questionText.y = display.contentHeight * 0.9

    -- create the soccer ball and place it on the scene
    soccerball = display.newImageRect("Images/soccerball.png", 60, 60, 0, 0)
    soccerball.x = display.contentWidth*0.385
    soccerball.y = display.contentHeight * 12/20

    -- create Character 
    character = display.newImageRect("Images/SoccerCharacterLogan@2x.png", 250, 250, 100, 100)
    character.x = display.contentWidth*0.300
    character.y = display.contentHeight * 10/18

    -- boolean variables stating whether or not the answer was touched
    answerboxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2AlreadyTouched = false

    --create answerbox alternate answers and the boxes to show them
    answerbox = display.newText("", display.contentWidth * 0.9, 0, nil, 100)
    alternateAnswerBox1 = display.newText("", display.contentWidth * 0.9, 0, nil, 100)
    alternateAnswerBox2 = display.newText("", display.contentWidth * 0.9, 0, nil, 100)

    -- set the x positions of each of the answer boxes
    answerboxPreviousX = display.contentWidth * 0.9
    alternateAnswerBox1PreviousX = display.contentWidth * 0.9
    alternateAnswerBox2PreviousX = display.contentWidth * 0.9


    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/userAnswerBoxPlaceholder.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.6
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.9
    -- create the lives to display ont the screen 
    heart1 = display.newImageRect("Images/heart.png", 50, 50)
    heart1.x = display.contentWidth  * 7.8/8
    heart1.y = display.contentHeight * 1/7

    heart2 = display.newImageRect("Images/heart.png", 50, 50)
    heart2.x = display.contentWidth * 7.4/8
    heart2.y = display.contentHeight * 1/7

    heart3 = display.newImageRect("Images/heart.png", 50, 50)
    heart3.x = display.contentWidth * 7/8
    heart3.y = display.contentHeight * 1/7

    heart4 = display.newImageRect("Images/heart.png", 50, 50)
    heart4.x = display.contentWidth * 6.6/8
    heart4.y = display.contentHeight * 1/7
    
    correctObject = display.newText( "Correct", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
    correctObject.isVisible = false

    -- Create the incorrect text object and make it visible
    incorrectObject = display.newText( "incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
    incorrectObject.isVisible = false

    -- display the amount of points as text object
    pointsText = display.newText("Points = " .. points, display.contentWidth/3, display.contentHeight/3, nil,50)

    ----------------------------------------------------------------------------------

    sceneGroup:insert( bkg_image ) 
    sceneGroup:insert( questionText ) 
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( answerbox )
    sceneGroup:insert( alternateAnswerBox1 )
    sceneGroup:insert( alternateAnswerBox2 )
    sceneGroup:insert( soccerball )
    sceneGroup:insert( backButton )
    sceneGroup:insert( character )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart4 )
    sceneGroup:insert( pointsText )

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).    

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        RestartLevel3()
        AddAnswerBoxEventListeners() 
        soccerSoundChannel = audio.play(soccerSound)

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        audio.stop()
        RemoveAnswerBoxEventListeners()
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end

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