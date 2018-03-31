import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/workspaces"

const state = {
  list_top_reviewed: []
}

const mutations = {
  TOP_REVIEWED(state, workspaces) {
    state.list_top_reviewed = workspaces
  }
}

const actions = {
  getTopreviewed: function(context) {
    Vue.http.get(baseUrl + '?key=top_reviewed')
    .then((response) => {
      context.commit('TOP_REVIEWED', response.body.workspaces)
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

