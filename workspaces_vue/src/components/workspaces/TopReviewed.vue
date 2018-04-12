<template>
  <div>
    <div class="top-rating">
      <div class="container">
        <div class="content">
          <div class="introduce">
            <h1 class="session-title">On-demand workspace, when you need it.</h1>
            <p class="session-content">Book a coworking space, business center, or shared office space nearby. </p>
            <p class="session-content">Discover spaces to rent by the hour, day, or month.</p>
          </div>
          <h1 class="text-center">Top reviewed Workspaces</h1>

          <b-row>
            <b-col v-for="item in top_reviewed" :key="item.id" class="workspace">
              <div class="workspace-contain" :style="{ backgroundImage: 'url(' + item.avatar + ')' }">
                <div class="card-text">
                  <h3>{{item.name}}</h3>
                  <p>{{item.city}}</p>
                  <span v-bind:class="[item.rating > 0 ? checkedStar : uncheckStar]"></span>
                  <span v-bind:class="[item.rating > 1 ? checkedStar : uncheckStar]"></span>
                  <span v-bind:class="[item.rating > 2 ? checkedStar : uncheckStar]"></span>
                  <span v-bind:class="[item.rating > 3 ? checkedStar : uncheckStar]"></span>
                  <span v-bind:class="[item.rating > 4 ? checkedStar : uncheckStar]"></span>
                  <p>( {{item.comments.length}} Reviews)</p>
                </div>
              </div>
            </b-col>
          </b-row>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'

  export default {
    data() {
      return {
        top_reviewed: [],
        rating: '',
        uncheckStar: 'fa fa-star',
        checkedStar: 'fa fa-star checked'
      }
    },
    created:  function() {
      this.topReviewed()
    },
    computed: {
      ...mapState('workspace', ['list_top_reviewed'])
    },
    methods: {
      ...mapActions({
        topReviewed: 'workspace/getTopreviewed'
      }),
    },
    watch: {
      list_top_reviewed() {
        this.top_reviewed = this.list_top_reviewed
      }
    }
  }
</script>
<style scoped>
  .top-rating {
    background-color: #F5F5F5;
  }

  .content {
    padding: 50px;
  }

  .introduce {
    padding: 50px;
    text-align: center;
  }

  .section-content {
    color: #CAC8C5;
  }

  li {
    list-style-type: none;
    width: 30%;
    height: 300px;
    background-color: white;
    float: left;
  }

  .workspace-contain {
    height: 350px;
    background-size: cover;
  }

  img{
    min-width: 100%;
    object-fit: contain;
  }

  .workspace:hover img {
    transform: scale(1.1);
  }

  .card-title,
  .card-text {
    color: white;
    text-align: center;
    font-weight: bold;
    background: rgba(88, 86, 85, 0.7);
  }

  .checked {
    color: orange;
  }
</style>
