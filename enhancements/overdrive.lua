
SMODS.Enhancement {
    key = 'overdrive',
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            xchips0 = 1.25,
            xmult0 = 1.25,
            xchips = 1.25,
            xmult = 1.25
        }
    },
    loc_txt = {
        name = 'Overdrive',
        text = {
            [1] = '{X:blue,C:white}X1.25{} Chips and {X:red,C:white}X1.25{} Mult',
            [2] = 'when scored or held in hand'
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
                x_chips = 1.25,
                extra = {
                    Xmult = 1.25
                }
            }
        end
        if context.cardarea == G.hand and context.main_scoring then
            return {
                x_chips = 1.25,
                extra = {
                    Xmult = 1.25
                }
            }
        end
    end
}