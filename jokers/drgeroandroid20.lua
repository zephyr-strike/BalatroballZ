
SMODS.Joker{ --Dr. Gero (Android 20)
    key = "drgeroandroid20",
    config = {
        extra = {
            gerotag = 0
        }
    },
    loc_txt = {
        ['name'] = 'Dr. Gero (Android 20)',
        ['text'] = {
            [1] = 'When round begins, add a random {C:attention}playing',
            [2] = 'card{} with {C:attention}Overdrive{} to your deck'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["m_dbz_overdrive"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_dbz_overdrive\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.gerotag}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  then
            local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
            local base_card = create_playing_card({
                front = card_front,
                center = G.P_CENTERS.m_dbz_overdrive
            }, G.discard, true, false, nil, true)
            
            
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    base_card:start_materialize()
                    G.play:emplace(base_card)
                    return true
                end
            }))
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                end,
                message = "Added Card!"
            }
        end
    end
}