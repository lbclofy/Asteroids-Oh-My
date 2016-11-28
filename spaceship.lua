local spaceShip = {}

local composer = require( "composer" )
local physics = require( "physics" )

local shipCollisionFilter = { categoryBits = 1, maskBits = 4 }
local bulletCollisionFilter = { categoryBits = 2, maskBits = 4 }

local ship
local bulletForce = 20


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

end

local function onPostCollision( self, event )-- = function
  self:hit()
end

local function angleBetween(x1,y1,x2,y2)
  return math.rad( math.ceil(math.atan2((y2-y1),(x2-x1))*180*math.pi^-1)+90 ) 
end

local function shoot( event )
  print(event.x)
  local bullet = display.newRect( ship.x, ship.y, 5, 5 )
  physics.addBody( bullet, "dynamic", { bounce=1, density = 1, friction=0.3, filter = bulletCollisionFilter } )
  local direction = angleBetween( ship.x, ship.y, event.x, event.y )
  bullet:applyForce( math.sin(direction)*bulletForce, -math.cos(direction)*bulletForce, bullet.x, bullet.y )
  ship:applyForce( -math.sin(direction)*bulletForce, math.cos(direction)*bulletForce, ship.x, ship.y )

  

end



-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function spaceShip.new( group, x, y, params  )	-- constructor
	  group  = group or display.newStage()
    params = params or {}

    local theSpaceShip = display.newRect( 0, 0, 50,50 )
    ship = theSpaceShip
   	theSpaceShip.x = x or 0
   	theSpaceShip.y = y or 0

    theSpaceShip.name = params.name or "unnamed"

    theSpaceShip.data = {}
    theSpaceShip.data.lives = lives or 3
    
    local shipDensity = .5 or params.density
	  physics.addBody( theSpaceShip, "dynamic", { bounce=1, density = 1, friction=0.3, filter = shipCollisionFilter } )

	  theSpaceShip.postCollision = onPostCollision
    theSpaceShip:addEventListener( "postCollision" )

    local playArea = display.newRect( group, centerX, centerY, 800, 1000 )
    playArea:setFillColor(1,1,1,.1)
    playArea:setStrokeColor(1,0,0)
    playArea.strokeWidth = 5
    playArea:addEventListener( "tap", shoot )

    -- Attach additional functions
    theSpaceShip.hit      = onHit
	
	return theSpaceShip
end


return spaceShip