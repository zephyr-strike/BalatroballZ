
SMODS.Joker{ --[Ultra Instinct] Son Goku
    key = "gokuui",
    config = {
        extra = {
            upmult = 1.3
        }
    },
    loc_txt = {
        ['name'] = '[Ultra Instinct] Son Goku',
        ['text'] = {
            [1] = '{X:spectral,C:white}^1.3 Mult{}. Prevents {C:red}Death{} if score is at least',
            [2] = '{C:attention}59%{} of required score then gains {X:spectral,C:white}^0.25 Mult{}',
            [3] = '{C:inactive}(Currently{} {X:spectral,C:white}^#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
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
        x = 7,
        y = 0
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rta' and args.source ~= 'wra' 
            or args.source == 'rif' or args.source == 'sou' or args.source == 'uta'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.upmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                e_mult = card.ability.extra.upmult
            }
        end
        if context.end_of_round and context.game_over and context.main_eval  and not context.blueprint then
            if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(0.59) then
                return {
                    saved = true,
                    message = localize('k_saved_ex'),
                    extra = {
                        func = function()
                            card.ability.extra.upmult = (card.ability.extra.upmult) + 0.25
                            return true
                        end,
                        message = "Not over yet...",
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "See ya!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_goku = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_gokuui" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_gokuui" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end