import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/admin/"

const state = {
  loginStatus: '',
  user: {},
  list: [],
  createStatus: '',
  editStatus: '',
  deleteStatus: ''
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
  },
  newAccount(context, userParams) {
    Vue.http.post(baseUrl + 'users', userParams)
    .then((res) => {
      state.createStatus = res.status
    })
  },
  editAccount(context, userParams) {
    Vue.http.put(baseUrl + 'users/' + userParams.user.id, userParams)
    .then((res) => {
      state.editStatus = res.status
    })
  },
  deleteAccount(context, id) {
    Vue.http.delete(baseUrl + 'users/' + id)
    .then((res) => {
      state.deleteStatus = res.status
    })
  }
}

export default {
 namespaced: true,
 state,
 mutations,
 actions
}