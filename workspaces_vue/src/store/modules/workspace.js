import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/workspaces"
const CLOUDINARY_URL = "https://api.cloudinary.com/v1_1/dophuong/upload"
const CLOUNDINARY_UPLOAD_PRESET = "kbtjckge"

const state = {
  todos: [
  {id: 1, value: 'Description'},
  {id: 2, value: 'Contact'},
  {id: 3, value: 'Location'},
  {id: 4, value: 'Amenities'},
  {id: 5, value: 'Room'},
  {id: 6, value: 'Opening hours'},
  {id: 7, value: 'Price'},
  {id: 8, value: 'Photos'}
  ],
  priceTypes: [
  { name : 'hour', price: 0 },
  { name : 'day', price: 0 },
  { name : 'week', price: 0 },
  { name : 'month', price: 0 },
  { name : 'year', price: 0 }
  ],
  unit: [
  {text: 'VND', value: 'vnd'},
  {text: 'USD', value: 'usd'}
  ],
  openingHours: [
  { day: 'open_mon', open: '', close: '', text: 'Monday'},
  { day: 'open_tue', open: '', close: '', text: 'Tuesday'},
  { day: 'open_wed', open: '', close: '', text: 'Wednesday'},
  { day: 'open_thurs', open: '', close: '', text: 'Thursday'},
  { day: 'open_fri', open: '', close: '', text: 'Friday'},
  { day: 'open_sat', open: '', close: '', text: 'Saturday'},
  { day: 'open_sun', open: '', close: '', text: 'Sunday'},
  ],
  list_top_reviewed: [],
  listPhotos: [],
  avatar: '',
  accessToken: localStorage.getItem("token"),
  listWorkspaces : []
}

const mutations = {
  TOP_REVIEWED(state, workspaces) {
    state.list_top_reviewed = workspaces
  },
  LIST_WORKSPACE(state, workspaces) {
    state.listWorkspaces = workspaces
  }
}

const actions = {
  getTopreviewed: function(context) {
    Vue.http.get(baseUrl + '?key=top_reviewed')
    .then((response) => {
      context.commit('TOP_REVIEWED', response.body)
    })
  },

  uploadPhotos: async function(context, listPhotos) {
    var allPhoto = []
    var formData = new FormData()
    for (var i = 0; i < listPhotos.length; i++) {
      formData.append('file', listPhotos[i])
      formData.append('upload_preset', CLOUNDINARY_UPLOAD_PRESET)
      await Vue.http.post(CLOUDINARY_URL, formData)
      .then(function(res) {
        allPhoto.push(res.body.secure_url)
      })
      if (i === listPhotos.length - 1) {
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
    .then((res) => {

    })
  },
  searchByLocation: function(context, searchKey) {
    Vue.http.post(baseUrl + '/search/'+ searchKey)
    .then((res) => {
      context.commit('LIST_WORKSPACE', res.body)
    })
  },
  searchByName: function() {

  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}
