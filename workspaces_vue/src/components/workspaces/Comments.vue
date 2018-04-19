<template>
  <div class="comments">
    <div class="workspace-review">
      <b-row>
        <b-col md="8">
          <p>Display rating</p>
        </b-col>
        <b-col>
        <b-button class="btn-comment" variant="success" @click="openReviewModal">Your review</b-button>
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
      <div class="text-center">
        <b-form>
          <h1><span class="decorate-span">What do you think about us?</span></h1>
          <b-row>
            <b-col md="2">
              <span>Rating</span>
            </b-col>
            <b-col>
              <span v-for="currentRating in ratings" :key="currentRating" :class="[valueRating >= currentRating ? checkedStar : uncheckStar ]" v-on:click="set(currentRating)"></span>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="2">
              <span>Title</span>
            </b-col>
            <b-col><b-form-input v-model="title" required></b-form-input></b-col>
          </b-row>
          <b-row >
            <b-col md="2">
              <span>Content</span>
            </b-col>
            <b-col><div class="content" contenteditable="true" @input="targetHTML"></div></b-col>
          </b-row>
          <div class="button-control">
            <b-button @click="saveComment" variant="primary" >Save</b-button>
            <b-btn variant="danger" @click="hideModal" >Close</b-btn>
          </div>
        </b-form>
      </div>
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
       ratings: 5,
       averageRating: null,
       valueRating: 0,
       uncheckStar: 'fa fa-star',
       checkedStar: 'fa fa-star checked',
       paginate: ['commentPerPage'],
       title: '',
       content: ''

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
      'getAllComments': 'comment/getAllComments',
      'addNewComment': 'comment/createComment'
    }),
    openReviewModal: function() {
      this.$root.$emit('bv::show::modal', 'reviewModal')
    },
    set: function(value) {
      return this.valueRating = value;
    },
    saveComment: function() {
      var comment_params = {
        workspace:  { name: this.$route.params.name},
        comment: {
          rating: this.valueRating,
          title: this.title,
          content: this.content
        }
      }
      this.addNewComment(comment_params)
      this.hideModal()
    },
    hideModal: function() {
      this.$refs.reviewModal.hide()
    },
    targetHTML: function(e) {
      this.content = e.target.innerHTML
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

  .content {
    border: 1px solid #ced4da;
    text-align: left;
  }

  .checked {
    color: orange;
  }

  .fa {
    padding-top: 0;
  }

  .btn-comment {
    float: right;
  }

  .button-control {
    float: right;
    padding-right: 15px;
  }

  .paginate {
    clear: both;
    display: table;
    margin: auto;
  }
</style>