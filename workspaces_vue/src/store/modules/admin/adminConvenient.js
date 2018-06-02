import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/admin/convenients/"

const state = {
  list: [],
  createStatus: '',
  editStatus: '',
  deleteStatus: ''
}

const mutations = {
  listConvenients(state, convenients) {
    state.list = convenients
  }
}

const actions = {
  getAllConvenients(context) {
    Vue.http.get(baseUrl)
    .then((res) => {
      context.commit('listConvenients', res.body)
    })
  },
  newConvenient(context, params) {
    Vue.http.post(baseUrl, params)
    .then((res) => {
      state.createStatus = res.status
    })
  },
  deleteConvenient(context, id) {
    Vue.http.delete(baseUrl + id)
    .then((res) => {
      state.deleteStatus = res.status
    })
  },
  editConvenient(context, convenient) {
    Vue.http.put(baseUrl + convenient.convenient.id, convenient)
    .then((res) => {
      state.editStatus = res.status
    })
  }
}

export default {
 namespaced: true,
 state,
 mutations,
 actions
}