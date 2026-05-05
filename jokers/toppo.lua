
SMODS.Joker{ --Toppo
    key = "toppo",
    config = {
        extra = {
            toppochips = 1
        }
    },
    loc_txt = {
        ['name'] = 'Toppo',
        ['text'] = {
            [1] = 'This Joker gains {X:blue,C:white}X0.25{} Chips when',
            [2] = 'a card is {C:red}destroyed{}',
            [3] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.toppochips}}
    end,
    
    calculate = function(self, card, context)
        if context.remove_playing_cards  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.toppochips = (card.ability.extra.toppochips) + 0.25
                    return true
                end,
                message = "Beyond Justice and Evil..."
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.toppochips
            }
        end
    end
}