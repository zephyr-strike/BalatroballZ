
SMODS.Joker{ --Pikkon
    key = "pikkon",
    config = {
        extra = {
            pikkontag = 0
        }
    },
    loc_txt = {
        ['name'] = 'Pikkon',
        ['text'] = {
            [1] = 'Create a {C:attention}random Tag{} when',
            [2] = 'a {C:attention}Blind{} is skipped'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.pikkontag}}
    end,
    
    calculate = function(self, card, context)
        if context.skip_blind  then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                            local tag = Tag(selected_tag)
                            if tag.name == "Orbital Tag" then
                                local _poker_hands = {}
                                for k, v in pairs(G.GAME.hands) do
                                    if v.visible then
                                        _poker_hands[#_poker_hands + 1] = k
                                    end
                                end
                                tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                            end
                            tag:set_ability()
                            add_tag(tag)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end
                    }))
                    return true
                end,
                message = "Created Tag!"
            }
        end
    end
}