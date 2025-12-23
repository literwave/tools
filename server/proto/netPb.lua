local define = {
    Build = {
        s2c_req_all_build_end = 256,
        s2c_sync_build = 257,
        c2s_create_build = 258,
        c2s_up_build = 259
    },
    Chat = {
        c2sChat = 260,
        s2cChat = 261
    },
    Heartbeat = {
        c2s_heart_beat = 262,
        s2c_heart_beat = 263
    },
    Hero = {
        s2c_sync_hero_base_info = 264,
        c2s_req_all_hero_base_info = 265,
        s2c_req_all_hero_base_info = 279
    },
    Login = {
        c2s_user_login = 266,
        s2c_user_login = 267,
        c2s_verify_login = 268,
        s2c_verify_login = 269,
        s2c_user_login_ok = 271
    },
    User = {
        s2c_user_create = 270,
        c2s_user_base_info = 274,
        s2c_user_base_info = 275,
        c2s_user_create = 276,
        c2s_req_user_res = 277,
        s2c_req_user_res = 278
    },
    Reward = {
        s2c_show_reward = 272,
        s2c_sync_user_diamond = 273
    }
}
ID_TO_PACK_NAME = {}
PTONAME_TO_ID = {}
PACK_NAME_TO_ID = {}
ID_TO_PTONAME = {} -- 这里需要优化，其实就只有客户端发给后端才需要这个数据
for_maker = {}
for_caller = {}
	
local function initPto()
	for mod, packTbl in pairs(define) do
		for ptoName, id in pairs(packTbl) do
			local packName = mod .. "." .. ptoName
			ID_TO_PACK_NAME[id] = packName
			PTONAME_TO_ID[ptoName] = id
			PACK_NAME_TO_ID[packName] = id
			ID_TO_PTONAME[id] = ptoName
		end
	end
end

initPto()
