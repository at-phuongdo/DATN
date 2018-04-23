import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = 'http://localhost:3000/api/v1/orders/'

const state = {
  orderStatus: '',
  allOrder: [],
  orderWaiting: []
}

const mutations = {
}

const actions = {
  getAllOrder(context, workspaceId) {
    Vue.http.get(baseUrl + workspaceId)
    .then((res) => {
      state.allOrder = res.body
    })
  },
  newOrder: function(context, orderParams) {
    Vue.http.post(baseUrl, orderParams)
    .then((res) => {
      state.orderStatus = res.status
    })
  },
  getWaitingOrder: function(context, workspaceId) {
    Vue.http.get(baseUrl + workspaceId + '?status=waiting')
    .then((res) => {
      state.orderWaiting = res.body
    })
  },
  changeStatus(context, orderId) {
    Vue.http.post(baseUrl + orderId)
    .then((res) => {
      state.allOrder = res.body
    })
  }
} 

export default {
  namespaced: true,
  state,
  mutations,
  actions
}