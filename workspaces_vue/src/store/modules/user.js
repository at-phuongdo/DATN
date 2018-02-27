import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);
Vue.http.options.root = "http://localhost:3000/api/v1/users/"

const state = {
  currentUser: [],
  status: ''
};

const mutations = {
  CURRENT_USER(state, user) {
    state.currentUser = user
  }
}

const actions = {
  getCurrentUser({ commit }) {
    Vue.http.get('')
    .then((response) => {
      commit("CURRENT_USER", response.body)
    })
    .catch((error => {
      console.log(error.statusText)
    }))
  },
  addUser(context, newUser) {
    Vue.http.post('', newUser)
    .then((response) => {
      state.status = response.body.status
    })
    .catch((error => {
      state.status = error.statusText
    }))
  }
}

export default {
  state,
  mutations,
  actions
}


