<template>
  <div class="edit-comment">
    <b-modal id="editModal" ref= "editModal" hide-footer hide-header>
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
            <b-col><textarea class="content" v-model="content"></textarea></b-col>
          </b-row>
          <div class="button-control">
            <b-button @click="editComment" variant="primary" >Save</b-button>
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
    props: ['comment'],
    data() {
      return {
        ratings: 5,
        valueRating: '',
        title: '',
        content: '',
        uncheckStar: 'fa fa-star',
        checkedStar: 'fa fa-star checked'
      }
    },
    methods: {
      ...mapActions({
        'updateComment': 'comment/updateComment'
      }),
      hideModal: function() {
        this.$refs.editModal.hide()
      },
      editComment() {
       let edit_params = {
        workspace:  { name: this.$route.params.name},
        comment: {
          id: this.comment.id,
          rating: this.valueRating,
          title: this.title,
          content: this.content,
          user_id: this.comment.user_id
        }
      }
      this.updateComment(edit_params)
      this.hideModal()
    }
  },
  watch: {
    comment() {
      this.valueRating = this.comment.rating
      this.title = this.comment.title
      this.content = this.comment.content
    }
  }
}
</script>
<style>
  textarea {
    width: 100%;
  }

  .checked {
    color: orange;
  }
</style>