
SMODS.Joker{ --[Ultra Instinct and Ultra Ego] Goku and Vegeta
    key = "gvuiue",
    config = {
        extra = {
            gvmult = 2.5,
            gvchip = 2.5,
            echips0 = 1.25,
            emult0 = 1.25
        }
    },
    loc_txt = {
        ['name'] = '[Ultra Instinct and Ultra Ego] Goku and Vegeta',
        ['text'] = {
            [1] = 'Gain {X:spectral,C:white}^0.2{} Chips and Mult when {C:attention}Blind{} is selected.',
            [2] = 'Scored {C:attention}face{} cards give {X:spectral,C:white}^1.25{} Chips and Mult.',
            [3] = 'Gain {X:spectral,C:white}^0.5{} Chips when a card is {C:red}destroyed{}.',
            [4] = 'Prevents {C:red}Death{} if score is at least',
            [5] = '{C:attention}59%{} of required score then gains {X:spectral,C:white}^0.5{} Mult.{}',
            [6] = '{C:inactive}(Currently{} {X:spectral,C:white}^#2#{} {C:inactive}Chips and {X:spectral,C:white}^#1#{} {C:inactive}Mult){}{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 6
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
        y = 6
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
        
        return {vars = {card.ability.extra.gvmult, card.ability.extra.gvchip}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_face() then
                return {
                    e_chips = 1.25,
                    extra = {
                        e_mult = 1.25,
                        colour = G.C.DARK_EDITION
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.gvmult = (card.ability.extra.gvmult) + 0.2
                    return true
                end,
                message = "Believe me...",
                extra = {
                    func = function()
                        card.ability.extra.gvchip = (card.ability.extra.gvchip) + 0.2
                        return true
                    end,
                    message = "My heart is not calm now!",
                    colour = G.C.GREEN
                }
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                e_chips = card.ability.extra.gvchip,
                extra = {
                    e_mult = card.ability.extra.gvmult,
                    colour = G.C.DARK_EDITION
                }
            }
        end
        if context.end_of_round and context.game_over and context.main_eval  and not context.blueprint then
            if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(0.59) then
                return {
                    saved = true,
                    message = "Not yet!",
                    extra = {
                        func = function()
                            card.ability.extra.gvmult = (card.ability.extra.gvmult) + 0.5
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.remove_playing_cards  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.gvchip = (card.ability.extra.gvchip) + 0.5
                    return true
                end,
                message = "Throw it all away!"
            }
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Lets go, Vegeta.", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_gv = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_gvuiue" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_gvuiue" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end