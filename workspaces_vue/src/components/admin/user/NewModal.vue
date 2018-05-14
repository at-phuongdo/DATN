<template>
  <div>
    <b-modal id="newModal" ref="newModal" hide-footer title="New user">
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="User name"
      label-for="user-name">
        <b-form-input class="sm" v-validate="'required|min:6'" name="username" type="text" v-model="username"></b-form-input>
          <span v-show="errors.has('username')" class="is-danger">{{ errors.first('username') }}</span>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="First name"
      label-for="first-name">
        <b-form-input id="first-name" v-model="firstName" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Last name"
      label-for="last-name">
        <b-form-input id="last-name" v-model="lastName" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Birthday"
      label-for="birthday">
        <b-form-input type="date" id="birthday" v-model="birthday" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Email"
      label-for="email">
        <b-form-input class="sm" v-validate="'required|email'" name="email" v-model="email" type="text"></b-form-input>
          <span v-show="errors.has('email')" class="is-danger">{{ errors.first('email') }}</span>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Phone"
      label-for="phone">
        <b-form-input id="phone" type="number" size="sm" v-model="phone"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Role"
      label-for="role">
        <b-form-select id="role" :options="roleList" v-model="role" class="mb-3" />
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Gender"
      label-for="gender">
        <b-form-radio-group id="radios" v-model="gender" :options="genderList">
      </b-form-radio-group>
      </b-form-group>
      <div class="btn-control">
        <b-btn variant="primary" @click="createUser">Save</b-btn>
        <b-btn variant="danger" @click="hideModal">Cancel</b-btn>
      </div>
    </b-modal>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        username: '',
        firstName: '',
        lastName: '',
        birthday: '',
        email: '',
        phone: '',
        role: null,
        gender: '',
        roleList: [
          {value: 'user', text: 'User'},
          {value: 'partner', text: 'Partner'},
          {value: 'admin', text: 'Admin'}
        ],
        genderList: [
          {value: 'male', text: 'male'},
          {value: 'female', text: 'female'}
        ],
      }
    },
    computed: {
      ...mapState({
        createStatus:state => state.account.createStatus
      })
    },
    methods: {
      ...mapActions({
        'newAccount': 'account/newAccount',
        'fetch': 'account/getAllAccount'
      }),
      createUser() {
        this.newAccount({'user': {
          username: this.username,
          first_name: this.firstName,
          last_name: this.lastName,
          birthday: this.birthday,
          email: this.email,
          phone: this.phone,
          role: this.role,
          gender: this.gender
        }})
        this.hideModal()
      },
      hideModal() {
        this.$refs.newModal.hide()
      }
    },
    watch: {
      createStatus() {
        this.fetch()
      }
    }
  }
</script>
<style>
  #newModal {
    padding: 20px;
  }

  .modal-body {
    padding: 2rem;
  }

  .btn-control {
    float: right
  }

  .is-danger {
    color: red;
    font-style: italic;
    font-size: 0.8em;
  }
</style>