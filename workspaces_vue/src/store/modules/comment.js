import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/comments";

const state = {
  listComments: []
}

const mutations = {

}

const actions = {
  getAllComments: function(context, workspaceName) {
    Vue.http.get(baseUrl + '?name=' + workspaceName)
    .then((res) => {
      state.listComments = res.body
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}