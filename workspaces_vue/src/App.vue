  <!-- // <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
  <template>
    <div id="app">
      <header-app></header-app>
      <router-view/>
      <footer-app></footer-app>
    </div>
  </template>

  <script>
    import Header from './components/Header.vue'
    import Footer from './components/Footer.vue'
    export default {
      components: {
        'header-app' : Header,
        'footer-app' : Footer
      },
      name: 'App'
    }
  </script>

  <style>
    #app {
      font-family: 'Avenir', Helvetica, Arial, sans-serif;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      color: #2c3e50;
    }
    .row {
      margin-right: 0;
    }
  </style>
