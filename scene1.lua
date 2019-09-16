
local composer = require("composer")

local widget = require("widget")

local physics = require("physics")
physics.start()
physics.setGravity( 0, 0 )

local scene = composer.newScene()

W = display.contentWidth   -- Largura da tela
H = display.contentHeight  -- Altura da tela

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local vidas = 3
local pontos = 0
local personagem 
local p_negativos 
local pal_negativa
local p_negativosTable = {}
local abcTable = {} 
local pal_negativaTable = {} 
local criaAbcTempo 
faseContador = 1


function scene:create( event )
    
            local sceneGroup = self.view
            local background = display.newImageRect( backGroup, 'img/background/back.png', 1250, 700)
            background.x = display.contentCenterX
            background.y = display.contentCenterY


            personagem = display.newImageRect(mainGroup, "imagens/personagens/anny.png", 80, 60)
            personagem.x = 10
            personagem.y = 100
            physics.addBody(personagem, "dynamic")
            personagem.isFixedRotation = true
            personagem.isSensor = true
            personagem.myName = "personagem"
            personagem.gravityScale = 0

            chamarFuncao = true


            local function slidPersonagem (event) 

                local personagem = event.target
                local phase = event.phase

                if ( "began" == phase ) then
                    display.currentStage:setFocus( personagem )
                    personagem.touchOffsetY = event.y - personagem.y
                
                elseif ( "moved" == phase ) then
                    personagem.y = event.y - personagem.touchOffsetY
                    
                elseif ( "ended" == phase or "cancelled" == phase ) then
                    display.currentStage:setFocus( nil )    
                end

                return true 
            end

                 personagem:addEventListener( "touch", slidPersonagem )

    

   
            local function createPensamentosNegativos() 
                    if(faseContador == 1) then
                        if(#p_negativosTable < 4) then
                        
                            newPensamentosNegativos = display.newImageRect(mainGroup, 'imagens/personagens/p_negativos.png', 50, 50 )
                            table.insert( p_negativosTable, newPensamentosNegativos )
                            physics.addBody( newPensamentosNegativos, {isSensor = true})
                            newPensamentosNegativos.bodyType = "dynamic"
                            newPensamentosNegativos.myName = "p_negativos"
                        
                            local whereFrom = 3
                            if ( whereFrom == 3 ) then
                                newPensamentosNegativos.x = W + 10
                                newPensamentosNegativos.y = math.random(H)
                                newPensamentosNegativos:setLinearVelocity( math.random( -40,40 ), math.random( 1, 50 ) )
                            end

                        end 
                    else 
                        display.remove(newPensamentosNegativos)   
                        for i = #p_negativosTable, 1, -1 do
                            if(p_negativosTable[i] == newPensamentosNegativos) then
                                table.remove(p_negativosTable, i)
                                break
                            end
                        end   
                    end    
            end

    
            function movePensamentosNegativos( )
                if(faseContador == 1) then
                    for i = #p_negativosTable, 1, -1 do
                        local p_negativos = p_negativosTable[i]
                
                        if(p_negativos.x + p_negativos.contentWidth < -100) then
                            p_negativos.x = W + 10
                            p_negativos.y = math.random(math.random(H))
                        else
                            local limitePensamentosNegativos = math.random(p_negativos.y - 8, p_negativos.y + 8)
                            if(limitePensamentosNegativos > H) then
                                limitePensamentosNegativos = H - 5
                
                            elseif(limitePensamentosNegativos < 0) then
                                limitePensamentosNegativos = 5
                            end 
                            transition.moveTo( p_negativos, { x=p_negativos.x - 30, y=limitePensamentosNegativos, time=300 } )
                        end
                    end  
                end    
            end

    
            local function createPalavraNegativa() 
                if(faseContador == 2) then -- Fase Depois Implementando
                    if(#pal_negativaTable < 4) then
                    
                        newPalavraNegativa = display.newImageRect(mainGroup, 'imagens/personagens/pal_negativa.png', 50, 50 )
                        table.insert( pal_negativaTable, newPalavraNegativa )
                        physics.addBody( newPalavraNegativa, {isSensor = true})
                        newPalavraNegativa.bodyType = "dynamic"
                        newPalavraNegativa.myName = "pal_negativa"
                    
                        local whereFrom = 3
                        if ( whereFrom == 3 ) then
                            newPalavraNegativa.x = W + 10
                            newPalavraNegativa.y = math.random(H)
                            newPalavraNegativa:setLinearVelocity( math.random( -40,40 ), math.random( 1, 50 ) )
                        end
        
                    end
                else 
                    display.remove(newPalavraNegativa) 
                    for i = #pal_negativaTable, 1, -1 do
                        if(pal_negativaTable[i] == newPalavraNegativa) then
                            table.remove(pal_negativaTable, i)
                            break
                        end
                    end  
                end       
            end

            function movePalavraNegativa( )
                if(faseContador == 2) then
                    for i = #pal_negativaTable, 1, -1 do
                        local pal_negativa = pal_negativaTable[i]
                
                        if(pal_negativa.x + pal_negativa.contentWidth < -100) then
                            pal_negativa.x = W + 10
                            pal_negativa.y = math.random(math.random(H))
                        else
                            local limitePalavrasNegativa = math.random(pal_negativa.y - 5, pal_negativa.y + 20)
                            if(limitePalavrasNegativa > H) then
                                limitePalavrasNegativa = H - 5
                
                            elseif(limitePalavrasNegativa < 0) then
                                limitePalavrasNegativa = 5
                            end 
                            transition.moveTo( pal_negativa, { x=pal_negativa.x - 30, y=limitePalavrasNegativa, time=400 } )
                        end
                    end
                end   
            end


            local function createAbc() 
                if(#abcTable  < 4) then
                    
                    local newAbc = display.newImageRect(mainGroup, 'imagens/personagens/pal_positiva.png', 50, 50 )
                    table.insert( abcTable , newAbc )
                    physics.addBody( newAbc, {isSensor = true})
                    newAbc.bodyType = "dynamic"
                    newAbc.myName = "abc"
                    
                    local whereFrom = 3
                    if (whereFrom == 3 ) then
                            -- From the right
                        newAbc.x = W + 10
                        newAbc.y = math.random(H)
                        newAbc:setLinearVelocity( math.random( -50,-4 ), math.random( 1,50 ) )
                    end
                end    
            end

            function moveAbc( ) 
           
                for i = #abcTable , 1, -1 do
                    local abc = abcTable [i]
                    if(abc.x + abc.contentWidth < -100) then
                        abc.x = W + 10
                        abc.y = math.random(math.random(H))
                    else

                        local limiteAbc = math.random(abc.y - 5, abc.y + 5)
                        if(limiteAbc > H) then
                            limiteAbc = H - 5
                
                        elseif(limiteAbc < 0) then
                            limiteAbc = 5
                        end 
                        transition.moveTo( abc, { x=abc.x - 30, y=limiteAbc, time=400 } )
                    end
                end
                   
            end

            --Loading create
            local function gameLoopTimer()
                createPalavraNegativa()
                createPensamentosNegativos()
                createAbc()
            end    

  
            local function moveLoopTimer()
                movePensamentosNegativos()
                movePalavraNegativa()
                moveAbc()
            end  

                gameLoopTimer = timer.performWithDelay(3000, gameLoopTimer, -1)
                criaAbcTempo = timer.performWithDelay(1000, createAbc, -1)
                moveLoopTimer = timer.performWithDelay(450, moveLoopTimer, -1)
                moveAbcTempo = timer.performWithDelay(350, moveAbc, -1)


                local function onGlobalCollision( event )

                    local obj1 = event.object1
                    local obj2 = event.object2
                
                    if(obj2.myName == "p_negativos" and obj1.myName == "personagem" )then
                        display.remove(obj2)
                        vidas = vidas - 1
                
                        for i = #p_negativosTable, 1, -1 do
                            if(p_negativosTable[i] == obj2) then
                                table.remove(p_negativosTable, i)
                                break
                            end
                        end
                
                    elseif(obj1.myName == "p_negativos" and obj2.myName == "personagem") then 
                        display.remove(obj1)
                        vidas = vidas - 1
                
                        for i = #p_negativosTable, 1, -1 do
                            if(p_negativosTable[i] == obj1) then
                                table.remove(p_negativosTable, i)
                                break
                            end
                        end  
        
    
                    elseif(obj1.myName == "abc" and obj2.myName == "personagem") then
                        display.remove(obj1)
                        pontos = pontos + 10
                        if(vidas < 3) then
                            vidas = vidas + 1 
                        else
                            vidas = vidas + 0
                        end    
                
                        for i = #abcTable, 1, -1 do
                            if(abcTable[i] == obj1) then
                                table.remove(abcTable, i)
                                break
                            end
                        end

                    elseif(obj2.myName == "abc" and obj1.myName == "personagem") then
                        display.remove(obj2)
                        pontos = pontos + 10
                        if(vidas < 3) then
                            vidas = vidas + 1 
                        else
                            vidas = vidas + 0
                        end  
                
                        for i = #abcTable, 1, -1 do
                            if(abcTable[i] == obj2) then
                                table.remove(abcTable, i)
                                break
                            end
                        end
                     
                    elseif(obj2.myName == "pal_negativa" and obj1.myName == "personagem" )then
                        display.remove(obj2)
                        vidas = vidas - 1
                    
                        for i = #pal_negativaTable, 1, -1 do
                            if(pal_negativaTable[i] == obj2) then
                                table.remove(pal_negativaTable, i)
                                break
                            end
                        end
                    
                    elseif(obj1.myName == "pal_negativa" and obj2.myName == "personagem") then 
                        display.remove(obj1)
                        vidas = vidas - 1
                    
                        for i = #pal_negativaTable, 1, -1 do
                            if(pal_negativaTable[i] == obj1) then
                                table.remove(pal_negativaTable, i)
                                break
                            end
                        end  

                    end
                        
                end
   

                -- Implementando Vidas --

                local larguraVida = 100
                local alturaVida = 35

                local posicaoX = 20
                local posicaoY = 22

                barraDeVida = display.newImageRect(uiGroup, 'imagens/vida/vida3.png', larguraVida, alturaVida)
                barraDeVida.x = posicaoX
                barraDeVida.y = posicaoY
                
                vida1 = display.newImageRect(uiGroup, "imagens/vida/vida1.png", larguraVida, alturaVida)
                vida1.x = posicaoX
                vida1.y = posicaoY
                vida1.alpha = 0
                
                vida2 = display.newImageRect(uiGroup, "imagens/vida/vida2.png", larguraVida, alturaVida)
                vida2.x = posicaoX
                vida2.y = posicaoY
                vida2.alpha = 0
                
                vida0 = display.newImageRect(uiGroup, "imagens/vida/vida.png", larguraVida, alturaVida)
                vida0.x = posicaoX
                vida0.y = posicaoY
                vida0.alpha = 0

                local function vida( event )
                    barraDeVida.alpha = 0
                    vida2.alpha = 0
                    vida1.alpha = 0    
                    vida0.alpha = 0
                    
                    if(vidas == 2) then
                        vida2.alpha = 1 

                    elseif(vidas == 1) then
                        
                        vida1.alpha = 1

                    elseif(vidas == 0) then
                        
                        vida0.alpha = 1
                    elseif(vidas == 3) then
                        
                        barraDeVida.alpha = 1 
                    end
                end   

     
     
                -- show()

                    Runtime:addEventListener("collision", onGlobalCollision)
                    Runtime:addEventListener("enterFrame", vida)
     
   
     
                -- destroy()
                function scene:destroy( event )
                     
                    local sceneGroup = self.view
                    -- Code here runs prior to the removal of scene's view
                    audio.dispose(backgroundmusic)
                     
                end   


end    
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
--scene:addEventListener( "hide", scene )
--scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
     
return scene
