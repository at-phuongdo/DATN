import Vue from 'vue';
import Vuex from 'vuex';
import user from './modules/user.js';
import VeeValidate from 'vee-validate';

Vue.use(VeeValidate);

Vue.use(Vuex)

export const store = new Vuex.Store({
  state: {},
  mutations: {},
  actions: {},
  modules: { user }
})