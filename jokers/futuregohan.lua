
SMODS.Joker{ --[Future] Son Gohan
    key = "futuregohan",
    config = {
        extra = {
            gohanround = 0,
            gohanmult = 1
        }
    },
    loc_txt = {
        ['name'] = '[Future] Son Gohan',
        ['text'] = {
            [1] = 'Creates a {C:attention}Negative Tag{}',
            [2] = 'when {C:attention}Boss Blind{} defeated'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_TAGS["tag_negative"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"tag_negative\" isn't a valid Tag key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.gohanround, card.ability.extra.gohanmult}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.GAME.blind.boss then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local tag = Tag("tag_negative")
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
                    message = "I have to do this...!"
                }
            end
        end
    end
}