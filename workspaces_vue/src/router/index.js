import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/pages/Home'
import NewWorkspace from '@/pages/NewWorkspace'
import SearchResult from '@/pages/SearchResult'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/new-workspace',
      name: 'NewWorkspace',
      component: NewWorkspace
    },
    {
      path: '/search/:key',
      name: 'SearchResult',
      component: SearchResult
    }
  ]
})
