
SMODS.Joker{ --Bardock
    key = "bardock",
    config = {
        extra = {
            chips0 = 10
        }
    },
    loc_txt = {
        ['name'] = 'Bardock',
        ['text'] = {
            [1] = 'If played hand contains {C:attention}5{}',
            [2] = '{C:spades}Spades{}, give {C:blue}+10{} Chips then',
            [3] = 'swap {C:blue}Chips{} and {C:red}Mult{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if (function()
                local count = 0
                for _, playing_card in pairs(context.scoring_hand or {}) do
                    if playing_card:is_suit("Spades") then
                        count = count + 1
                    end
                end
                return count == #context.scoring_hand
            end)() then
                return {
                    chips = 10,
                    extra = {
                        swap = true,
                        message = "This will change EVERYTHING!",
                        colour = G.C.CHIPS
                    }
                }
            end
        end
    end
}