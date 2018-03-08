import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/"

const state = {
  currentUser: {},
  status: '',
  isLogin: false,
  newUser: {}
};

const mutations = {
  CURRENT_USER(state, user) {
    if(user) {
      state.currentUser = user
      if (state.status === 'ok') {
        state.isLogin = true
      }
      else {
        state.isLogin = false
      }
    }
    else {
      state.isLogin = false
    }
  },
  LOGOUT_VALUE(state) {
    state.currentUser = {}
    state.isLogin = false
  }
}

const actions = {
  getCurrentUser({ commit }, auth_token) {
    Vue.http.get(baseUrl+ 'users/' + auth_token)
    .then((response) => {
      state.status = response.body.status
      commit("CURRENT_USER", response.body.user)
    })
    .catch((error => {
      console.log(error.statusText)
    }))
  },
  addUser(context, newUser) {
    Vue.http.post(baseUrl + 'users', newUser)
    .then((response) => {
      state.newUser = response.body.user
      state.status = response.body.status
    })
    .catch((error => {
      state.status = error.statusText
    }))
  },
  logIn(context, userLogin) {
    Vue.http.post(baseUrl + 'login', userLogin)
    .then((response) => {
      state.status = response.body.status
      context.commit("CURRENT_USER", response.body.user)
    })
    .catch((error => {
      console.log(error.statusText)
    }))
  },
  confirmEmail(context, auth_token, code) {
    Vue.http.post(baseUrl+ 'users/' + auth_token + '/confirm')
    .then((response) => {
      state.status = response.body.status
      context.commit("CURRENT_USER", response.body.user)
    })
  }
}

export default {
  state,
  mutations,
  actions
}