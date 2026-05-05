
SMODS.Joker{ --Lord Slug
    key = "lordslug",
    config = {
        extra = {
            hand_size_increase = '2',
            slugmult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Lord Slug',
        ['text'] = {
            [1] = '{C:attention}+2{} hand size. Gains {C:red}+1{} Mult',
            [2] = 'per card {C:attention}held in hand{} at the',
            [3] = 'end of round.',
            [4] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.slugmult}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.end_of_round  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.slugmult = (card.ability.extra.slugmult) + 1
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                mult = card.ability.extra.slugmult
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(2)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-2)
    end
}