import Vue from 'vue';
import Vuex from 'vuex';
import user from './modules/user.js';
import workspace from './modules/workspace.js';
import convenient from  './modules/convenient.js';
import comment from  './modules/comment.js';
import order from './modules/order.js'
import VeeValidate from 'vee-validate';

Vue.use(VeeValidate);

Vue.use(Vuex)

export const store = new Vuex.Store({
  state: {},
  mutations: {},
  actions: {},
  modules: { 
    user,
    workspace,
    convenient,
    comment,
    order
  }
})