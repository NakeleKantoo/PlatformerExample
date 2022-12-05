platform = {}
player = {}
objs = {}
function love.load()
	addObjsLvl(1)
    addPlayer()
end

function addPlayer()
    player.x=0
    player.y=0
    player.width=50
    player.height=50
    player.velocity=5
    player.gravity=5
    player.isJumping=false
end

function addObjsLvl(lvl)
    if lvl==1 then
        table.insert(objs, {x=300,y=500,width=500,height=300})
        table.insert(objs, {x=0,y=200,width=500,height=300})
    end
end

function love.update(dt)
    playerUpdate()
end

function playerUpdate()
    localx=player.x
    localy=player.y
	if love.keyboard.isDown("a") then
        localx = player.x-player.velocity
    end
    if love.keyboard.isDown("d") then
        localx = player.x+player.velocity
    end
    if player.isJumping==false then
        localy = player.y+player.gravity
    end

    for index,value in ipairs(objs) do
        if collide(value,localx,player.y) then
            localx=player.x
        end
        if collide(value,player.x,localy) then
            localy=player.y
        end
    end
    player.x=localx
    player.y=localy   
end

function collide(obj,localx,localy)
    if collision(obj.x,obj.y,obj.width,obj.height,localx,localy,player.width,player.height) then
        return true
    end
end

function collision(x1, y1, w1, h1,  x2, y2, w2, h2)
    return  x1 < x2+w2 and
            x2 < x1+w1 and
            y1 < y2+h2 and
            y2 < y1+h1
end

function love.draw()
	drawPlayer()
    drawObjs()
end

function drawPlayer()
    love.graphics.rectangle('fill', player.x,player.y,player.width,player.height)
end

function drawObjs()
    for index,value in ipairs(objs) do
        love.graphics.rectangle('fill',value.x,value.y,value.width,value.height)
    end
end