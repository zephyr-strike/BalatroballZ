
SMODS.Joker{ --Janemba
    key = "janemba",
    config = {
        extra = {
            chips0 = 40,
            mult0 = 4,
            xchips0 = 1.4,
            xmult0 = 1.4
        }
    },
    loc_txt = {
        ['name'] = 'Janemba',
        ['text'] = {
            [1] = 'Scored {C:diamonds}Diamonds{} give {C:blue}+40{} Chips,',
            [2] = '{C:red}+4{} Mult, {X:blue,C:white}X1.4{} Chips and {X:red,C:white}X1.4{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                return {
                    chips = 40,
                    extra = {
                        mult = 4,
                        extra = {
                            x_chips = 1.4,
                            colour = G.C.DARK_EDITION,
                            extra = {
                                Xmult = 1.4
                            }
                        }
                    }
                }
            end
        end
    end
}