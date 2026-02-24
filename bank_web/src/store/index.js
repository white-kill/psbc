import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        token: '', // 登录token
        userInfo: {}, // 用户信息
    },
    getters: {},
    mutations: {
        init_token(state, payload) { // 改变token
            state.token = payload.token
        },
        init_user_info(state, payload) {
            state.userInfo = payload.userInfo
        },
    },
    actions: {},
    modules: {},
    plugins: [createPersistedState()]
})
