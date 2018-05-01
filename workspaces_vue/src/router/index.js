import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/pages/Home'
import NewWorkspace from '@/pages/NewWorkspace'
import MyWorkspace from '@/pages/MyWorkspace'
import SearchResult from '@/pages/SearchResult'
import DetailPage from '@/pages/DetailPage'
import CheckOrderPage from '@/pages/CheckOrder'

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
      path: '/my-workspace',
      name: 'MyWorkspace',
      component: MyWorkspace
    },
    {
      path: '/search/:key',
      name: 'SearchResult',
      component: SearchResult
    },
    {
      path: '/:city/:name',
      name: 'DetailPage',
      component: DetailPage
    },
    {
      path: '/orders',
      name: 'CheckOrder',
      component: CheckOrderPage
    }
  ]
})
