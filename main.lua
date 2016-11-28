local composer = require( "composer" )
composer.recycleOnSceneChange = true
local performance = require('performance')
performance:newPerformanceMeter()

display.setStatusBar( display.HiddenStatusBar )

_G._W = display.contentWidth
_G._H = display.contentHeight
_G.centerX = _W*.5
_G.centerY = _H*.5


_G.ballR = 25
_G.phi = 1.61803398875
_G.mF = math.floor

_G.maxSpeed  = _W
_G.forceFactor = _W*.4

_G.bounds = {left = 0, right = 800, top = 100, bottom = 1100}



--Colors    { R = ,   G = ,     B = }
_G.Red =      { R = 244/255,  G = 067/255,  B = 054/255 }
_G.Red100 =   { R = 255/255,  G = 205/255,  B = 210/255 }
_G.Red300 =   { R = 229/255,  G = 115/255,  B = 115/255 }
_G.Red700 =   { R = 211/255,  G = 047/255,  B = 047/255 }
_G.Yellow =   { R = 225/255,  G = 196/255,  B = 000/255 }
_G.Green =    { R = 076/255,  G = 175/255,  B = 080/255 }
_G.Blue =     { R = 000/255,  G = 191/255,  B = 165/255 }--{ R = 033/255,  G = 150/255,  B = 243/255 }
_G.Blue100 =  { R = 187/255,  G = 222/255,  B = 251/255 }
_G.Blue300 =  { R = 100/255,  G = 181/255,  B = 246/255 }
_G.Blue700 =  { R = 025/255,  G = 118/255,  B = 210/255 }
_G.Purple =   { R = 156/255,  G = 039/255,  B = 176/255 }
_G.BlueGrey = { R = 096/255,  G = 125/255,  B = 139/255 }
_G.Black =    { R = 000/255,  G = 000/255,  B = 000/255 }
_G.White =    { R = 255/255,  G = 255/255,  B = 255/255 }
_G.hlColor =  { R = 244/255,  G = 067/255,  B = 054/255 }
_G.priColor = { R = Yellow.R, G = Yellow.G, B = Yellow.B}
_G.secColor = { R =  Blue.R,  G = Blue.G,   B = Blue.B  }

_G.outlineColor = { highlight = { r= 0, g=0, b=0 }, shadow = { r=0, g=0, b=0 } }


_G.bg = display.newRect(centerX, centerY, _W, _H)
bg:setFillColor(1,1,1,.01)

transition.callback = transition.to ;

function transition.fromtocolor(obj, colorFrom, colorTo, time, delay, ease)

        local _obj =  obj ;
        local ease = ease or easing.linear


        local fcolor = colorFrom or {255,255,255} ; -- defaults to white
        local tcolor = colorTo or {0,0,0} ; -- defaults to black
        local t = nil ;
        local p = {} --hold parameters here
        local rDiff = tcolor[1] - fcolor[1] ; --Calculate difference between values
        local gDiff = tcolor[2] - fcolor[2] ;
        local bDiff = tcolor[3] - fcolor[3] ;

                --Set up proxy
        local proxy = {step = 0} ;

    local mt

    if( obj and obj.setTextColor ) then
      mt = {
          __index = function(t,k)
              --print("get") ;
              return t["step"]
          end,

          __newindex = function (t,k,v)
              --print("set")
              --print(t,k,v)
              if(_obj.setTextColor) then
                  _obj:setTextColor(fcolor[1] + (v*rDiff) ,fcolor[2] + (v*gDiff) ,fcolor[3] + (v*bDiff) )
              end
              t["step"] = v ;


          end

      }
    else
       mt = {
          __index = function(t,k)
              --print("get") ;
              return t["step"]
          end,

          __newindex = function (t,k,v)
              --print("set")
              --print(t,k,v)
              if(_obj.setFillColor) then
                  _obj:setFillColor(fcolor[1] + (v*rDiff) ,fcolor[2] + (v*gDiff) ,fcolor[3] + (v*bDiff) )
              end
              t["step"] = v ;


          end

      }
    end

        p.time = time or 1000 ; --defaults to 1 second
        p.delay = delay or 0 ;
        p.transition = ease ;


        setmetatable(proxy,mt) ;

        p.colorScale = 1 ;

        t = transition.to(proxy,p , 1 )  ;

        return t

end

transition.callback = transition.to ;

function transition.matTrans(obj, xt, yt, time, delay )

  local delay = delay or 0

  local function endMove ( obj )
    transition.to( obj, { time=250, xScale = 1.0, yScale = 1.0 } )
  end

  local function move ( obj )
    transition.to( obj, {x = xt, y = yt, onComplete = endMove, easing = easing.inOutCubic, time = time } )
  end

  transition.to( obj, { time=250, xScale = 1.1, yScale = 1.1, onComplete=move } )



end
--[[
local play_area = display.newRect( centerX, centerY, 800, 1200 )
play_area:setFillColor( 1, 1, 1, .1 )
play_area:setStrokeColor( 1, 0, 0 )
play_area.strokeWidth = 2
]]

composer.gotoScene( "game" )
