import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/"

const state = {
  currentUser: {},
  status: '',
  isLogin: false
};

const mutations = {
  CURRENT_USER(state, user) {
    if(user) {
      state.currentUser = user
      state.isLogin = true
    }
    else {
      state.isLogin = false
    }
  },
  LOGOUT_VALUE(state) {
    state.isLogin = false
  }
}

const actions = {
  getCurrentUser({ commit }, auth_token) {
    Vue.http.get(baseUrl+ 'users/' + auth_token)
    .then((response) => {
      commit("CURRENT_USER", response.body.user)
    })
    .catch((error => {
      console.log(error.statusText)
    }))
  },
  addUser(context, newUser) {
    Vue.http.post(baseUrl + 'users', newUser)
    .then((response) => {
      state.status = response.body.status
    })
    .catch((error => {
      state.status = error.statusText
    }))
  },
  logIn(context, userLogin) {
    Vue.http.post(baseUrl + 'login', userLogin)
    .then((response) => {
      context.commit("CURRENT_USER", response.body.user)
    })
    .catch((error => {
      console.log(error.statusText)
    }))
  }
}

export default {
  state,
  mutations,
  actions
}
