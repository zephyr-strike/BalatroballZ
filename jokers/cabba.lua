
SMODS.Joker{ --[Super Saiyan] Cabba
    key = "cabba",
    config = {
        extra = {
            chips0 = 60
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan] Cabba',
        ['text'] = {
            [1] = 'Scored {C:attention}6s{} give {C:blue}60{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 6 then
                return {
                    chips = 60
                }
            end
        end
    end
}