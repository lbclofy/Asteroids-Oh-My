local composer = require( "composer" )
local shipBuilder = require( "spaceship" )
local wall = require( "wall" )
local physics = require( "physics" )
physics.start()


local scene = composer.newScene()
physics.start()
physics.setDrawMode("hybrid")
physics.setGravity( 0, 0 )


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------

local cashText
local totalCash = 0

local function startTouch( event )
    display.remove(event.target.text)
    event.target.text = nil
    display.remove(event.target)
    event.target = nil
    physics.start()

    return true
end


-- "scene:create()"
function scene:create( event )
    
    local sceneGroup = self.view
    physics.pause()

    local startBtn = display.newRect( centerX, centerY, 300, 200 )
    startBtn:setFillColor( 1, 1, 1, .5 )
    startBtn.text = display.newText("Play", centerX, centerY, native.systemFont, 64)
    startBtn.text:setFillColor( 0, 0, 0 )
    local cashString = string.format( "$%d", totalCash )
    cashText = display.newText(cashString, 600, 50, native.systemFont, 64)

    startBtn:addEventListener( "touch", startTouch )

    shipBuilder.new(sceneGroup, centerX, centerY, {density = .1} )

    wall.new( sceneGroup, 400, bounds.top-5, 810, 0010, { name = "top"  } ) 
    wall.new( sceneGroup, 400, bounds.bottom+5, 810, 0010, { name = "bottom"  } ) 
    wall.new( sceneGroup, bounds.left-5, 0600, 010, 1200, { name = "left"  } ) 
    wall.new( sceneGroup, bounds.right+5, 0600, 010, 1200, { name = "right"  } ) 

    
end



-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    --composer.removeAll()

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene