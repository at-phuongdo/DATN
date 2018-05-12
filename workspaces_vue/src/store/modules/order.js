import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = 'http://localhost:3000/api/v1/orders/'

const state = {
  orderStatus: '',
  allOrder: [],
  orderWaiting: [],
  newOrder: {},
  rangeTime: []
}

const getters = {
  getOrderByOfficeId(state) {
    return(officeId) => state.allOrder.filter(order =>{
      return order.workspace_type_id === officeId
    })
  }
}

const mutations = {
  GET_ALL_ORDER(state, orders) {
    state.allOrder = orders
  },
  GET_WAITING_ORDER(state, orders) {
    state.orderWaiting = orders.filter((order) =>  {
      return order.status === 'waiting'
    })
  }
}

const actions = {
  getAllOrder(context, workspaceId) {
    Vue.http.get(baseUrl + workspaceId)
    .then((res) => {
      context.commit('GET_ALL_ORDER', res.body)
    })
  },
  newOrder: function(context, orderParams) {
    Vue.http.post(baseUrl, orderParams)
    .then((res) => {
     state.newOrder = res.body
     state.orderStatus = res.status
   })
  },
  getWaitingOrder: function(context, workspaceId) {
    Vue.http.get(baseUrl + workspaceId + '?status=waiting')
    .then((res) => {
      context.commit('GET_WAITING_ORDER', res.body)
    })
  },
  changeStatus(context, orderId) {
    Vue.http.post(baseUrl + orderId)
    .then((res) => {
      context.commit('GET_ALL_ORDER', res.body)
    })
  },
  declineOrder(context, orderId) {
    Vue.http.post(baseUrl + '/clear/' + orderId)
    .then((res) => {
      context.commit('GET_ALL_ORDER', res.body)
    })
  }
} 

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}