local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()


local function easyLevel()
   composer.gotoScene( "easy", { time=800, effect="crossFade" } )
end

local function difficultLevel()
    composer.gotoScene( "difficult", { time=800, effect="crossFade" } )
 end

 local function aboutGame()
    native.showAlert( "Spike Survivor Game","Avoid the falling red vermin,pick as many stars to score", { "OK", "Learn More" }, onComplete)
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
   spike.x = display.contentCenterX - 100
   spike.y = 260
   local spike = display.newImageRect( sceneGroup,"image/red_vermin.png",100,100)
   spike.x = display.contentCenterX + 90
   spike.y = 290
   local spike = display.newImageRect( sceneGroup,"image/red_vermin.png",100,100)
   spike.x = display.contentCenterX
   spike.y = 310
  


   -- Create the widgets
local about = widget.newButton(
    {
        label = "ABOUT",
        --onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 80,
        height = 70,
        cornerRadius = 10,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        --fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        --strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
about.x = display.contentCenterX - 100
about.y = 410

local easy = widget.newButton(
    {
        label = "EASY",
        --onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 80,
        height = 70,
        cornerRadius = 10,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
easy.x = display.contentCenterX
easy.y = 410

local difficult = widget.newButton(
    {
        label = "DIFFICULT",
        --onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 80,
        height = 70,
        cornerRadius = 10,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
difficult.x = display.contentCenterX + 100
difficult.y = 410

   about:addEventListener("tap",aboutGame)
   easy:addEventListener("tap",easyLevel)
   difficult:addEventListener("tap",difficultLevel)

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