import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/admin/workspaces/"

const state = {
  list: [],
  workspaceInfo: {},
  deleteStatus: ''
}

const mutations = {
  listWorkspace(state, workspaces) {
    state.list = workspaces
  }
}

const actions = {
  getAllWorkspace(context) {
    Vue.http.get(baseUrl)
    .then((res) => {
      context.commit('listWorkspace', res.body)
    })
  },
  getDetail(context, id) {
    Vue.http.get(baseUrl + id)
    .then((res) => {
      state.workspaceInfo = res.body
    })
  },
  deleteWorkspace(context, id) {
    Vue.http.delete(baseUrl + id)
    .then((res) => {
      state.deleteStatus = res.body.status
    })
  }
}

export default {
 namespaced: true,
 state,
 mutations,
 actions
}