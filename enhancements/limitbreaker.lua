
SMODS.Enhancement {
    key = 'limitbreaker',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            limitbreak = 1,
            odds = 2
        }
    },
    loc_txt = {
        name = 'Limitbreaker',
        text = {
            [1] = '{C:green}1 in 2{} chance to add +{X:red,C:white}X0.025{}',
            [2] = 'Mult when this card is scored',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 3,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.limitbreak}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                Xmult = card.ability.extra.limitbreak
                ,
                func = function()
                    if SMODS.pseudorandom_probability(card, 'group_0_7fe0e67b', 1, card.ability.extra.odds, 'j_dbz_limitbreaker', false) then
                        card.ability.extra.limitbreak = (card.ability.extra.limitbreak) + 0.025
                        
                    end
                    return true
                end
            }
        end
    end
}