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
  listWorkspace(state, workspaces) {
    state.list = workspaces
  }
}

const actions = {
  getAllWorkspace(context) {
    Vue.http.get(baseUrl + 'workspaces')
    .then((res) => {
      context.commit('listWorkspace', res.body)
    })
  }
}

export default {
 namespaced: true,
 state,
 mutations,
 actions
}