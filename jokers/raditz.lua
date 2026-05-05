
SMODS.Joker{ --Raditz
    key = "raditz",
    config = {
        extra = {
            mult0 = 12
        }
    },
    loc_txt = {
        ['name'] = 'Raditz',
        ['text'] = {
            [1] = '{C:attention}Wild Cards{} give {C:red}+12{} Mult',
            [2] = 'when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 10
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
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["m_wild"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_wild\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_wild"] == true then
                return {
                    mult = 12
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if (function()
                local count = 0
                for _, consumable_card in pairs(G.consumeables.cards or {}) do
                    if consumable_card.ability.set == 'Planet' then
                        count = count + 1
                    end
                end
                return to_big(count) >= to_big(1)
            end)() then
            end
        end
    end
}