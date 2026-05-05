SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end
-- this function is used to load everything within a folder.-- Jokerforge doesnt use it because it doesnt make loading order easy
local function load_folder(path)
    local files = NFS.getDirectoryItemsInfo(mod_path .. "/" .. path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file(path .. file_name))()
        end
    end
end
-- load the jokers
if true then
    assert(SMODS.load_file("jokers/gokubase.lua"))()
    assert(SMODS.load_file("jokers/gokuss.lua"))()
    assert(SMODS.load_file("jokers/gokussb.lua"))()
    assert(SMODS.load_file("jokers/gokuui.lua"))()
    assert(SMODS.load_file("jokers/vegetabase.lua"))()
    assert(SMODS.load_file("jokers/vegetass.lua"))()
    assert(SMODS.load_file("jokers/vegetassbe.lua"))()
    assert(SMODS.load_file("jokers/vegetaue.lua"))()
    assert(SMODS.load_file("jokers/broly.lua"))()
    assert(SMODS.load_file("jokers/brolyfpss.lua"))()
    assert(SMODS.load_file("jokers/majinbuu.lua"))()
    assert(SMODS.load_file("jokers/evilbuu.lua"))()
    assert(SMODS.load_file("jokers/superbuu.lua"))()
    assert(SMODS.load_file("jokers/buuhan.lua"))()
    assert(SMODS.load_file("jokers/kidbuu.lua"))()
    assert(SMODS.load_file("jokers/gohanbase.lua"))()
    assert(SMODS.load_file("jokers/gohanult.lua"))()
    assert(SMODS.load_file("jokers/gohanbeast.lua"))()
    assert(SMODS.load_file("jokers/trunksbase.lua"))()
    assert(SMODS.load_file("jokers/trunksss.lua"))()
    assert(SMODS.load_file("jokers/piccolo.lua"))()
    assert(SMODS.load_file("jokers/piccolopa.lua"))()
    assert(SMODS.load_file("jokers/piccoloorange.lua"))()
    assert(SMODS.load_file("jokers/friezabase.lua"))()
    assert(SMODS.load_file("jokers/friezafp.lua"))()
    assert(SMODS.load_file("jokers/friezagolden.lua"))()
    assert(SMODS.load_file("jokers/gokuvegeta.lua"))()
    assert(SMODS.load_file("jokers/gvss.lua"))()
    assert(SMODS.load_file("jokers/gvss2.lua"))()
    assert(SMODS.load_file("jokers/gvss3.lua"))()
    assert(SMODS.load_file("jokers/gvss4.lua"))()
    assert(SMODS.load_file("jokers/gvssg.lua"))()
    assert(SMODS.load_file("jokers/gvssb.lua"))()
    assert(SMODS.load_file("jokers/gvuioevo.lua"))()
    assert(SMODS.load_file("jokers/gvuiue.lua"))()
    assert(SMODS.load_file("jokers/android1718.lua"))()
    assert(SMODS.load_file("jokers/bardock.lua"))()
    assert(SMODS.load_file("jokers/bojack.lua"))()
    assert(SMODS.load_file("jokers/cabba.lua"))()
    assert(SMODS.load_file("jokers/cauliflakale.lua"))()
    assert(SMODS.load_file("jokers/chichi.lua"))()
    assert(SMODS.load_file("jokers/chiaotzu.lua"))()
    assert(SMODS.load_file("jokers/dabura.lua"))()
    assert(SMODS.load_file("jokers/dkpiccolo.lua"))()
    assert(SMODS.load_file("jokers/dyspo.lua"))()
    assert(SMODS.load_file("jokers/farmershotgun.lua"))()
    assert(SMODS.load_file("jokers/gotentrunks.lua"))()
    assert(SMODS.load_file("jokers/supersaiyan3gotenks.lua"))()
    assert(SMODS.load_file("jokers/gammas.lua"))()
    assert(SMODS.load_file("jokers/masterroshi.lua"))()
    assert(SMODS.load_file("jokers/pikkon.lua"))()
    assert(SMODS.load_file("jokers/tien.lua"))()
    assert(SMODS.load_file("jokers/whis.lua"))()
    assert(SMODS.load_file("jokers/zamasu.lua"))()
    assert(SMODS.load_file("jokers/android13.lua"))()
    assert(SMODS.load_file("jokers/android16.lua"))()
    assert(SMODS.load_file("jokers/beerus.lua"))()
    assert(SMODS.load_file("jokers/drgeroandroid20.lua"))()
    assert(SMODS.load_file("jokers/duukuu.lua"))()
    assert(SMODS.load_file("jokers/eastsupremekaishin.lua"))()
    assert(SMODS.load_file("jokers/supersaiyanrosgokublack.lua"))()
    assert(SMODS.load_file("jokers/ginyu.lua"))()
    assert(SMODS.load_file("jokers/guldorecoome.lua"))()
    assert(SMODS.load_file("jokers/hercule.lua"))()
    assert(SMODS.load_file("jokers/jeiceburter.lua"))()
    assert(SMODS.load_file("jokers/jiren.lua"))()
    assert(SMODS.load_file("jokers/kingcold.lua"))()
    assert(SMODS.load_file("jokers/majuub.lua"))()
    assert(SMODS.load_file("jokers/raditz.lua"))()
    assert(SMODS.load_file("jokers/saibaman.lua"))()
    assert(SMODS.load_file("jokers/senzubean.lua"))()
    assert(SMODS.load_file("jokers/shenron.lua"))()
    assert(SMODS.load_file("jokers/super17.lua"))()
    assert(SMODS.load_file("jokers/tapion.lua"))()
    assert(SMODS.load_file("jokers/toppo.lua"))()
    assert(SMODS.load_file("jokers/yamcha.lua"))()
    assert(SMODS.load_file("jokers/bulma.lua"))()
    assert(SMODS.load_file("jokers/superperfectcell.lua"))()
    assert(SMODS.load_file("jokers/cellmax.lua"))()
    assert(SMODS.load_file("jokers/cooler.lua"))()
    assert(SMODS.load_file("jokers/janemba.lua"))()
    assert(SMODS.load_file("jokers/krillin.lua"))()
    assert(SMODS.load_file("jokers/lordslug.lua"))()
    assert(SMODS.load_file("jokers/majinvegeta.lua"))()
    assert(SMODS.load_file("jokers/nappa.lua"))()
    assert(SMODS.load_file("jokers/futuregohan.lua"))()
    assert(SMODS.load_file("jokers/gohanss2.lua"))()
    assert(SMODS.load_file("jokers/superbaby2.lua"))()
    assert(SMODS.load_file("jokers/turles.lua"))()
    assert(SMODS.load_file("jokers/fruitofmight.lua"))()
    assert(SMODS.load_file("jokers/brolyz.lua"))()
    assert(SMODS.load_file("jokers/hit.lua"))()
    assert(SMODS.load_file("jokers/omegashenron.lua"))()
    assert(SMODS.load_file("jokers/awesomefuckingedittien.lua"))()
    assert(SMODS.load_file("jokers/johndragonball.lua"))()
    assert(SMODS.load_file("jokers/kefla.lua"))()
    assert(SMODS.load_file("jokers/mergedzamasu.lua"))()
    assert(SMODS.load_file("jokers/zamasucm.lua"))()
    assert(SMODS.load_file("jokers/vegito.lua"))()
    assert(SMODS.load_file("jokers/vegitoss.lua"))()
    assert(SMODS.load_file("jokers/vegitoblue.lua"))()
    assert(SMODS.load_file("jokers/gogeta.lua"))()
    assert(SMODS.load_file("jokers/gogetass.lua"))()
    assert(SMODS.load_file("jokers/gogeta4.lua"))()
    assert(SMODS.load_file("jokers/gogetablue.lua"))()
