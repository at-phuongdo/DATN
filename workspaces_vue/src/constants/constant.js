const GLOBAL_CONSTS = {
  STATUS_OK: 'ok'
}

const GlobalConsts = { 
  install(Vue, options) {
    Vue.prototype.$getConst = (key) => {
      return GLOBAL_CONSTS[key]
    }
  }
}

export default GlobalConsts