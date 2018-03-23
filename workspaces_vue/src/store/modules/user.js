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
      if (state.status === Vue.prototype.$getConst('STATUS_OK')) {
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
  addUser: async function(context, newUser) {
    await Vue.http.post(baseUrl + 'users', newUser)
    .then((response) => {
      state.newUser = response.body.user
      state.status = response.body.status
      state.message = response.body.message
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
  confirmEmail: async function(context,code) {
    await Vue.http.post(baseUrl + 'users/' + code + '/confirm')
    .then((response) => {
      state.status = response.body.status
      context.commit("CURRENT_USER", response.body.user)
    })
  },
  sendEmailToReset: async function(context, email) {
    await Vue.http.post(baseUrl + 'reset_passwords', email)
    .then((response) => {
      state.status = response.body.status
    })
  },
  resetPassword: async function(context, params ){
    await Vue.http.put(baseUrl + 'reset_passwords/' + params.token, params)
    .then((response) => {
      state.status = response.body.status
      context.commit("CURRENT_USER", response.body.user)
    })
  },
  loginFacebook: async function( context, newUser ){
    await Vue.http.post(baseUrl + 'login_facebook', newUser)
    .then((response) => {
      state.status = response.body.status
      context.commit("CURRENT_USER", response.body.user)
    })
  },
  registerEmailFacebook: async function(context, user) {
    state.status = "ok"
    context.commit("CURRENT_USER", user)
  }
}

export default {
  state,
  mutations,
  actions
}
