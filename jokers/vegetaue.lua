
SMODS.Joker{ --[Ultra Ego] Vegeta
    key = "vegetaue",
    config = {
        extra = {
            vegetachips = 10,
            vegetaxmult = 1
        }
    },
    loc_txt = {
        ['name'] = '[Ultra Ego] Vegeta',
        ['text'] = {
            [1] = 'Gain {X:blue,C:white}X0.25{} Chips and {X:red,C:white}X0.25{} Mult',
            [2] = 'when a {C:attention}face{} card is scored and gains',
            [3] = '{X:red,C:white}X5{} Mult when a card is {C:red}destroyed{}',
            [4] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}Chips and{} {X:mult,C:white}X#2# Mult{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
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
        x = 5,
        y = 1
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rta' and args.source ~= 'uta' and args.source ~= 'wra' 
            or args.source == 'rif' or args.source == 'sou'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.vegetachips, card.ability.extra.vegetaxmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.vegetachips,
                extra = {
                    Xmult = card.ability.extra.vegetaxmult
                }
            }
        end
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.vegetachips = (card.ability.extra.vegetachips) + 0.25
                card.ability.extra.vegetaxmult = (card.ability.extra.vegetaxmult) + 0.25
                return {
                    message = "On my pride!"
                }
            end
        end
        if context.remove_playing_cards  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.vegetaxmult = (card.ability.extra.vegetaxmult) + 5
                    return true
                end,
                message = "Relish Destruction!"
            }
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Tch! Weakling...", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_vegeta = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_vegetaue" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_vegetaue" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end