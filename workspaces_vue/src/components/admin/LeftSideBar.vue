<template>
  <div class="left-sidebar" :style="styleHeight">
    <h5 class="text-center name">Coworking Spaces</h5>
    <hr>
    <ul>
      <router-link to="/admin-user"><li><span class="fa fa-user"></span> User</li></router-link>
      <router-link to="/admin-workspace"><li><span class="fa fa-home"></span> Workspace</li></router-link>
      <router-link to="/admin-convenient"><li><span class="fa fa-file"></span> Convenient</li></router-link>
      <router-link to="/admin-user"><li><span class="fa fa-photo"></span> Banner</li></router-link>
    
    </ul>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        windowHeight: ''
      }
    },
    mounted() {
      this.$nextTick(function() {
        window.addEventListener('resize', this.getWindowHeight);
        this.getWindowHeight()
      })
    },
    methods: {
      getWindowHeight(event) {
        this.windowHeight = document.documentElement.clientHeight;
      }
    },
    beforeDestroy() {
      window.removeEventListener('resize', this.getWindowHeight);
    },
    computed: {
      styleHeight() {
        return {
          height: `${this.windowHeight}px`
        }
      },
    }
  }

</script>
<style scoped>
  .left-sidebar {
    width: 15%;
    height: 100%;
    background-color: #2d3e56;
    color: white;
    position: fixed;
  }

  .name {
    padding-bottom: 20px;
  }

  ul {
    padding-left: 0;
  }

  li {
    list-style-type: none;
    padding: 0 0 5px 15px;
  }

  li:hover {
    background-color: #364960;
  }

  a {
    color: white;
  }

  a:hover {
    text-decoration: none;
  }
</style>