local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()


local function gameLevels()
    composer.gotoScene( "gamelevels" )
end 



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

   local sceneGroup = self.view
   -- Code here runs when the scene is first created but has not yet appeared on screen
   local background = display.newImageRect( sceneGroup, "image/spaceblack.png", 440, 600 )
   background.x = display.contentCenterX
   background.y = display.contentCenterY

   local gameImage = display.newImageRect( sceneGroup,"image/smile1.png",270,270)
   gameImage.x = display.contentCenterX
   gameImage.y = 150
   gameImage.rotation = 40

   local gameTitle = display.newText( sceneGroup,"Spike Survivor", 100, 300, native.systemFont, 46 )
   gameTitle:setFillColor( 0, 0, 1 )
   gameTitle.x = display.contentCenterX
   gameTitle.y = 70

   local spike = display.newImageRect( sceneGroup,"image/red_vermin.png",100,100)
   spike.x = display.contentCenterX - 120
   spike.y = 270
   local spike = display.newImageRect( sceneGroup,"image/red_vermin.png",100,100)
   spike.x = display.contentCenterX + 120
   spike.y = 320
   local spike = display.newImageRect( sceneGroup,"image/red_vermin.png",100,100)
   spike.x = display.contentCenterX
   spike.y = 350
  

   -- Create the widget
local level = widget.newButton(
    {
        label = "GAME LEVELS",
        --onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 190,
        height = 40,
        cornerRadius = 20,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 2
    }
)
level.x = display.contentCenterX
level.y = 390



level:addEventListener( "tap", gameLevels)  

end--end of create scene

-- destroy()
function scene:destroy( event )
    
       local sceneGroup = self.view
       -- Code here runs prior to the removal of scene's view
       
   end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene