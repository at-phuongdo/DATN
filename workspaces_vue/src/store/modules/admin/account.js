import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/admin/"

const state = {
  loginStatus: '',
  user: {},
  list: []
}

const mutations = {
  listUser(state, users) {
    state.list = users
  }
}

const actions = {
  login(context, paramsLogin) {
    Vue.http.post(baseUrl + 'login', paramsLogin)
    .then((res) => {
      state.user = res.body
      if(res.body.status) {
        state.loginStatus = res.body.status
      }
    })
  },
  getAllAccount(context) {
    Vue.http.get(baseUrl + 'users')
    .then((res) => {
      context.commit('listUser', res.body)
    })
  }
}

export default {
 namespaced: true,
 state,
 mutations,
 actions
}