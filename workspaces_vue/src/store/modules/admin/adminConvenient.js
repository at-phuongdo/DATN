import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/admin/"

const state = {
  list: []
}

const mutations = {
  listConvenients(state, convenients) {
    state.list = convenients
  }
}

const actions = {
  getAllConvenients(context) {
    Vue.http.get(baseUrl + 'convenients')
    .then((res) => {
      context.commit('listConvenients', res.body)
    })
  }
}

export default {
 namespaced: true,
 state,
 mutations,
 actions
}