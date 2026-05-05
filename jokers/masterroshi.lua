
SMODS.Joker{ --Master Roshi
    key = "masterroshi",
    config = {
        extra = {
            roshiqoh = 0,
            roshichips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Master Roshi',
        ['text'] = {
            [1] = 'After {C:attention}5 Queen of Hearts{} are',
            [2] = 'scored, create a {C:purple}The Hermit{}',
            [3] = '{C:inactive}(Must have room){}',
            [4] = '{C:inactive}(Currently{} {C:attention}#1#{}{C:inactive}/5){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.roshiqoh, card.ability.extra.roshichips}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (context.other_card:get_id() == 12 and context.other_card:is_suit("Hearts")) then
                card.ability.extra.roshichips = (card.ability.extra.roshichips) + 1
                return {
                    message = "Puff-Puff!"
                }
            elseif to_big((card.ability.extra.roshiqoh or 0)) >= to_big(5) then
                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'Tarot', key = 'c_hermit'})                            
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                end
                delay(0.6)
                card.ability.extra.roshiqoh = 0
                return {
                    message = created_consumable and localize('k_plus_tarot') or nil
                }
            end
        end
    end
}