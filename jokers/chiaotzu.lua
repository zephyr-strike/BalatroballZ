
SMODS.Joker{ --Chiaotzu
    key = "chiaotzu",
    config = {
        extra = {
            chiaocharm = 0
        }
    },
    loc_txt = {
        ['name'] = 'Chiaotzu',
        ['text'] = {
            [1] = 'When {C:attention}2 Blinds{} are defeated,',
            [2] = 'creates a {C:tarot}Charm Tag{}',
            [3] = '{C:inactive}(Currently{} {C:attention}#1#{}{C:inactive}/2){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 7
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
        
        local info_queue_0 = G.P_TAGS["tag_charm"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"tag_charm\" isn't a valid Tag key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.chiaocharm}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if to_big((card.ability.extra.chiaocharm or 0)) >= to_big(2) then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local tag = Tag("tag_charm")
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
                    message = "Thats my cue!",
                    extra = {
                        func = function()
                            card.ability.extra.chiaocharm = 0
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            else
                return {
                    func = function()
                        card.ability.extra.chiaocharm = (card.ability.extra.chiaocharm) + 1
                        return true
                    end
                }
            end
        end
    end
}