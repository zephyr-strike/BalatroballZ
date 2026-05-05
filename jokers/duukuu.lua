
SMODS.Joker{ --Duu and Kuu
    key = "duukuu",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Duu and Kuu',
        ['text'] = {
            [1] = 'Create 2 {C:attention}random Tags{}',
            [2] = 'when a {C:attention}Big Blind{} is skipped'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
        if context.skip_blind  then
            if G.GAME.blind:get_type() == 'Big' then
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
                    message = "Created Tag!",
                    extra = {
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
                        message = "Created Tag!",
                        colour = G.C.GREEN
                    }
                }
            end
        end
    end
}