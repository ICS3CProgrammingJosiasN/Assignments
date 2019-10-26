	-- Title: NumericTextFields
-- Name: Josias
-- Course: ICS3C
-- This program displays a math question and asks the user to answer in a numeric textfield 
-- terminal if the user gets the answer right it say correct! and ask the user another question 
-- if not it says incorrect! and asks the user another question 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 124/255, 249/255, 199/255)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- create local variables 
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local randomNumber3
local randomNumber4
local tempRandomNumber
local userAnswer
local correctAnswer
local correctAnswer1
local points = 0
local randomOperator
local gameOver
local youWin

-- Create variables for Sounds
local correctSound = audio.loadSound( "Sounds/correct.mp3" )
local correctSoundChannel
local wrongSound = audio.loadSound( "Sounds/incorrect.mp3" )
local wrongSoundChannel
local gameOverSound = audio.loadSound( "Sounds/gameover.mp3")
local gameOverSoundChannel
local youWinSound = audio.loadSound( "Sounds/youWin.mp3")
local youWinSoundChannel 

-- variables for the timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2
local heart3

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- LOCAL FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number
	randomOperator = math.random(1, 5)
	randomNumber1 = math.random(1, 10)
	randomNumber2 = math.random(1, 10)
	

	if (randomOperator == 1) then 
		-- calculate the correct answer 
		correctAnswer = randomNumber1 + randomNumber2

		questionObject.text = randomNumber1 .. "+".. randomNumber2 .."="

  	elseif (randomOperator == 2) then 

    	if (randomNumber1 < randomNumber2)then
    		tempRandomNumber = randomNumber1
    		randomNumber1 = randomNumber2
    		randomNumber2 = tempRandomNumber
    	end	
    	
    	correctAnswer = randomNumber1 - randomNumber2

    	questionObject.text = randomNumber1 .. "-".. randomNumber2 .."="

  	elseif (randomOperator == 3) then
    	correctAnswer = randomNumber1 * randomNumber2 
    	
    	questionObject.text = randomNumber1 .. "*".. randomNumber2 .."="

 	elseif (randomOperator == 4) then
    	correctAnswer1 = randomNumber1 * randomNumber2
   	 	correctAnswer = correctAnswer1 / randomNumber1
    	questionObject.text = correctAnswer1 .."/" .. randomNumber1 .. "="

    elseif (randomOperator == 5) then
    	correctAnswer = randomNumber1 * randomNumber1
   	 	
    	questionObject.text = randomNumber1 .."²" .. "="	

  	end	

end	

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function Hideincorrect()
    incorrectObject.isVisible = false
    AskQuestion()
end    

local function NumericFieldListener( event )

     -- User begins editing "numericfield"
    if ( event.phase == "began" ) then 

      	--clear the text field 
      	event.target.text = ""

    elseif (event.phase == "submitted") then 

      	-- when the answer is sumbmitted (enter key is pressed) set the user input to user's answer
      	userAnswer = tonumber(event.target.text)
      	print ("*****testing")

      	--if the users answer and the correct answer are the same :
      	if (userAnswer == correctAnswer) then
         	
        	secondsLeft = totalSeconds
        	correctObject.isVisible = true

        	correctSoundChannel = audio.play(correctSound)
        	timer.performWithDelay(2000, HideCorrect)
            
        	-- give a point if user gets the correct answer
        	points = points + 1

        	-- update it in the display object
        	pointsText.text = "Points = " .. points 
        	-- clear Text 
        	event.target.text = ""

       		if ( points == 5 ) then 
      			youWin = display.newImageRect("Images/you win.png", 1304, 769)
      			youWin.x = display.contentCenterX
      			youWin.y = display.contentCenterY
      			numericField.isVisible = false 
      			clockText.isVisible = false
      			youWinSoundChannel = audio.play(youWinSound)
      			heart1.isVisible = false 
      			heart2.isVisible = false
      			heart3.isVisible = false 
      			pointsText.isVisible = false
      			questionObject.isVisible = false 
    		end



     	else
        	lives = lives - 1
        	secondsLeft = totalSeconds
        	print ("*****testing")
        	incorrectObject.isVisible = true 

        	wrongSoundChannel = audio.play(wrongSound)

        	timer.performWithDelay(2000, Hideincorrect)

        	if (lives == 2) then
          		heart3.isVisible = false
             
        	elseif (lives == 1) then
				heart2.isVisible = false

			elseif (lives == 0) then
				heart1.isVisible = false
	 		end

		

        	if ( lives == 0 ) then 
        		gameOver = display.newImageRect("Images/game over transparent.png", 1304, 769)
        		gameOver.x = display.contentCenterX
        		gameOver.y = display.contentCenterY
        		numericField.isVisible = false 
        		clockText.isVisible = false

        		gameOverSoundChannel = audio.play(gameOverSound)
        	end 	


         	-- clear text 
         	event.target.text = ""


        end

    end
     
end

local function UpdateTime()
	-- decrement the number of sceonds 
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object 
	clockText.text = secondsLeft .. " "

	if (secondsLeft == 0 ) then 
		-- reset the number of seconds left 
		secondsLeft = totalSeconds
		lives = lives - 1
		wrongSoundChannel = audio.play(wrongSound)

		if (lives == 0 ) then 
			timer.cancel(countDownTimer)
			gameOver = display.newImageRect("Images/game over transparent.png", 1304, 769)
			gameOver.x = display.contentCenterX
			gameOver.y = display.contentCenterY
			numericField.isVisible = false 

			incorrectObject.isVisible = false 
			correctObject.isVisible = false 
            questionObject.isVisible = false 
            numericField.inputType = false 
            countDownTimer.isVisible = false
            clockText.isVisible = false
        end    

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, AND SHOW A YOU LOSE IMAGE
		-- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
		if (lives == 3) then
			heart4.isVisible = false

		elseif (lives == 2) then
			heart3.isVisible = false

		elseif (lives == 1) then 
			heart2.isVisible = false

		elseif (lives == 0) then 
			heart1.isVisible = false	 
		end 
		AskQuestion()
		
		-- *** CALL THE FUNCTION TO ASK A NEW QUESTION
	end
end

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinitely 
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end	





-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--OBJECT CREATION
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(155/255, 42/255, 198/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject.isVisible = false

-- Create the incorrect text object and make it visible
incorrectObject = display.newText( "incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject.isVisible = false

-- Create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "default"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener)

-- display the amount of points as text object
pointsText = display.newText("Points = " .. points, display.contentWidth/3, display.contentHeight/3, nil,50)

-- create the lives to display ont the screen 
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth  * 7/8
heart1.y = display.contentHeight * 1/7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6/8
heart2.y = display.contentHeight * 1/7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 3.5/5.5
heart3.y = display.contentHeight * 1/7

clockText = display.newText("Time Left= " .. secondsLeft, display.contentWidth*1/8, display.contentHeight*1/7, nil, 50)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION CALLS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()

-- call the function to start the timer 
StartTimer()        