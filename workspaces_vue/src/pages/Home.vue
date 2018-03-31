;l<template>
  <div>
    <banner-app></banner-app>
    <top-reviewed></top-reviewed>
  </div>
</template>
<script>
  import Banner from '../components/Banner.vue'
  import TopReviewed from '../components/workspaces/TopReviewed.vue'
  export default {
    components: {
      'banner-app' : Banner,
      'top-reviewed' : TopReviewed
    }
  }
</script>