end
-- load the consumables
if true then
    assert(SMODS.load_file("consumables/korintower.lua"))()
    assert(SMODS.load_file("consumables/kamehouse.lua"))()
    assert(SMODS.load_file("consumables/kingkaiplanet.lua"))()
    assert(SMODS.load_file("consumables/capsulecorp.lua"))()
    assert(SMODS.load_file("consumables/hyperbolictimechamber.lua"))()
    assert(SMODS.load_file("consumables/beerusplanet.lua"))()
    assert(SMODS.load_file("consumables/planetvegeta.lua"))()
    assert(SMODS.load_file("consumables/namek.lua"))()
end
--load the sets
assert(SMODS.load_file("consumables/sets.lua"))()
-- load the enhancements
if true then
    assert(SMODS.load_file("enhancements/overcharged.lua"))()
    assert(SMODS.load_file("enhancements/limitbreaker.lua"))()
    assert(SMODS.load_file("enhancements/divine.lua"))()
    assert(SMODS.load_file("enhancements/overdrive.lua"))()
end

-- load the decks
if true then
    assert(SMODS.load_file("decks/eternal_rivals_deck.lua"))()
end



assert(SMODS.load_file("rarities.lua"))()


-- load boosters
assert(SMODS.load_file("boosters.lua"))()
--load sounds
assert(SMODS.load_file("sounds.lua"))()
SMODS.ObjectType({
    key = "dbz_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "dbz_bbz",
    cards = {
        ["j_dbz_gokubase"] = true,
        ["j_dbz_gokuss"] = true,
        ["j_dbz_gokussb"] = true,
        ["j_dbz_gokuui"] = true,
        ["j_dbz_vegetabase"] = true,
        ["j_dbz_vegetass"] = true,
        ["j_dbz_vegetassbe"] = true,
        ["j_dbz_vegetaue"] = true,
        ["j_dbz_broly"] = true,
        ["j_dbz_brolyfpss"] = true,
        ["j_dbz_majinbuu"] = true,
        ["j_dbz_evilbuu"] = true,
        ["j_dbz_superbuu"] = true,
        ["j_dbz_buuhan"] = true,
        ["j_dbz_kidbuu"] = true,
        ["j_dbz_gohanbase"] = true,
        ["j_dbz_gohanult"] = true,
        ["j_dbz_gohanbeast"] = true,
        ["j_dbz_trunksbase"] = true,
        ["j_dbz_trunksss"] = true,
        ["j_dbz_piccolo"] = true,
        ["j_dbz_piccolopa"] = true,
        ["j_dbz_piccoloorange"] = true,
        ["j_dbz_friezabase"] = true,
        ["j_dbz_friezafp"] = true,
        ["j_dbz_friezagolden"] = true,
        ["j_dbz_gokuvegeta"] = true,
        ["j_dbz_gvss"] = true,
        ["j_dbz_gvss2"] = true,
        ["j_dbz_gvss3"] = true,
        ["j_dbz_gvss4"] = true,
        ["j_dbz_gvssg"] = true,
        ["j_dbz_gvssb"] = true,
        ["j_dbz_gvuioevo"] = true,
        ["j_dbz_gvuiue"] = true,
        ["j_dbz_android1718"] = true,
        ["j_dbz_bardock"] = true,
        ["j_dbz_bojack"] = true,
        ["j_dbz_cabba"] = true,
        ["j_dbz_cauliflakale"] = true,
        ["j_dbz_chichi"] = true,
        ["j_dbz_chiaotzu"] = true,
        ["j_dbz_dabura"] = true,
        ["j_dbz_dkpiccolo"] = true,
        ["j_dbz_dyspo"] = true,
        ["j_dbz_farmershotgun"] = true,
        ["j_dbz_gotentrunks"] = true,
        ["j_dbz_supersaiyan3gotenks"] = true,
        ["j_dbz_gammas"] = true,
        ["j_dbz_masterroshi"] = true,
        ["j_dbz_pikkon"] = true,
        ["j_dbz_tien"] = true,
        ["j_dbz_whis"] = true,
        ["j_dbz_zamasu"] = true,
        ["j_dbz_android13"] = true,
        ["j_dbz_android16"] = true,
        ["j_dbz_beerus"] = true,
        ["j_dbz_drgeroandroid20"] = true,
        ["j_dbz_duukuu"] = true,
        ["j_dbz_eastsupremekaishin"] = true,
        ["j_dbz_supersaiyanrosgokublack"] = true,
        ["j_dbz_ginyu"] = true,
        ["j_dbz_guldorecoome"] = true,
        ["j_dbz_hercule"] = true,
        ["j_dbz_jeiceburter"] = true,
        ["j_dbz_jiren"] = true,
        ["j_dbz_kingcold"] = true,
        ["j_dbz_majuub"] = true,
        ["j_dbz_raditz"] = true,
        ["j_dbz_saibaman"] = true,
        ["j_dbz_senzubean"] = true,
        ["j_dbz_shenron"] = true,
        ["j_dbz_super17"] = true,
        ["j_dbz_tapion"] = true,
        ["j_dbz_toppo"] = true,
        ["j_dbz_yamcha"] = true,
        ["j_dbz_bulma"] = true,
        ["j_dbz_superperfectcell"] = true,
        ["j_dbz_cellmax"] = true,
        ["j_dbz_cooler"] = true,
        ["j_dbz_janemba"] = true,
        ["j_dbz_krillin"] = true,
        ["j_dbz_lordslug"] = true,
        ["j_dbz_majinvegeta"] = true,
        ["j_dbz_nappa"] = true,
        ["j_dbz_futuregohan"] = true,
        ["j_dbz_gohanss2"] = true,
        ["j_dbz_superbaby2"] = true,
        ["j_dbz_turles"] = true,
        ["j_dbz_brolyz"] = true,
        ["j_dbz_hit"] = true,
        ["j_dbz_omegashenron"] = true,
        ["j_dbz_awesomefuckingedittien"] = true,
        ["j_dbz_johndragonball"] = true,
        ["j_dbz_kefla"] = true,
        ["j_dbz_mergedzamasu"] = true,
        ["j_dbz_zamasucm"] = true,
        ["j_dbz_vegito"] = true,
        ["j_dbz_vegitoss"] = true,
        ["j_dbz_vegitoblue"] = true,
        ["j_dbz_gogeta"] = true,
        ["j_dbz_gogetass"] = true,
        ["j_dbz_gogeta4"] = true,
        ["j_dbz_gogetablue"] = true
    },
})

SMODS.ObjectType({
    key = "dbz_food_jokers",
    cards = {
        ["j_dbz_senzubean"] = true
    },
})

SMODS.ObjectType({
    key = "dbz_fusionpack",
    cards = {
        ["j_dbz_kefla"] = true,
        ["j_dbz_mergedzamasu"] = true,
        ["j_dbz_vegito"] = true,
        ["j_dbz_gogeta"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end