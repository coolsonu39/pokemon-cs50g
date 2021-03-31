BattleLevelUpState = Class{__includes = BaseState} --spec1

function BattleLevelUpState:init(pokemon)
    local hp, attack, defense, speed = pokemon:levelUp()

    self.battleLevelUpMenu = Menu {
        x = 0,
        y = 0,
        width = VIRTUAL_WIDTH,
        height = VIRTUAL_HEIGHT,
        items = {
            { text = 'Health -> ' .. pokemon.HP - hp .. ' + ' .. hp .. ' = ' .. pokemon.HP },
            { text = 'Attack -> ' .. pokemon.attack - attack .. ' + ' .. attack .. ' = ' .. pokemon.attack },
            { text = 'Defense -> ' .. pokemon.defense - defense .. ' + ' .. defense .. ' = ' .. pokemon.defense },
            { text = 'Speed -> ' .. pokemon.speed - speed .. ' + ' .. speed .. ' = ' .. pokemon.speed },
            { text = 'Press Enter to continue' }
        },
        noCursor = true
    }
end

function BattleLevelUpState:update(dt)
    self.battleLevelUpMenu:update(dt)

    if love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(FadeInState({
            r = 255, g = 255, b = 255
        }, 1, 
        function()
    
            -- resume field music
            gSounds['victory-music']:stop()
            gSounds['field-music']:play()
            
            -- pop off the battle state
            gStateStack:pop()
            gStateStack:push(FadeOutState({
                r = 255, g = 255, b = 255
            }, 1, function() end))
        end))
    end
end

function BattleLevelUpState:render()
    self.battleLevelUpMenu:render()
end