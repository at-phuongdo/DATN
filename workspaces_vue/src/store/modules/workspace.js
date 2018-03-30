import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/workspaces"
const CLOUDINARY_URL = "https://api.cloudinary.com/v1_1/dophuong/upload"
const COUNDINARY_UPLOAD_PRESET = "kbtjckge"

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
  },

  uploadImage: function(context, form) {
    Vue.http.post(CLOUDINARY_URL, form)
    .then(function(res) {
      console.log(res)
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

