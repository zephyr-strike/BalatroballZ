
SMODS.Joker{ --Vegeta
    key = "vegetabase",
    config = {
        extra = {
            vegetachips = 0,
            vegetat1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Vegeta',
        ['text'] = {
            [1] = 'Gain {C:blue}+5{} Chips when a {C:attention}face{}',
            [2] = 'card is scored (Max of {C:blue}9001{})',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{}{C:inactive} Chips){}',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#2#{}{C:inactive}/5 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
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
    soul_pos = {
        x = 9,
        y = 0
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'rta' and args.source ~= 'wra' 
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'sou' or args.source == 'uta'
        )
        and not G.GAME.pool_flags.dbz_no_vegeta
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.vegetachips, card.ability.extra.vegetat1}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.vegetachips
            }
        end
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.vegetachips = (card.ability.extra.vegetachips) + 5
                return {
                    message = "Saiyan Pride!"
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.vegetat1 or 0)) >= to_big(5) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:shatter({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            
                            local created_joker = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_vegetass' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "I am SUPER VEGETA!", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.vegetat1 = (card.ability.extra.vegetat1) + 1
                    return true
                end
            }
        end
    end
}