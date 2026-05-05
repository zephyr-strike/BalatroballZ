
SMODS.Joker{ --[Super Perfect] Cell
    key = "superperfectcell",
    config = {
        extra = {
            cellmult = 1
        }
    },
    loc_txt = {
        ['name'] = '[Super Perfect] Cell',
        ['text'] = {
            [1] = 'If hand has {C:attention}4{} or more {C:attention}scoring{}',
            [2] = 'cards, {C:red}destroy{}{C:attention} 4th{} scored card',
            [3] = 'and this Joker gains {X:red,C:white}X0.35{} Mult',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.cellmult}}
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if (to_big(#context.scoring_hand) >= to_big(4) and context.other_card == context.scoring_hand[4]) then
                context.other_card.should_destroy = true
                card.ability.extra.cellmult = (card.ability.extra.cellmult) + 0.35
                return {
                    message = "Enjoy oblivion!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.cellmult
            }
        end
    end
}