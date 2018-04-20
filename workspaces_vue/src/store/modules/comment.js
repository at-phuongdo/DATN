import Vue from 'vue'
import Vuex from 'vuex'
import VueResource from 'vue-resource'

Vue.use(Vuex);
Vue.use(VueResource);

const baseUrl = "http://localhost:3000/api/v1/comments";

const state = {
  listComments: [],
  accessToken: localStorage.getItem("token"),
}

const mutations = {
  LIST_COMMENT(state,list) {
    state.listComments = list
  }
}

const actions = {
  getAllComments: function(context, workspaceName) {
    Vue.http.get(baseUrl + '?name=' + workspaceName)
    .then((res) => {
      context.commit('LIST_COMMENT',res.body)
    })
  },
  createComment: function(context, params) {
    Vue.http.post(baseUrl + '/'+ params.workspace.name, params.comment)
    .then((res) => {
      context.commit('LIST_COMMENT', res.body)
    })
  },
  updateComment(context, params) {
    Vue.http.put(baseUrl + '/'+ params.workspace.name, params.comment)
    .then((res) => {
      context.commit('LIST_COMMENT', res.body)
    })
  },
  deleteComment(context, id) {
    Vue.http.delete(baseUrl + '/' + id )
    .then((res) => {
      context.commit('LIST_COMMENT', res.body)
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}