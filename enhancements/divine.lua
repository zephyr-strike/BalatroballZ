
SMODS.Enhancement {
    key = 'divine',
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            echips0 = 1.15
        }
    },
    loc_txt = {
        name = 'Divine',
        text = {
            [1] = '{X:spectral,C:white}^1.15{} Chips'
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
    weight = 2.5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                e_chips = 1.15
            }
        end
    end
}