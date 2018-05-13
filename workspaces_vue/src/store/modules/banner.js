import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/banners"

const state = {
  listBanner : []
}

const actions = {
  getBanner(context) {
    Vue.http.get(baseUrl)
    .then((res) => {
      state.listBanner = res.body
    })
  }
}
export default {
  namespaced: true,
  state,
  actions
}