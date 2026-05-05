
SMODS.Joker{ --Ginyu
    key = "ginyu",
    config = {
        extra = {
            xmult0 = 1.25
        }
    },
    loc_txt = {
        ['name'] = 'Ginyu',
        ['text'] = {
            [1] = 'Scored {C:clubs}Clubs{} give {X:red,C:white}X1.25{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                return {
                    Xmult = 1.25
                }
            end
        end
    end
}