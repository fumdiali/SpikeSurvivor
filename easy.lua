local composer = require( "composer" )
local widget = require( "widget" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    bg = display.newImageRect("image/back.jpeg",440,620)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    --Find device display height and width
    _H = display.contentHeight;
    _W = display.contentWidth

    Random = math.random

    spikesTable = {}

    music = audio.loadSound("sound/music.mp3")
   moveSound = audio.loadSound( "sound/balloonPop.mp3" )

    --score display
    score = 0
    scoreDisplay = display.newText( "score:0", 160, 10, native.systemFont, 30 )
    scoreDisplay:setFillColor(1,1,1)

    star = display.newImageRect("image/gold_star.png",30,30)

    --to spawn prize token
    function spawnStar( event )
        local starPos = Random( 2 )
        if(starPos == 1) then
            star.x = 30
            star.y = 413
        elseif(starPos == 2) then
            star.x = 300 
            star.y = 413
        end       
    end--end of star spawn

    --player sprite
    player = display.newImageRect("image/smile1.png",50,50)
    player.x = display.contentCenterX
    player.y = 420

    -- Create the widget
left = widget.newButton(
    {
        label = "left",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "circle",
        radius = 20,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
--position button
left.x = 50
left.y = 460

-- Create the widget
right = widget.newButton(
    {
        label = "right",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "circle",
        radius = 20,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
--position button
right.x = 280
right.y = 460

    
end--end of create scene
--------------------------------
--move player
function moveRight()
    audio.play(moveSound)
    transition.moveBy(player, { x=25,time=100})
    score = score + 1
    scoreDisplay.text = "score:"..score
end

function moveLeft()
    audio.play(moveSound)
    transition.moveBy(player, { x=-25,time=100})
    score = score + 1
    scoreDisplay.text = "score:"..score
end


local function createSpike()
 
    local spike = display.newImageRect("image/red_vermin.png",60,60)
    spike.x = display.contentCenterX
    spike.y = -10
    table.insert( spikesTable, spike )
    physics.addBody( spike, "dynamic")
    spike.myName = "spike"

    local whereFrom = Random( 6 )

    if ( whereFrom == 1 ) then
        -- From the left
        spike.x = Random( display.contentWidth )
        --.y = math.random( 500 )
        --newAsteroid:setLinearVelocity( math.random( 40,120 ), math.random( 20,60 ) )
    elseif ( whereFrom == 2 ) then
        -- From the top
        spike.x = Random( display.contentWidth ) - 33
        --newAsteroid.y = -60
        --newAsteroid:setLinearVelocity( math.random( -40,40 ), math.random( 40,120 ) )
    elseif ( whereFrom == 3 ) then
        -- From the right
        spike.x = Random(display.contentWidth) + 53
    elseif ( whereFrom == 4 ) then
        spike.x = Random( display.contentWidth) - 12    
    
    elseif ( whereFrom == 5 ) then
        spike.x = Random(display.contentWidth) + 45
    elseif ( whereFrom == 6 ) then
        spike.x = Random(display.contentWidth) - 5            
    end
end--end of createSpike
------------------------------
--collision
local function onStarCollision( self, event )
 
    if ( event.phase == "began" ) then
        display.remove(star)
 
    --elseif ( event.phase == "ended" ) then
        --timer.performWithDelay( 3000, spawnStar, 2 )
    end
end

--------------------------------
-------------------------------- 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        --background music
        audio.play(music, {duration=30000})

        --import physics engine and activate it
        local physics = require( "physics" )
         physics.start()
          
        timer.performWithDelay( 3000, spawnStar, 0 )
        

        player.collision = onStarCollision
        player:addEventListener( "collision" )
 
        star.collision = onStarCollision
        star:addEventListener( "collision" )

         timer.performWithDelay( 1000, createSpike, 0 )

        right:addEventListener("touch", moveRight)
        left:addEventListener("touch", moveLeft)
 
    end
end--end of show scene
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
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