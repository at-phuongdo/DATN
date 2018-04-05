import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/workspaces"
const CLOUDINARY_URL = "https://api.cloudinary.com/v1_1/dophuong/upload"
const COUNDINARY_UPLOAD_PRESET = "kbtjckge"

const state = {
  list_top_reviewed: [],
  listPhotos: [],
  avatar: '',
  accessToken: localStorage.getItem("token")
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

  uploadPhotos: async function(context, listPhotos) {
    var allPhoto = []
    var formData = new FormData()
    for (var i = 0; i < listPhotos.length; i++) {
      formData.append('file', listPhotos[i])
      formData.append('upload_preset', COUNDINARY_UPLOAD_PRESET)
      await Vue.http.post(CLOUDINARY_URL, formData)
      .then(function(res) {
        allPhoto.push(res.body.secure_url)
      })
      if (i === listPhotos.length - 1) {
        console.log('ok')
        state.listPhotos = allPhoto
      }
    }
  },
  addNew: function(context, data) {
    Vue.http.post(baseUrl, data, {
      headers: {
        'AccessToken' : state.accessToken
      }
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

