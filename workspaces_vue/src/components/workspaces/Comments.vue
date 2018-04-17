<template>
  <div class="comments">
    <div class="workspace-review">
      <b-row>
        <b-col md="8">
          <p>Display rating</p>
        </b-col>
        <b-col>
          <b-button @click="openReviewModal">Your review</b-button>
        </b-col>
      </b-row>
    </div>
    <paginate name="commentPerPage" :list="allComments" :per="5">
      <b-row v-for="comment in allComments" :key="comment.id">
        <b-col md="2">
          <div class="info">
            <img class="avatar" :src="comment.user.avatar" v-if="comment.user.avatar">
            <img class="avatar" src="https://research.kent.ac.uk/clho/wp-content/plugins/wp-person-cpt/images/featured-default.png" width="40px" v-else>
            <p>{{comment.user.username}}</p>
          </div>
        </b-col>
        <b-col>
          <div class="comment-content">
            <h4><strong>{{comment.title}}</strong></h4>
            <p  v-html="comment.content"></p>
          </div>
        </b-col>
      </b-row>
    </paginate>
    <div class="paginate">
      <paginate-links for="commentPerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
    </div>
    <b-modal id="reviewModal" ref= "reviewModal" hide-footer hide-header>
      <b-form>
        <b-row>
          <b-col md="2">
            <span>Rating</span>
          </b-col>
          <b-col>
            
          </b-col>
        </b-row>
        <b-row>
          <b-col md="2">
            <span>Title</span>
          </b-col>
          <b-col><b-form-input></b-form-input></b-col>
        </b-row>
        <b-row >
          <b-col md="2">
            <span>Content</span>
          </b-col>
          <b-col><b-textarea></b-textarea></b-col>
        </b-row>
      </b-form>
    </b-modal>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
       currentPage: 1,
       perPage: 5,
       rating: 5,
       ratingValue: 0,
       uncheckStar: 'fa fa-star',
       checkedStar: 'fa fa-star checked',
       paginate: ['commentPerPage']
     }
   },
   created() {
    this.getAllComments(this.$route.params.name)
  },
  computed: {
    ...mapState({
      allComments:state => state.comment.listComments
    })
  },
  methods: {
    ...mapActions({
      'getAllComments': 'comment/getAllComments'
    }),
    openReviewModal: function() {
      this.$root.$emit('bv::show::modal', 'reviewModal')
    },
    setRating: function() {
      a
    }
  }
}
</script>
<style scoped>
  ul.pagination li{
    color: red;
  }

  .avatar {
    border-radius: 50%;
  }

  .comment-content {
    padding: 10px;
    border: 1px solid #28a745;
  }

  .checked {
    color: orange;
  }
</style>