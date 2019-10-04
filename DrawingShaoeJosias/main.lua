-- Title: Drawing shapes
-- Name: Josias
-- Course: ICS2O/3C
-- This program Displays shapes 
-- hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- set the background colourof my screen. 
display.setDefault("background", 28/255, 121/255, 243/255)

local quadilateral = display.newPolygon( 192, 256, {0,-60, 60,0, 0,60,-60,0} )
quadilateral.strokeWidth = 20


-- created parallelogram

local parallelogram = display.newPolygon( 768, 256, {80,-20, 0,60, -120,60, -40,-20} )

-- created triangle
local triangle = display.newPolygon( 450, 256, {0,-80, 80,0, -80,0} )

-- created octagon 
local octagon = display.newPolygon (192, 576, {40,-120, 80,-80, 80,-40, 40,0, -40,0, -80,-40, -80,-80, -40,-120} )

-- created irregular quadilateral
local irregular quadilateral = display.newPolygon(450, 576, {60,-60, 0,80, -60,-60, 0,0} )

-- created hexagon
local hexagon = display.newPolygon(768, 576, {40,-120, 80,-60, 40,0 -40,0 -80,-60, -40,-120} )