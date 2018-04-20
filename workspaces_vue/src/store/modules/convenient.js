import Vue from 'vue';
import Vuex from 'vuex';
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = 'http://localhost:3000/api/v1/convenients'

const state = {
  listConvenient : []
}

const mutations = {
  LIST_ALL_CONVENIENT(state, convenients) {
    state.listConvenient = convenients
  }
}

const actions = {
  getAllConvenient: function(context) {
    Vue.http.get(baseUrl)
    .then((res) => {
      context.commit('LIST_ALL_CONVENIENT', res.body.convenients)
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}