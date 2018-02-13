import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);
Vue.http.options.root = ""

const state = {
  currentUser: []
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
  }
}

export default {
  state,
  mutations,
  actions
}


