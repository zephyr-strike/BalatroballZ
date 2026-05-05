
SMODS.Joker{ --Chi-Chi
    key = "chichi",
    config = {
        extra = {
            chichichips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Chi-Chi',
        ['text'] = {
            [1] = 'Gains {C:blue}+7{} Chips when hand',
            [2] = 'contains a {C:attention}Full House{}',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chichichips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if next(context.poker_hands["Full House"]) then
                card.ability.extra.chichichips = (card.ability.extra.chichichips) + 7
            else
                return {
                    chips = card.ability.extra.chichichips
                }
            end
        end
    end
}