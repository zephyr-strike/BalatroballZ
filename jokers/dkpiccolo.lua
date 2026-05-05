
SMODS.Joker{ --Demon King Piccolo
    key = "dkpiccolo",
    config = {
        extra = {
            dkp7 = 0,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Demon King Piccolo',
        ['text'] = {
            [1] = 'When {C:attention}7 7s{} are scored, {C:attention}create{}',
            [2] = 'a {C:attention}random{} {C:spectral}Spectral{} card',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.dkp7, card.ability.extra.var1}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:get_id() == 7 then
                card.ability.extra.var1 = (card.ability.extra.var1) + 1
            elseif to_big((card.ability.extra.dkp7 or 0)) >= to_big(7) then
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Spectral', })                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                delay(0.6)
                card.ability.extra.dkp7 = 0
                return {
                    message = created_consumable and localize('k_plus_spectral') or nil
                }
            end
        end
    end
}