
SMODS.Joker{ --[Corrupted] Merged Zamasu
    key = "zamasucm",
    config = {
        extra = {
            slot_change = '2',
            zamchipmult = 1,
            zamchip = 0
        }
    },
    loc_txt = {
        ['name'] = '[Corrupted] Merged Zamasu',
        ['text'] = {
            [1] = 'Creates a random {C:spectral}Spectral{} card',
            [2] = 'when {C:attention}Blind{} is selected and gain',
            [3] = '{X:red,C:white}X0.5{} Mult and {X:blue,C:white}X0.5{} Chips when',
            [4] = 'a {C:spectral}Spectral{} card is used.',
            [5] = '{C:attention}+2{} Consumable slots',
            [6] = '{C:inactive}(Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult and{} {X:chips,C:white}X#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = "dbz_transformed",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 9,
        y = 13
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.zamchipmult, card.ability.extra.zamchip}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    
                    for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({ set = 'Spectral', })                            
                                card:juice_up(0.3, 0.5)
                                return true
                            end
                        }))
                    end
                    delay(0.6)
                    
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                end
            }
        end
        if context.using_consumeable  and not context.blueprint then
            if context.consumeable and context.consumeable.ability.set == 'Spectral' then
                return {
                    func = function()
                        card.ability.extra.zamchip = (card.ability.extra.zamchip) + 0.5
                        return true
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.zamchipmult,
                extra = {
                    Xmult = card.ability.extra.zamchipmult
                }
            }
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "KEEAAAH!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_zamasu = false
                    return true
                end
            }))
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 2
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - 2
            return true
        end }))
    end
}