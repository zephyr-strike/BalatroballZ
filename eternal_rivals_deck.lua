
SMODS.Back {
    key = 'eternal_rivals_deck',
    pos = { x = 0, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Eternal Rivals Deck',
        text = {
            [1] = 'Start with an {C:tarot}Eternal{} {C:legendary}Goku & Vegeta{}.',
            [2] = '{C:red}-3{} Joker and {C:red}-1{} Consumable slots.'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_dbz_gokuvegeta' })
                    if new_joker then
                        new_joker:add_sticker('eternal', true)
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
        G.GAME.starting_params.joker_slots = 2
        G.GAME.starting_params.consumable_slots = 1
    end
}