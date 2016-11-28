local wall = {}

local composer = require( "composer" )
local physics = require( "physics" )

local wallCollisionFilter = { categoryBits = 4, maskBits = 3 }


-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------

local function endGame()	-- local; only visible in this module
	local options = {
    isModal = true,
    effect = "fade",
    time = 400,
    params = {
        sampleVar = "my sample variable"
    	}
	}
    
    composer.gotoScene( "gameOver", options)
end

local function onHit( self )
    if self.data.name == "bottom" then
    	endGame()
    end
end

local function moveTo(obj, x, y)
    obj.x = x
    obj.y = y
end

local function onCollision( self, event ) 
  print("COLLIDING")

  if event.target.name == "bottom" then
    timer.performWithDelay( 1, function() return moveTo(event.other, event.other.x, bounds.top+5) end )
  elseif event.target.name == "top" then
    timer.performWithDelay( 1, function() return moveTo(event.other, event.other.x, bounds.bottom-5 ) end )
  elseif event.target.name == "left" then
    timer.performWithDelay( 1, function() return moveTo(event.other, bounds.right-5, event.other.y ) end )
  elseif event.target.name == "right" then
    timer.performWithDelay( 1, function() return moveTo(event.other, bounds.left+5, event.other.y ) end )
  end

  print(event.target.name)
end



-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function wall.new( group, x, y, width, height, params  )	-- constructor
	group  = group or display.newStage()
    params = params or {}

    local theWall = display.newRect( 0, 0, width, height )
   	theWall.x = x or 0
   	theWall.y = y or 0
    theWall.name  = params.name or "unnamed"
    print(params.name)

    theWall.data = {}
  

	  physics.addBody( theWall, "static", { bounce=1, filter = wallCollisionFilter } )
    theWall.isSensor = true

	  theWall.collision = onCollision
    theWall:addEventListener( "collision" )

    -- Attach additional functions
    theWall.rollOver = onRollover
    theWall.hit      = onHit
	
	return theWall
end

-- Single 'postCollision' function used by All bricks (only defined ONCE)

--[[
-- Single 'hit' function used by all bricks (only defined ONCE)
onHit = function( self )
    print(self.data.name)
    if self.data.name == "bottom" then
    	endGame()
    end
end
]]

return wall