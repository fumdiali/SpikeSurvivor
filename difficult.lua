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

    enemiesTable = {}

    music = audio.loadSound("sound/music.mp3")
    moveSound = audio.loadSound( "sound/balloonPop.mp3" )

    --score display
    score = 0
    scoreDisplay = display.newText( "0", 160, 50, native.systemFont, 45 )
    scoreDisplay:setFillColor(1,1,1)

    levelDisplay = display.newText("Level 2", 160, 20, native.systemFont, 20)

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
    player.y = 410

    -- Create the player control widget
left = widget.newButton(
    {
        label = "left",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "circle",
        radius = 25,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
--position the move button
left.x = 130
left.y = 470

-- Create the player control widget
right = widget.newButton(
    {
        label = "right",
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "circle",
        radius = 25,
        fillColor = { default={0,0,1,0.5}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={0,0.4,1,0.5}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    }
)
--position button
right.x = 200
right.y = 470

--move player
function moveRight()
    audio.play(moveSound)
    transition.moveBy(player, { x=25,time=200})
    score = score + 1
    scoreDisplay.text = ""..score
end

function moveLeft()
    audio.play(moveSound)
    transition.moveBy(player, { x=-25,time=200})
    score = score + 1
    scoreDisplay.text = ""..score
end



    
end--end of create scene
--------------------------------
local function spawnEnemies()
 
    enemy = display.newImageRect("image/red_vermin.png",60,60)
    enemy.x = display.contentCenterX
    enemy.y = - 60
    table.insert( enemiesTable, enemy )
    physics.addBody( enemy, "dynamic")
    enemy.myName = "vermin"

    local whereFrom = Random( 4 )

    if ( whereFrom == 1 ) then
        
        enemy.x = Random( display.contentWidth )
    elseif ( whereFrom == 2 ) then
        
        enemy.x = Random( display.contentWidth ) - 33
        
    elseif ( whereFrom == 3 ) then
        
        enemy.x = Random(display.contentWidth) + 53

    elseif ( whereFrom == 4 ) then
        enemy.x = Random( display.contentWidth) - 12    
    
    --[[elseif ( whereFrom == 5 ) then
        enemy.x = Random(display.contentWidth) + 45

    elseif ( whereFrom == 6 ) then
        enemy.x = Random(display.contentWidth) - 5 --]]           
    end
end--end of spawnEnemies



------------------------------


--------------------------------
function startGame()
    --import physics engine and activate it
    local physics = require( "physics" )
    physics.start()

    --background music
    audio.play(music, {duration=30000})

    --creates enemies every 1.5 seconds,infinitely
    timer.performWithDelay( 800, spawnEnemies, 0 )
    --generate prize stars every 2 seconds
    timer.performWithDelay( 1000, spawnStar, 0 )
end
-------------------------------- 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

        startGame()
          
        --timer.performWithDelay( 3000, spawnStar, 0 )

         

        right:addEventListener("tap", moveRight)
        left:addEventListener("tap", moveLeft)
 
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